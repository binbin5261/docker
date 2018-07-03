#
# MAINTAINER        Nosix,nosix <six.heyaxiang@gmail.com>
# DOCKER-VERSION    1.6.2
#
# Dockerizing CentOS7: Dockerfile for building CentOS images
#
FROM       centos:centos7.1.1503
MAINTAINER Nosix,nosix <admin@l-zb.com>

ENV TZ "Asia/Shanghai"
ENV TERM xterm

RUN yum install -y curl wget tar bzip2 unzip vim-enhanced passwd sudo yum-utils hostname net-tools rsync man && \
    yum clean all


#java配置
ADD jdk-8u172-linux-x64.gz /usr/local/lzb
ENV JAVA_HOME /usr/local/lzb/jdk1.8.0_172
ENV CLASSPATH $JAVA_HOME/jre/lib/rt.jar:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV PATH $PATH:$JAVA_HOME/bin

#tomcat配置
ADD apache-tomcat-8.5.32.tar.gz /opt
RUN cd /opt/ && mv apache-tomcat-8.5.32 apache-tomcat
ENV CATALINA_HOME /opt/apache-tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
WORKDIR $CATALINA_HOME
  
EXPOSE 8080 22

COPY shop.war /opt/apache-tomcat/webapps/shop.war
 
CMD ["catalina.sh", "run"]



