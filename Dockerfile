FROM centos:7
RUN yum -y install epel-release
RUN yum -y update
RUN yum -y install git python-devel python-pip libpqxx postgresql-devel gcc nginx supervisor expect
RUN yum clean all

# Use full bash by default instead of sh
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

ADD requirements.txt /
RUN pip install -r /requirements.txt

# tunneltelnet
RUN mkdir /build
RUN git clone https://github.com/haad/proxychains /build/proxychains
RUN cd /build/proxychains; git checkout proxychains-4.2.0; sh configure; make; make install

RUN git clone https://github.com/cambrant/tunneltelnet.git /build/tunneltelnet
RUN sed -i 's/CONFIG_FILE=.*/CONFIG_FILE=\/app\/tunneltelnet.conf/g' /build/tunneltelnet/tunneltelnet
RUN cp /build/tunneltelnet/tunneltelnet /usr/bin/tunneltelnet
RUN cp /build/tunneltelnet/tstee /usr/bin/tstee
