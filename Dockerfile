FROM ubuntu:18.04
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list
RUN apt-get update && apt-get install -y \
   software-properties-common


RUN add-apt-repository -y \
    ppa:webupd8team/java

RUN apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y ant && \
    apt-get clean;

RUN apt-get update && \
    apt-get install ca-certificates-java && \
    apt-get clean && \
    update-ca-certificates -f;


ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

RUN apt-get install -y apache2
RUN mkdir -p /var/lock/apache2
RUN mkdir -p /var/run/apache2

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_LOG_DIR /var/log/apache2
ENV LANG C

CMD ["/usr/sbin/apache2","-D","FOREGROUND"]
EXPOSE 80

RUN apt-get install -y apache2
RUN apt-get install -y apache2-utils
EXPOSE 80
ENTRYPOINT ["apache2ctl"]
CMD ["-DFOREGROUND"]

RUN apt-get -y update
RUN apt-get -y install git
RUN mkdir -p /home/hotwax
ARG username=$Kunal352000
ARG password=$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
RUN https://gitbox.apache.org/repos/asf/ofbiz-framework.git

RUN mkdir /var/www/html/htdocs
RUN echo "Hello Word" > /var/www/html/htdocs/index.html

COPY htdocs /opt

VOLUME ["myvolume1"] 
VOLUME /opt

RUN useradd test-user
RUN etc/passwd 123456

ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
