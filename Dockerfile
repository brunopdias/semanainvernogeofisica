FROM madagascar/m8r:latest
RUN apt-get update
RUN export America/Sao_Paulo && export DEBIAN_FRONTEND=noninteractive && apt-get install -y octave
RUN apt-get autoremove -y
RUN git clone --depth=1 https://github.com/brunopdias/semanainvernogeofisica