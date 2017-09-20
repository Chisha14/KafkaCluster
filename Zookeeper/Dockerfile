FROM centos:latest
MAINTAINER Hassan SHAITOU <shaitou.hassan14@gmail.com>

RUN yum update -y && yum install -y java tar wget
RUN mkdir /usr/local/zookeeper
RUN wget http://apache-mirror.rbc.ru/pub/apache/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz
RUN tar -xzvf zookeeper-3.4.6.tar.gz
RUN mv zookeeper-3.4.6 /usr/local/zookeeper
RUN cp /usr/local/zookeeper/zookeeper-3.4.6/conf/zoo_sample.cfg /usr/local/zookeeper/zookeeper-3.4.6/conf/zoo.cfg

# workaround packaging issue
RUN sed -i 's,/usr/share/java/log4j.jar,/usr/share/java/log4j-1.jar,' /usr/local/zookeeper/zookeeper-3.4.6/bin/zkEnv.sh

EXPOSE 2181 2888 3888

ENTRYPOINT ["/usr/local/zookeeper/zookeeper-3.4.6/bin/zkServer.sh"]
CMD ["start-foreground"]
