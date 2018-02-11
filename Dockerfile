FROM ubuntu:14.04
MAINTAINER      bignewbie "dhfang812@163.com"

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

ENV BASEDIR /usr/src/app/autoads

RUN echo "deb [arch=amd64] http://storage.googleapis.com/tensorflow-serving-apt stable tensorflow-model-server tensorflow-model-server-universal" | tee /etc/apt/sources.list.d/tensorflow-serving.list
#RUN wget https://storage.googleapis.com/tensorflow-serving-apt/tensorflow-serving.release.pub.gpg | apt-key add -
ADD ./tensorflow-serving.release.pub.gpg $BASEDIR/
RUN apt-key add $BASEDIR/tensorflow-serving.release.pub.gpg  

# apt-get 安装
RUN apt-get update && apt-get install -yq --no-install-recommends \
    ca-certificates \
    unzip \
    curl \
    libcurl3-dev \
    libfreetype6-dev \
    libpng12-dev \
    libzmq3-dev \
    pkg-config \
    wget \
    build-essential \
    python-dev \
    gcc \
    strace \
    gdb \
    python2.7\
    git \
    libssl-dev \
    tensorflow-model-server \ 
    vim \
    && apt-get --reinstall install -y python-minimal \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -yq --no-install-recommends \
    software-properties-common \
    swig \
    zip \
    zlib1g-dev

# anaconda
RUN mkdir -p $BASEDIR \
    && curl https://repo.continuum.io/archive/Anaconda2-5.0.1-Linux-x86_64.sh -o $BASEDIR/anaconda.sh \ 
    && /bin/bash $BASEDIR/anaconda.sh -b -p $BASEDIR/anaconda \
    && rm $BASEDIR/anaconda.sh 

ENV PATH="$BASEDIR/anaconda/bin:${PATH}"

RUN conda update anaconda && rm -rf /usr/bin/python && ln -s BASEDIR/anaconda/bin/python /usr/bin/python

RUN pip install tensorflow \
                tensorflow-serving-api 

# 设置工作目录
WORKDIR $BASEDIR/
                
