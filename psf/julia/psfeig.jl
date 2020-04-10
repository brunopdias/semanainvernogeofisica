module psfeig

export bluker, psf_to_matrix

function bluker(k::N, sigma::F, T=Float64)::AbstractArray{T,2} where
    {N<:Integer,F<:AbstractFloat}

    M = zeros(T, 2*k + 1, 2*k + 1);

    for j=-k:k
        for i=-k:k
          M[i+k+1,j+k+1] = (1.0/(2*pi*sigma^2))*exp(-(i^2+j^2)/(2*sigma^2));
        end
    end

    return M
end

"""
    Version with 1 psf
"""
function psf_to_matrix(n::N, P::AbstractArray{T,2})::AbstractArray{Float64,2} where
    {N<:Integer,T<:AbstractFloat}

    # Verify inputs
    @assert( size(P,1) == size(P,2), "expecting square psf")
    @assert( size(P,1)%2==1, "expecting odd size psf")

    # PSF half-size
    k = div(size(P,1)-1,2)

    # Fill the columns of G
    G = zeros(Float64, n*n, n*n)

    # Spatial position loop
    for j2=1:n, j1=1:n
        J = (j2 - 1)*n + j1

        # PSF loop
        for k2=-k:k, k1=-k:k
            i1 = j1 + k1
            i2 = j2 + k2
            if i1 > 0 && i1 <= n && i2 > 0 && i2 <= n
                I = (i2 - 1)*n + i1
                G[I,J] = P[k1+k+1, k2+k+1]
            end
        end
    end
    return G
end # psf_to_matrix

"""
    Version with 4 psfs linearly interpolated s
"""
function psf_to_matrix(n::N,
                       P1::AbstractArray{T,2},
                       P2::AbstractArray{T,2},
                       P3::AbstractArray{T,2},
                       P4::AbstractArray{T,2} )::AbstractArray{Float64,2} where
        {N<:Integer,T<:AbstractFloat}

    # Verify inputs
    s = size(P1)
    @assert( size(P1,1)%2==1, "expecting odd size psf")
    @assert( size(P1,1) == size(P1,2), "expecting square psf")
    @assert( size(P2) == s, "P2 should be the same size as P1" )
    @assert( size(P3) == s, "P3 should be the same size as P1" )
    @assert( size(P4) == s, "P4 should be the same size as P1" )

    # PSF half-size
    k = div(size(P1,1)-1,2)

    # Fill the columns of G
    G = zeros(Float64, n*n, n*n)

    # Spatial position loop
    for j2=1:n, j1=1:n
        J = (j2 - 1)*n + j1

        a1 = (j1 - 1) * (j2 - 1) / (n-1)^2
        a2 = (n - j1) * (j2 - 1) / (n-1)^2
        a3 = (j1 - 1) * (n - j2) / (n-1)^2
        a4 = (n - j1) * (n - j2) / (n-1)^2

        # PSF loop
        for k2=-k:k, k1=-k:k
            i1 = j1 + k1
            i2 = j2 + k2
            if i1 > 0 && i1 <= n && i2 > 0 && i2 <= n
                I = (i2 - 1)*n + i1
                G[I,J] = a1 * P1[k1+k+1, k2+k+1] + 
                         a2 * P2[k1+k+1, k2+k+1] + 
                         a3 * P3[k1+k+1, k2+k+1] + 
                         a4 * P4[k1+k+1, k2+k+1]
            end
        end
    end
    return G
end # psf_to_matrix


mutable struct Psf{T<:AbstractFloat, N<:Integer}
    val::Array{T,3}
    pos::Array{N,2}
end

"""
    Extract psfs from image input
"""
function psf_chop(img::Array{T,2},
                  b1::N, b2::N,    # psf spacing
                  k1::N, k2::N,    # begin
                  l1::N, l2::N     # end
                  ) where {T<:AbstractFloat, N<:Integer}
    
    n1, n2 = size(img)

    nsp = length( collect( k1:b1:l1 ) ) * length( collect( k2:b2:l2 ) )

    h1 = div(b1, 2)
    h2 = div(b2, 2)

    psf = Psf(zeros(T, 2*h1+1, 2*h2+1, nsp),
              zeros(N, 2, nsp))

    isp = 1
    for i2 = k2:b2:l2
    for i1 = k1:b1:l1

        il1 = min(n1, max(1, i1-h1))
        iu1 = min(n1, max(1, i1+h1))

        il2 = min(n2, max(1, i2-h2))
        iu2 = min(n2, max(1, i2+h2))

        idx1 = il1:iu1
        idx2 = il2:iu2

        jdx1 = 1:length(idx1)
        jdx2 = 1:length(idx2)

        psf.val[jdx1, jdx2, isp] = img[idx1,idx2]
        psf.pos[:, isp] = [i1,i2]
        
        isp += 1

    end
    end

    # Treat amplitude encoding
    for i = 1:nsp
        p = argmax(abs.(psf.val[:,:,i]))
        psf.val[:,:,i] *= sign( psf.val[:,:,i][p] )
    end
    
    return psf
end # psf_chop

end # module