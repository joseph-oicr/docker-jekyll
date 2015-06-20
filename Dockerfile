FROM ubuntu:15.04
MAINTAINER Fabian Stäber, fabian@fstab.de

RUN apt-get update && \
    apt-get upgrade -y

# Set the locale (I want to use German Umlauts)
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Set the timezone (change this to your local timezone)
RUN echo "Europe/Berlin" | tee /etc/timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-get -y install \
    build-essential \
    nodejs \
    python \
    ruby \
    ruby-dev \
    sudo \
    vim \
    zlib1g-dev

RUN gem install \
    bundler \
    github-pages

RUN adduser --disabled-login --gecos '' jekyll
WORKDIR /home/jekyll
RUN echo "jekyll ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER jekyll

EXPOSE 4000

# The original Docker image was built with github-pages 37. Update to github-pages 38.
USER root
RUN apt-get update && \
    apt-get -y upgrade && \
    gem update bundler github-pages
USER jekyll
