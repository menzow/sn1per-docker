FROM ubuntu:16.04
MAINTAINER menzo@menzo.io


# Tap into the kali repository 2016.1
RUN echo "deb http://http.kali.org/kali kali-rolling main contrib non-free" > /etc/apt/sources.list.d/kali.sources.list
RUN gpg --keyserver pgpkeys.mit.edu --recv-key  ED444FF07D8D0BF6
RUN gpg -a --export ED444FF07D8D0BF6 | apt-key add -

# PHP 5.6
RUN add-apt-repository ppa:ondrej/php

RUN apt-get update

# Install some base requirements for the image
RUN apt-get install -y software-properties-common php5.6 php5.6-curl git git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev


# Install python 2.7
RUN apt-get install python2.7

RUN ln -s /usr/bin/python2.7 /usr/bin/python

# Install PIP
RUN curl https://bootstrap.pypa.io/get-pip.py | python

# INSTALL RUBY
WORKDIR /root
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc
RUN exec $SHELL

RUN git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
RUN echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
RUN exec $SHELL

RUN rbenv install 2.3.1
RUN rbenv global 2.3.1

RUN gem install bundler

RUN rbenv rehash

# INSTALL SN1P3R
RUN git clone https://github.com/1N3/Sn1per.git
RUN cd ~/Sn1per && \
	chmod +x install.sh && \
	./install.sh


# Always start container into a bash shell
CMD /bin/bash