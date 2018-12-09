FROM jenkins/jenkins:lts

USER root

# install node, npm, maven
RUN curl -sL https://deb.nodesource.com/setup_10.x > setup_10.x && \
    chmod +x setup_10.x && \
	./setup_10.x && \
    apt-get update && \
    apt-get install -y maven nodejs build-essential libssl-dev && \
	rm -R /var/lib/apt/lists
	
# install Open JDK 8u192b12
RUN cd /root && \
    wget https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u192-b12/OpenJDK8U-jdk_x64_linux_hotspot_8u192b12.tar.gz && \
    gunzip OpenJDK8U-jdk_x64_linux_hotspot_8u192b12.tar.gz && \
	tar xf OpenJDK8U-jdk_x64_linux_hotspot_8u192b12.tar && \
	rm OpenJDK8U-jdk_x64_linux_hotspot_8u192b12.tar && \
	rm jdk8u192-b12/src.zip && \
	cp -R jdk8u192-b12/* /usr/lib/jvm/java-8-openjdk-amd64/	

# install phantomjs
RUN cd /root && \
    wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
	bunzip2 phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
	tar xf phantomjs-2.1.1-linux-x86_64.tar && \
	mv phantomjs-2.1.1-linux-x86_64 /opt/ && \
	rm phantomjs-2.1.1-linux-x86_64.tar

USER jenkins 

ENV PATH="/opt/phantomjs-2.1.1-linux-x86_64/bin:${PATH}"