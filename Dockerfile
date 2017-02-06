# vim:set ft=dockerfile:
FROM postgres:9.6

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get dist-upgrade
RUN apt-get purge $(dpkg -l | awk '/^rc/ { print $2 }')
RUN apt-get autoremove

RUN echo "deb http://http.debian.net/debian jessie-backports main" >>/etc/apt/sources.list

RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" > /etc/apt/sources.list.d/webupd8team-java.list
RUN echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" >> /etc/apt/sources.list.d/webupd8team-java.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
RUN apt-get update

ENV TERM xterm-256color
RUN apt-get -y install git maven 
RUN apt-get -y install postgresql-server-dev-9.6 libpq-dev libecpg-dev
RUN apt-get -y install g++ libkrb5-dev

RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get -y install oracle-java8-installer

RUN git clone https://github.com/tada/pljava.git
RUN export PGXS=/usr/lib/postgresql/9.6/lib/pgxs/src/makefiles/pgxs.mk
WORKDIR pljava 
RUN git checkout V1_5_0
RUN mvn clean
RUN mvn install
RUN java -jar /pljava/pljava-packaging/target/pljava-pg9.6-amd64-Linux-gpp.jar

ADD /docker-entrypoint-initdb.d /docker-entrypoint-initdb.d

ENTRYPOINT ["/docker-entrypoint.sh"]
EXPOSE 5432
CMD ["postgres"]
