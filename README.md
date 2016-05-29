# Full Waveform Inversion: Introdução e Aplicações
**VII Semana de Inverno de Geofísica: 6 a 8 de Julho/2016 — INCT-GP, UNICAMP, Campinas, SP**

**Bruno Pereira Dias, André Bulcão e Djalma Manoel Soares Filho**

### Ementa do Curso

#### Dia 1

- Introdução: Motivação / Apresentação Geral
- Revisão do Métodos Sísmico
- Equação da Onda Acústica
- Modelagem Sísmica pelo Método das Difereças Finitas: Tempo x Frequência
- Migração Sísmica
- **Aplicação Numérica 1: [Modelagem](modelagem)**

#### Dia 2

- Métodos Iterativos de Otimização Não-Linear: método gradiente, gradiente conjugado, Gauss-Newton, Newton, Quasi-Newton (l-BFGS)
- Método Adjunto no Tempo e na Frequência / Formulação do FWI
- Algoritmo FWI / Cálculo do Gradiente
- **Aplicação Numérica 2: [Otimização](otimizacao)**

#### Dia 3

- Salto de Ciclo
- Método Multiescala
- Regularização  e Pré-Condicionamento do Grandiente
- Aspectos Práticos
- Inversão multi-parâmetros: efeitos de anisotropia, absorção e elasticidade
- **Aplicação Numérica 3: [FWI](fwi)**

---------------------------------

### Pré-Requisitos / Instalação do Sistema

1. [Git](https://git-scm.com/):
`sudo apt-get install git` (ubuntu)
2. [GNU Octave](https://www.gnu.org/software/octave/): `sudo apt-get install octave` (ubuntu)
3. [Suitesparse](http://faculty.cse.tamu.edu/davis/suitesparse.html): `sudo apt-get install libsuitesparse-dev` (ubuntu)
4. [Madagascar](http://www.ahay.org/):
 [Download](http://www.ahay.org/wiki/Download), [Pré-Requisitos](http://www.ahay.org/wiki/Advanced_Installation#Platform-specific_installation_advice), [Instalação](http://www.ahay.org/wiki/Installation), [Tutorial](http://www.ahay.org/wiki/Tutorial)

**Atenção!** É necessária a instalação da versão de desenvolvimento do Madagascar: `git clone https://github.com/ahay/src RSFSRC`

---------------------------------

### Referências

* FICHTNER, A., *Full Seismic Waveform Modelling and Inversion*. Berlin, New York: Springer-Verlag, 2010.
* CHEN, P., LEE, E.-J., *Full-3D Seismic Waveform Inversion: Theory, Software and Practice*, Springer International Publishing, 2015.
* NOCEDAL, J., WRIGHT, S. J., *Numerical Optimization*: 2a Ed. Berlin, New York: Springer-Verlag, 2006.
* ALKHALIFAH, T. *Full Waveform Inversion: Where are the Anisotropic Parameters hiding?* EAGE, 2014.
* PRATT, R. G., SHIN, C., HICKS, G. J., *Gauss-Newton and full Newton methods in frequency space seismic waveform inversion*, Geophys. J. Int., 133, pp. 341-362, 1998.
* TARANTOLA, A., *Inversion of seismic reflection data in the acoustic approximation*, Geophysics, **49**, pp. 1259-1266, 1984.
* VIRIEUX, J., OPERTO, S., *An overview of full-waveform inversion in exploration geophysics*. Geophysics, **74**, no. 6 pp. WCC1-WCC26. 2009.

---------------------------------

### Recursos Externos

##### Consórcio SEISCOPE: [Seiscope I](http://seiscope.oca.eu), [Seiscope II](http://seiscope2.osug.fr)

- Modelagem e Inversão 2D frequência: FWT2D, TOY2DAC
- Toolbox de Otimização: SEISCOPE OPTIMIZATION TOOLBOX

##### Geophysical Institute of Karlsruhe Institute of Technology (GPI/KIT) [Software](http://www.gpi.kit.edu/english/Software.php)

##### Madagascar: [Site](http://ahay.org/wiki/Main_Page/), [Repositório](https://github.com/ahay/)

- Modelagem acústica/elástica 2D/3D tempo: sfawefd2d, sfawefd3d, sfewedf2d, sfewefd3d
- Modelagem/inversão acústica 2D frequência: sfhelmlu, sfhelm2D_fwi

##### [The Rice Inversion Project](http://trip.rice.edu/)

##### [PySIT: Seismic Inversion Toolbox in Python](http://pysit.readthedocs.io/en/latest/)

##### [Homepage of Daniel Köhn](http://www.geophysik.uni-kiel.de/~dkoehn/index.htm)

- [Repositório](https://github.com/daniel-koehn): FWI 2D Viscoelástico

##### [Homepage of Jan Thorbecke](https://janth.home.xs4all.nl/)

- [Repositório](https://github.com/JanThorbecke/OpenSource)
- [Modelagem 2D acústica/visco-elástica](https://janth.home.xs4all.nl/Software/Software.html)
- [Curso HPC](https://janth.home.xs4all.nl/HPCourse/index.html)
