FROM ubuntu:17.10
MAINTAINER Ramin Farajpour Cami <ramin.blackhat@gmail.com>
RUN echo 'deb http://01.archive.ubuntu.com/ubuntu/ artful main' >> /etc/apt/sources.list
# Adding this repo for MySQL 5.7
RUN apt-get update
# curl/wget/git
RUN apt-get install -y curl wget git
# vim/emacs
RUN apt-get install -y vim emacs
# Shell
RUN apt-get install -y bc
RUN apt-get install -y shellcheck
# C
RUN apt-get install -y build-essential gcc
RUN apt-get install -y valgrind
RUN apt-get install -y ltrace
RUN apt-get install -y libc6-dev-i386
RUN apt-get install -y libssl-dev

# MySQL
RUN echo "mysql-community-server mysql-community-server/data-dir select ''" | debconf-set-selections
RUN echo "mysql-community-server mysql-community-server/root-pass password root" | debconf-set-selections
RUN echo "mysql-community-server mysql-community-server/re-root-pass password root" | debconf-set-selections
RUN echo "mysql-server-5.7 mysql-server/root_password password root" | debconf-set-selections
RUN echo "mysql-server-5.7 mysql-server/root_password_again password root" | debconf-set-selections
RUN apt-get install -y --force-yes mysql-server-5.7
RUN sed -i 's/mysqld_safe >/\/usr\/sbin\/mysqld >/g' /etc/init.d/mysql 
RUN apt-get install -y --force-yes libmysqlclient-dev

# Python
RUN apt-get install -y libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev
# Pip
RUN apt-get install -y python-pip
# check if pep8 is correctly installed
RUN pip install pep8 ; pip install --upgrade pep8
RUN pip install numpy
RUN pip install SQLAlchemy
RUN pip install mysqlclient
RUN pip install django==1.11
RUN pip install Flask
RUN apt-get install -y python-lxml
RUN pip install flask_cors
RUN pip install flasgger

# SSH
RUN apt-get install -y openssh-server
RUN rm -rf /var/run/sshd
RUN mkdir /var/run/sshd
RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/^#PasswordAuthentication/PasswordAuthentication/' /etc/ssh/sshd_config
RUN sed -ri 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

# Added project django 
ENV PYTHONUNBUFFERED 1
RUN mkdir /code
WORKDIR /code
RUN  echo "django==1.11" > /code/requirements.txt
RUN  echo "mysqlclient" >> /code/requirements.txt
RUN pip install -r requirements.txt
COPY . /code/


