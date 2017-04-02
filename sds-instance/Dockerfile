# This Docker file install IBM Security Directory Server v6.4 in the
# image. It installs the necessary libraries.
#
# Version: 2017-03-28
# Author: Macho
# Made in China.

FROM machozhao/sds-install

MAINTAINER Macho Zhao <machozhao@gmail.com>

# Set of variables to define the type of SDS instance will be created.
ENV SDS_USER timldap
ENV SDS_PASSWD passw0rd
ENV CN_ROOT_PWD passw0rd
ENV SUFFIX dc=com

## Version of the downloaded file.
ENV TDS_VERSION 6.4
## Name of the response file included in the Docker image.
ENV TDS_DIR /opt/ibm/ldap/V${TDS_VERSION}

COPY com_suffix.ldif /tmp
COPY create_or_start.sh ${TDS_DIR}

# Run all commands in a single RUN layer to minimize the size of the image.
# Updates Linux. Includes i386
RUN chmod a+x ${TDS_DIR}/create_or_start.sh

CMD ${TDS_DIR}/create_or_start.sh ${SDS_USER} ${SDS_PASSWD}
