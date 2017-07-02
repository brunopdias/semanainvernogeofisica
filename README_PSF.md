Point Spread Function: Aplicações na Geofísica
================================================
**VIII Semana de Inverno de Geofísica: 19 a 21 de Julho/2017 — INCT-GP, UNICAMP, Campinas, SP**

**André Bulcão, Bruno Pereira Dias e Djalma Manoel Soares Filho**

![Point Spread Function](figures/psf.png)

---------------------------------

Ementa do Curso
---------------

#### Dia 1

- **Módulo 1:** Introdução & Motivação
  - Definição e Aplicações
  - Casos da Literatura
  - Revisão do Método Sísmico
  - Modelagem Sismica
    - Diferenças Finitas, Traçado de Raio
    - Elasticidade, Anisotropia, Absorção
  - Migração Sísmica: RTM , Kirchhoff , outros


- **Módulo 2:** [Cálculo da PSF](psf/m8r)
   - Traçado de Raio + Filtro KK
   - Modelagem de Born + Migração (RTM)
   - Modelagem por Ponto Focal

#### Dia 2

- **Módulo 3:** [Inversão com PSF](psf/octave)
  - Modelo Linear de Desfocalização
  - Convolução unidimensional e multidimensional
  - Deconvolução multidimensional
  - Operadores Lineares e Operador Adjunto
  - Métodos Iterativos de Inversão Linear
    - Método do Conjugado Gradiente
    - Método do Conjugado Gradiente Quadrados Mínimos
    - Outros Métodos (LSQR, LSMR...)
  - Técnicas de Regularização
    - Regularização de Tikhonov
    - Vínculos de Esparsidade


- **Módulo 4:** Exemplos de Aplicações
  - Iluminação e suporte à interpretação pela análise das PSFs
  - Modelagem da resposta sísmica
  - Estudo de Viabilidade 4D
  - Least Squares Migration Image Domain (LSM-ID)
    - Acústico
    - Pré-empilhamento
    - Inversão 4D
    - Correção da Atenuação
    - Elástico


---------------------------------

Referências
-----------

**Livros**

* ASTER, R.C., BORCHERS, B., THURBER, C. H., *Parameter Estimation and Inverse Problems*. 2a. Ed. Elsevier: 2013.

* HANSEN, P. C., NAGY, J. G., O'LEARY, D. P., *Deblurring Images: Matrices, Spectra, and Filtering*. 1a. Ed. SIAM: 2006.

* JANSSON, A. P., *Deconvolution of Images and Spectra*. 2a. Ed. Academic Press: 1996.

**Artigos**

* HU, J., SCHUSTER, G. T., VALASEK, P. A., *Poststack migration deconvolution*. Geophysics, v.66, no.3, 2001.

* LECOMTE, I., *Resolution and illumination analyses in PSDM: A ray-based approach*. The Leading Edge, May 2008.

* LETKI, L., TANG, J., INYANG, C., DU, X., FLETCHER, R., *Depth domaing inversion to improve the fidelity of subsalt imaging: a Gulf of Mexico case study*. First Break, v.33, September, 2015.

* FLETCHER, R., NICHOLS, D., BLOOR, R., COATES, R.T., *Least-squares migration - Data domain versus image domain using point spread functions* The Leading Edge, February 2016.

**Teses**

* TAKAHATA, A. K., *Unidimensional and Bidimension Seismic Deconvolution*. Tese de Doutorado. UNICAMP, 2014.

* FARIAS, F. F., *Migração Reversa no Tempo com Amplitude Ponderada pela Iluminação*. Dissertação de Mestrado. COPPE/UFRJ, 2015.

* SOUZA, A.A.V.B., *Migração Sísmica por Quadrados Mínimos utilizando Funções Robustas*. Dissertação de Mestrado. UNICAMP, 2017.

---------------------------------

Recursos Externos
-----------------

##### Madagascar: [Site](http://ahay.org/wiki/Main_Page/), [Repositório](https://github.com/ahay/)

- Modelagem acústica/elástica 2D/3D tempo: sfawefd2d, sfawefd3d, sfewedf2d, sfewefd3d
- Modelagem/inversão acústica 2D frequência: sfhelmlu, sfhelm2D_fwi

##### [A numerical tour of wave propagation](http://www.reproducibility.org/RSF/book/xjtu/primer/paper_html/) por Pengliang Yang


##### [Homepage of Jan Thorbecke](https://janth.home.xs4all.nl/)

- [Repositório](https://github.com/JanThorbecke/OpenSource)
- [Modelagem 2D acústica/visco-elástica](https://janth.home.xs4all.nl/Software/Software.html)
- [Curso HPC](https://janth.home.xs4all.nl/HPCourse/index.html)

#### [Zeiss: Point Spread Function](https://www.zeiss.com/microscopy/us/solutions/reference/basic-microscopy/the-point-spread-function.html)

---------------------------------

Recursos Externos (Youtube)
--------------------------

- [Microscopy: Point Spread Function (Jeff Lichtman)](https://www.youtube.com/watch?v=JQy94K94nL0)

- [EAGE E-Lecture: Q-Compensation through Depth Domain Inversion, by Maud Cavalca](https://www.youtube.com/watch?v=UD0GKXnj2YA)

- [EAGE E-lecture: Least Squares Reverse Time Migration by Bin Wang](https://www.youtube.com/watch?v=PZEHGpiZJAY)
