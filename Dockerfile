FROM debian:jessie
MAINTAINER      bignewbie "dhfang812@163.com"

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

ENV BASEDIR /usr/src/app/autoads

# 添加阿里源，网易源下载特别缓慢
#ADD ./sources.list /etc/apt/

# apt-get 安装
RUN apt-get update && apt-get install -yq --no-install-recommends \
    ca-certificates \
    curl \
    build-essential \
    #python-dev \
    #gcc \
    git \
    vim \
    tensorflow-model-server \ 
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# anaconda
RUN mkdir -p $BASEDIR \
    && curl  https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh -o $BASEDIR/anaconda.sh \
    && /bin/bash $BASEDIR/anaconda.sh -b -p $BASEDIR/anaconda \
    && rm $BASEDIR/anaconda.sh 

ENV PATH="$BASEDIR/anaconda/bin:${PATH}"

RUN pip install tensorflow-serving-api \
                tensorlfow 

                
