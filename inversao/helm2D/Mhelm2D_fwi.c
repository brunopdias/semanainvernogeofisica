/* 2D Frequency Domain Full Waveform Inversion. */
/*
  Copyright (C) 2012 University of Texas at Austin

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program; if not, write to the Free Software
  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

#include <rsf.h>
#include <rsfpwd.h>

#include <umfpack.h>

#ifdef _OPENMP
#include <omp.h>
#endif

#include "fdprep.h"
#include "sparsesolver.h"
#include "optimization.h"
#include "waveoperator.h"

int main(int argc, char* argv[])
{

    bool hermite_false, hermite_true, precond;
    int n1, n2, npml, pad1, pad2, ns, nw, radius, verb;
    float d1, d2, ds, os, dw, ow;
    double omega;
    sf_complex ***f, ***obs;
    sf_file in, out, source, receiver, record, dip, grad;
    char *order;
    int uts, mts, i, j, k, iw, niter, iter;
    float **cur_grad, **pre_grad, **cur_dir, **pre_dir;
    float *cur_grad_input, *cur_grad_smooth, *cur_grad_smooth2;
    float misfit,misfit0, misfit1, misfit2, misfitold, beta, alpha, alpha0;
    float **v, **vnew, **slope, **recloc;

    sf_init(argc, argv);

    in = sf_input("in");
    out = sf_output("out");

    if (!sf_getint("verb",&verb)) verb=1;
    
    if (!sf_getint("niter",&niter)) niter=0;

    if (!sf_getint("uts",&uts)) uts=0;
#ifdef _OPENMP
    mts = omp_get_max_threads();
#else
    mts = 1;
#endif
    uts = (uts < 1)? mts: uts;
    if (verb >0) sf_warning("Using %d out of %d threads.",uts,mts);

    hermite_false=false;
    hermite_true=true;
    /* Hermite operator */

    if (!sf_getint("npml",&npml)) npml=20;
    /* PML width */

    if (NULL == (order = sf_getstring("order"))) order="j";
    /* discretization scheme (default optimal 9-point) */

    fdprep_order(order);

    /* read input dimension */
    if (!sf_histint(in,"n1",&n1)) sf_error("No n1= in input.");
    if (!sf_histint(in,"n2",&n2)) sf_error("No n2= in input.");

    if (!sf_histfloat(in,"d1",&d1)) sf_error("No d1= in input.");
    if (!sf_histfloat(in,"d2",&d2)) sf_error("No d2= in input.");

    v = sf_floatalloc2(n1,n2);
    vnew = sf_floatalloc2(n1,n2);
    sf_floatread(v[0],n1*n2,in);

	/* PML padding */
	pad1 = n1+2*npml;
	pad2 = n2+2*npml;

    /* read receiver */
    if (NULL == sf_getstring("receiver")) sf_error("Need receiver=");
    receiver = sf_input("receiver");
    recloc = sf_floatalloc2(n1,n2);
    sf_floatread(recloc[0],n1*n2,receiver);

    /* read source */
    if (NULL == sf_getstring("source")) sf_error("Need source=");
    source = sf_input("source");

    if (!sf_histint(source,"n3",&ns)) sf_error("No ns=.");
    if (!sf_histfloat(source,"d3",&ds)) ds=d2;
    if (!sf_histfloat(source,"o3",&os)) os=0.;

    f = sf_complexalloc3(n1,n2,ns);

    if (NULL == sf_getstring("record")) sf_error("Need record=");
    record = sf_input("record");

    if (!sf_histint(record,"n4",&nw)) sf_error("No nw=.");
    if (!sf_histfloat(record,"d4",&dw)) sf_error("No dw=.");
    if (!sf_histfloat(record,"o4",&ow)) sf_error("No ow=.");


    if (!sf_getfloat("alpha0",&alpha0)) alpha0=0.001; /* initial step-lenght */

    /* read in slope information */
    if (!sf_getbool("precond",&precond)) precond=false;
    if (precond) {
        if (NULL == sf_getstring("dip")) sf_error("Need dip=");
        dip = sf_input("dip");
        slope = sf_floatalloc2(n1,n2);
        sf_floatread(slope[0],n1*n2,dip);

        if (!sf_getint("radius",&radius)) sf_error("Need radius=");
        cur_grad_input = sf_floatalloc(n1*n2);
        cur_grad_smooth = sf_floatalloc(n1*n2);
        cur_grad_smooth2 = sf_floatalloc(n1*n2);
    }

    /* output gradient (optional) */
    if (NULL != sf_getstring("grad")) {
      grad = sf_output("grad");
      sf_putint(grad,"n1",n1);
      sf_putint(grad,"n2",n2);
      sf_putint(grad,"n3",niter*nw);
    }

    sf_putint(out,"n1",n1);
    sf_putint(out,"n2",n2);
    sf_putint(out,"n3",niter*nw);

    obs = sf_complexalloc3(n1,n2,ns);
    cur_grad = sf_floatalloc2(n1,n2);
    cur_dir = sf_floatalloc2(n1,n2);
    pre_grad = sf_floatalloc2(n1,n2);
    pre_dir = sf_floatalloc2(n1,n2);

    /* Loop over frequency */
    for ( iw = 0; iw < nw; iw ++ ) {
        omega=(double) 2.*SF_PI*(ow+iw*dw);

        if (verb > 0) sf_warning("Calculating frequency %d out of %d for %f HZ.\n",iw+1,nw,ow+iw*dw);

        sf_complexread(f[0][0],n1*n2*ns,source);
        sf_complexread(obs[0][0],n1*n2*ns,record);

        misfitold = 100000000.0;
        iter = 0;
        while (iter < niter) {
			if (verb > 1) sf_warning("Calculating %d out of %d iteration", iter+1, niter);

            misfit0 = adjfwi_operator(uts, pad1, pad2, omega, n1, n2, d1, d2,
                                      npml, ns, f, obs, hermite_false, hermite_true, recloc,
                                      v, cur_grad);

	    /* output gradient (optional) */
	    if (NULL != sf_getstring("grad")) {
	      sf_floatwrite(cur_grad[0],n1*n2,grad);
	    }
	    
            /* Preconditioning or regularization */
            if (precond) {
                if (verb > 1) sf_warning("Preconditioning gradient.");

                /* change from 2D array to 1D */
                k=0;
                for (j=0;j<n2;j++) {
                for (i=0;i<n1;i++) {
                    cur_grad_input[k]=cur_grad[j][i];
                    k=k+1;
                }
                }
                //pwsmooth_init(radius, n1, n2, 5, 0.01, slope);
                pwsmooth_set(slope);
                pwsmooth_lop(true,false,n1*n2,n1*n2,cur_grad_smooth,cur_grad_input);  /* adjoint of pwspray */
                pwsmooth_lop(false,false,n1*n2,n1*n2,cur_grad_smooth,cur_grad_smooth2);  /* forward of pwspray */
                /* reset cur_grad to smooth version */
                k=0;
                for (j=0; j<n2;j++) {
                for (i=0; i<n1; i++) {
                    cur_grad[j][i]=cur_grad_smooth2[k];
                    /* cur_grad[j][i]=cur_grad_smooth[k]; */
                    k=k+1;
                }
                }
            }

            /* calculate direction */
            if (iter == 0) {
                direction_sd(cur_grad,cur_dir,n1,n2);
                beta = 0.0;
            } else {
                beta = direction_cg_polak(pre_grad, pre_dir, cur_grad, cur_dir, n1, n2);
            }
            if (verb > 1) sf_warning("Finish direction calculation.");


            /* test model 1 */
            update_model_fwi(v,vnew,cur_dir,0.1,n1,n2);

            misfit1 = forward_operator(uts, pad1, pad2, omega, n1, n2, d1, d2,
                                       npml, ns, f, obs, hermite_false, recloc,
                                       vnew);

            if (verb > 1) sf_warning("Finish test1 calculation.");

            /* test model 2 */
            update_model_fwi(v,vnew,cur_dir,0.2,n1,n2);

            misfit2 = forward_operator(uts, pad1, pad2, omega, n1, n2, d1, d2,
                                       npml, ns, f, obs, hermite_false, recloc,
                                       vnew);

            if (verb > 1) sf_warning("Finish test2 calculation.");

            /* update model, quadratic fit */
            alpha = (misfit2-4.0*misfit1+3.0*misfit0)/(20.0*(misfit2-2.0*misfit1+misfit0));
            if ( alpha < 0.0  ) {
                alpha = alpha0;
                if (verb > 0) sf_warning("alpha is smaller than 0.0");
            } else if (alpha > 0.2) {
              alpha = 0.2;
              if (verb > 0) sf_warning("alpha is greater then 0.2");
            }

	    /* test alpha */
	    update_model_fwi(v,vnew,cur_dir,alpha,n1,n2);
	    misfit = forward_operator(uts, pad1, pad2, omega, n1, n2, d1, d2,
                                       npml, ns, f, obs, hermite_false, recloc,
                                       vnew);

            if (verb > 0) sf_warning("In iteration %d, alpha = %f, beta = %e, misfit0 = %e., misfit = %e",
		       iter+1,alpha,beta,misfit0,misfit);

            if ( misfit > misfitold ) {
                if (verb > 0) sf_warning("Reducing step lenght %d.",iter);
		alpha *= 0.5;
            } else {

                update_model_fwi(v,vnew,cur_dir,alpha,n1,n2);
                for (j=0; j<n2; j++ ) {
                for (i=0; i<n1; i++ ) {
                    v[j][i]=vnew[j][i];
                    pre_grad[j][i]=cur_grad[j][i];
                    pre_dir[j][i]=cur_dir[j][i];
                }
                }
                misfitold=misfit0;
            }
	    iter++;
            sf_floatwrite(v[0],n1*n2,out);

        }  /* end iteration */
        if (verb > 0) sf_warning("Ending frequency %d out of %d for %f HZ.\n\n",iw+1,nw,ow+iw*dw);

    } /* end frequency */

    free(*v); free(v);
    free(*vnew); free(vnew);
    free(*recloc); free(recloc);
    free(**f); free(*f); free(f);

    if (precond) {
      free(*slope); free(slope);
      free(cur_grad_input);
      free(cur_grad_smooth);
      free(cur_grad_smooth2);
    }

    free(**obs); free(*obs); free(obs);
    free(*cur_grad); free(cur_grad);
    free(*cur_dir); free(cur_dir);
    free(*pre_grad); free(pre_grad);
    free(*pre_dir); free(pre_dir);

    exit(0);
}
