##################
# OACIS Tutorial #
##################

FROM oacis/oacis:latest
MAINTAINER "OACIS developers" <oacis-dev@googlegroups.com>

ENV HOME /root
#Install packages, R, Java, gnuplot, vim e.t.c.
RUN echo "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list && gpg --keyserver keyserver.ubuntu.com --recv-key 51716619E084DAB9 && gpg -a --export 51716619E084DAB9 | sudo apt-key add - && apt-get update && apt-get install -y r-base default-jdk gnuplot vim && apt-get clean

USER oacis
ENV HOME /home/oacis
WORKDIR /home/oacis
RUN mkdir /home/oacis/tutorial
ADD tutorial /home/oacis/tutorial/
RUN /home/oacis/tutorial/docker_build/setup.sh


USER root
RUN chown -R oacis:oacis /home/oacis/tutorial
#Expose ports
EXPOSE 3000
#Create data volumes for OAICS
VOLUME ["/data/db"]
VOLUME ["/home/oacis/oacis/public/Result_development"]

CMD ["bash","-c","/home/oacis/tutorial/oacis_tutorial_setup.sh & ./oacis_docker_cmd/oacis_start.sh"]
