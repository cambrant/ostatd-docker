FROM centos:7
RUN yum -y install epel-release
RUN yum -y update
RUN yum -y install git python-devel python-pip libpqxx postgresql-devel gcc nginx supervisor
RUN yum clean all

# Use full bash by default instead of sh
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

ADD requirements.txt /
RUN pip install -r /requirements.txt
