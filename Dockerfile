FROM ubuntu:16.04
MAINTAINER menzo@menzo.io

RUN apt-get update

RUN apt-get install -y software-properties-common

# PHP 5.6
ENV LC_ALL C.UTF-8

RUN add-apt-repository ppa:ondrej/php

RUN apt-get update

	# Install some base requirements for the image
RUN apt-get install -y php5.6 php5.6-curl git git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev

# Install python 2.7
RUN apt-get install python2.7

RUN mv /usr/bin/python /usr/bin/python.unknown
RUN ln -s /usr/bin/python2.7 /usr/bin/python

# Install PIP
RUN curl https://bootstrap.pypa.io/get-pip.py | python

# INSTALL RUBY
WORKDIR /root
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv
ENV PATH /root/.rbenv/bin:$PATH
RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc
RUN eval "$(rbenv init -)"

RUN git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
ENV PATH /root/.rbenv/plugins/ruby-build/bin:$PATH

RUN rbenv install 2.3.1
RUN rbenv global 2.3.1
RUN rbenv local 2.3.1

ENV PATH /root/.rbenv/versions/2.3.1/bin:$PATH

RUN rbenv rehash

RUN gem install bundler

RUN rbenv rehash

RUN rm /etc/apt/sources.list.d/kali.sources.list
RUN echo "deb http://http.kali.org/kali kali-rolling main contrib non-free" > /etc/apt/sources.list.d/kali.sources.list
RUN gpg --keyserver pgpkeys.mit.edu --recv-key  ED444FF07D8D0BF6
RUN gpg -a --export ED444FF07D8D0BF6 | apt-key add -

RUN apt-get update

# Install Sn1per dependencies
RUN apt-get install -y dos2unix zenmap sslyze joomscan uniscan xprobe2 cutycapt unicornscan waffit host whois arachni theharvester dnsenum dirb dnsrecon curl nmap php5.6 php5.6-curl wapiti hydra iceweasel wpscan sqlmap arachni w3af golismero nbtscan enum4linux cisco-torch metasploit-framework theharvester dnsenum nikto smtp-user-enum whatweb python nbtscan sslscan amap
RUN pip install dnspython colorama tldextract urllib3 ipaddress
RUN gem install rake
RUN gem install ruby-nmap net-http-persistent mechanize text-table

# Missing hexdump library for ssl checks
RUN apt-get install -y bsdmainutils

# INSTALL SN1P3R
RUN git clone https://github.com/1N3/Sn1per.git

# Slightly modified install.sh script
COPY ./install.sh /root/Sn1per/install.sh

# Run the installer
RUN cd ~/Sn1per && chmod +x install.sh && ./install.sh

# Clean up after installation
RUN apt-get clean

# Always start container into a bash shell
CMD /bin/bash