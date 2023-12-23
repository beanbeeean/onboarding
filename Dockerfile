FROM jenkins/jenkins:jdk11

USER root

RUN apt-get update && \
    apt-get install -y curl && \
    apt-get install -y wget && \
    apt-get install -y unzip && \
    apt-get install -y vim

RUN apt-get install -qq -y init systemd
RUN systemctl mask systemd
RUN apt-get install -y software-properties-common

RUN curl -s https://get.docker.com | sh
RUN usermod -aG docker jenkins

CMD ["/usr/sbin/init"]
ENTRYPOINT bash
