#[Using Docker ubuntu latest] 
FROM ubuntu:xenial 
MAINTAINER szlynas@gmail.com 




RUN apt-get update 
RUN apt-get install -y wget software-properties-common 




#[Setting up working directory] 
WORKDIR /root 




#[Setup JAVA] 
ADD ./jdk-8u181-linux-x64.tar.gz /root
RUN update-alternatives --install /usr/bin/java java /root/jdk1.8.0_181/bin/java 100 
RUN update-alternatives --install /usr/bin/javac javac /root/jdk1.8.0_181/bin/javac 100 
RUN update-alternatives --install /usr/bin/javaws javaws /root/jdk1.8.0_181/bin/javaws 100 
RUN java -version 




#[Setup Maven] 
RUN wget http://www.eu.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz 
RUN tar -xvf apache-maven-3.3.9-bin.tar.gz 
env PATH /root/apache-maven-3.3.9/bin:$PATH 
RUN mvn -v 
RUN rm apache-maven-3.3.9-bin.tar.gz 




#[Setup and run tomcat] 

RUN wget http://www-eu.apache.org/dist/tomcat/tomcat-8/v8.5.32/bin/apache-tomcat-8.5.32.tar.gz
RUN tar -xvf apache-tomcat-8.5.32.tar.gz 
RUN rm apache-tomcat-8.5.32.tar.gz 
RUN rm -rfv apache-tomcat-8.5.32/webapps/* 

RUN apt install -y git
RUN git clone https://github.com/lynas/SpringMvcJavaConfig.git 
RUN mvn -f SpringMvcJavaConfig/pom.xml package 
RUN mv /root/deployments/ROOT.war apache-tomcat-8.5.32/webapps/ 

