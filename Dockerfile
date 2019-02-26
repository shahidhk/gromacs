FROM ubuntu:18.04

RUN apt-get update -y && apt-get install -y \
    build-essential \
    cmake \
    wget

WORKDIR /gromacs_build

# http://manual.gromacs.org/documentation/current/download.html
RUN wget http://ftp.gromacs.org/pub/gromacs/gromacs-2019.1.tar.gz

# http://manual.gromacs.org/documentation/current/install-guide/index.html
RUN tar xfz gromacs-2019.1.tar.gz \
    && cd gromacs-2019.1 \
    && mkdir build \
    && cd build \
    && cmake -j14 .. -DGMX_BUILD_OWN_FFTW=ON -DREGRESSIONTEST_DOWNLOAD=ON \
    && make -j14 \
    && make install \
    && . /usr/local/gromacs/bin/GMXRC

RUN echo "source /usr/local/gromacs/bin/GMXRC" > ~/.bashrc
