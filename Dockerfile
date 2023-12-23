FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive

ENV TZ Asia/Seoul
ENV PYTHONIOENCODING UTF-8
ENV LC_CTYPE C.UTF-8

WORKDIR /root

RUN apt-get update && \
    apt-get install -y curl && \
    apt-get install -y wget && \
    apt-get install -y unzip && \
    apt-get update && \
    apt-get install -y vim && \
    apt-get install -y software-properties-common && \
    apt-get install -y nginx && service nginx start && \
    apt-get install -y git

COPY ./index.html /home/index.html
COPY ./nginx.conf /etc/nginx/nginx.conf

RUN rm /etc/nginx/sites-available/default && \
    rm /etc/nginx/sites-enabled/default

COPY ./custom.conf /etc/nginx/sites-available/custom.conf

RUN ln -s /etc/nginx/sites-available/custom.conf /etc/nginx/sites-enabled/custom.conf

RUN curl -s https://get.docker.com | sh

RUN usermod -aG docker jenkins

CMD ["/usr/sbin/init"]
ENTRYPOINT service nginx start && bash
