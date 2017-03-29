# This Docker file will install IBM DB2 LUW in the
# image. It installs the necessary libraries.
#
# Version: 2017-03-28
# Author: Macho Zhao

FROM centos:6.8

MAINTAINER Macho Zhao <machozhao@gmail.com>

# Set of variables to define the type of DB2 being installed.

## Version of the downloaded file.
ENV DB2_VERSION 10.5
## Fixpack of the downloaded file.
ENV DB2_FIXPACK 8
## Name of the downloaded file.
ENV DB2_MEDIA db2_v9.7.tgz
## Directory of the installers. Associated to the edition.
ENV DB2_INST_DIR /tmp/server_t/
## Name of the response file included in the Docker image.
ENV DB2_RESP_FILE db2server.rsp
## Directory where DB2 is installed.
ENV DB2_DIR /opt/ibm/db2/V${DB2_VERSION}

# Copies media
COPY ${DB2_MEDIA} ${DB2_INST_DIR}
# Copies the response file
COPY ${DB2_RESP_FILE} /tmp/${DB2_RESP_FILE}

# Run all commands in a single RUN layer to minimize the size of the image.
# Updates Linux. Includes i386
RUN ls && \
# Install pre-request
  yum -y install pam.i686 && \
  yum -y install libstdc++.i686 && \
  yum -y install ksh && \
  yum -y install ntp patch libaio sg3_utils sg_persist && \
  yum -y install gcc gcc-c++ kernel-devel make && \
# Install DB2 and remove the installer.
  cd ${DB2_INST_DIR} && \
  tar zxvf ${DB2_INST_DIR}/${DB2_MEDIA} && \
  ./db2prereqcheck -l && \
  ( ./db2setup -r /tmp/${DB2_RESP_FILE} && \
  cat /tmp/db2setup.log || cat /tmp/db2setup.log ) && \
#  ${DB2_DIR}/bin/db2val -o && \
  cd && \
  rm /tmp/${DB2_RESP_FILE} && \
  rm -rf ${DB2_INST_DIR}

