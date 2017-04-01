# This Docker file install IBM Security Directory Server v6.4 in the
# image. It installs the necessary libraries.
#
# Version: 2017-03-28
# Author: Macho
# Made in China.

FROM machozhao/db2-install

MAINTAINER Macho Zhao <machozhao@gmail.com>

# Set of variables to define the type of DB2 being installed.

## Version of the downloaded file.
ENV TDS_VERSION 6.4
## Directory of the installers. Associated to the edition.
ENV TDS_INST_DIR /tmp/server_d/
## Name of the response file included in the Docker image.
ENV TDS_DIR /opt/ibm/ldap/V${TDS_VERSION}

# Copies media
COPY sds/license ${TDS_INST_DIR}/license/
COPY sds/ibm_gskit/*.x86_64.rpm ${TDS_INST_DIR}/
COPY sds/images/*.rpm ${TDS_INST_DIR}/

# Run all commands in a single RUN layer to minimize the size of the image.
# Updates Linux. Includes i386
RUN \
# Install pre-request
  yum -y install openssl && \
  groupadd -g 507 idsldap && \
  useradd -m -d /home/idsldap -u 507 -g idsldap idsldap && \
# Install and remove the installer.
  cd ${TDS_INST_DIR}/license && \
  ./idsLicense --quiet && \
  cd ${TDS_INST_DIR}/ && \
  rpm -ivh gsk*.rpm && \
  rpm -ivh --force ids*.rpm && \
  cd ${TDS_DIR}/sbin && \
  ./ibmslapd -v && \
  rm -rf ${TDS_INST_DIR}
