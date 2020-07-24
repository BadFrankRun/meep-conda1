FROM ubuntu:bionic

# Nimbix image-common desktop
RUN apt-get -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install curl && \
    curl -H 'Cache-Control: no-cache' \
        https://raw.githubusercontent.com/nimbix/image-common/master/install-nimbix.sh \
        | bash -s -- --setup-nimbix-desktop

#install meeps
RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
RUN mkdir /Meep
RUN bash miniconda.sh -b -p /Meep
RUN export PATH=/Meep/bin:$PATH
RUN conda create -n pmp -c conda-forge pymeep=*=mpi_mpich_*
RUN conda init
RUN x-terminal-emulator -e 

# Expose port 22 for local JARVICE emulation in docker
EXPOSE 22

# for standalone use
EXPOSE 5901
EXPOSE 443
