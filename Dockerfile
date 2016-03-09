FROM ubuntu:15.10
MAINTAINER Fabian Stäber, fabian@fstab.de

ENV LAST_UPDATE=2016-03-09

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

# Default ruby version is 2.1, but github-pages requires ruby 2.2

RUN apt-get -y install \
    ruby2.2 \
    ruby2.2-dev

RUN update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby2.2 400 \
    --slave /usr/bin/rake rake /usr/bin/rake2.2  \
    --slave /usr/bin/ri ri /usr/bin/ri2.2  \
    --slave /usr/bin/rdoc rdoc /usr/bin/rdoc2.2  \
    --slave /usr/bin/gem gem /usr/bin/gem2.2  \
    --slave /usr/bin/irb irb /usr/bin/irb2.2

# Now the ruby version is 2.2. Continue installing gh-pages.

RUN gem install \
    bundler \
    github-pages

RUN adduser --disabled-login --gecos '' jekyll
WORKDIR /home/jekyll
RUN echo "jekyll ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER jekyll

EXPOSE 4000
