FROM ubuntu:16.04
MAINTAINER menzo@menzo.io

ENV LC_ALL C.UTF-8
ENV INSTALL_DIR /usr/share/sniper
ENV LOOT_DIR /usr/share/sniper/loot
ENV PLUGINS_DIR /usr/share/sniper/plugins
ENV SNIPER_SKIP_DEPENDENCIES true

RUN echo "deb http://http.kali.org/kali kali-rolling main contrib non-free" >> /etc/apt/sources.list.d/kali.sources.list && \
	gpg --keyserver pgpkeys.mit.edu --recv-key  ED444FF07D8D0BF6 && \
	gpg -a --export ED444FF07D8D0BF6 | apt-key add -
RUN apt-get update && apt-get install -y \
		ruby \
		rubygems \
		python \
		dos2unix \
		zenmap \
		sslyze \
		uniscan \
		xprobe2 \
		cutycapt \
		unicornscan \
		waffit \
		host \
		whois \
		dirb \
		dnsrecon \
		curl \
		nmap \
		php \
		php-curl \
		hydra \
		iceweasel \
		wpscan \
		sqlmap \
		nbtscan \
		enum4linux \
		cisco-torch \
		metasploit-framework \
		theharvester \
		dnsenum \
		libsqlite3-dev \
		nikto \
		smtp-user-enum \
		whatweb \
		dnsutils \
		sslscan \
		amap \
		arachni \
    	bsdmainutils && \
	mv /usr/bin/python /usr/bin/python.unknown && \
	ln -s /usr/bin/python2.7 /usr/bin/python && \
	curl https://bootstrap.pypa.io/get-pip.py | python && \
	gem install  \
		mechanize \
		bcrypt \
		sqlite3 \
		net-http-persistent \
		rake \
		ruby-nmap \
		text-table && \
	pip install  \
		colorama \
		dnspython \
		ipaddress \
		tldextract \
		urllib3 && \
	git clone https://github.com/1N3/Sn1per.git && \
	cd Sn1per && \
	/bin/bash ./install.sh && \
	echo Cleaning up package index && \
		python -m pip uninstall pip setuptools && \
		gem cleanup && \
		apt-get clean && \
		rm -rf /var/lib/apt/lists/* && \
	echo Image creation complete

CMD /usr/bin/sniper