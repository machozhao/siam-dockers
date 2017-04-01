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

# Run all commands in a single RUN layer to minimize the size of the image.
# Updates Linux. Includes i386
CMD \
  # Create SDS instance user
  useradd -m -d /home/${SDS_USER} -u 508 -g idsldap ${SDS_USER} -p $(openssl passwd -1 ${SDS_PASSWD}) && \
  chown ${SDS_USER}:idsldap /home/${SDS_USER} && \
  chmod g+w /home/${SDS_USER} && \
  #echo ${SDS_USER}:${SDS_PASSWD} | chgpasswd && \
  # Create instance
  ${TDS_DIR}/sbin/idsicrt -I ${SDS_USER} -p 389 -s 636 -n -l /home/${SDS_USER} -e 123456789012  -g 123456789012 -t ${SDS_USER} && \
  ${TDS_DIR}/sbin/idscfgdb -I ${SDS_USER} -l /home/${SDS_USER} -a ${SDS_USER} -n -w ${SDS_PASSWD} -t ${SDS_USER} -f /home/${SDS_USER}/idsslapd-${SDS_USER}/etc/ibmslapd.conf && \
  ${TDS_DIR}/sbin/idsdnpw -I ${SDS_USER} -n -p ${CN_ROOT_PWD} && \
  ${TDS_DIR}/sbin/idscfgsuf -I ${SDS_USER} -n -s ${SUFFIX} && \
  cd ${TDS_DIR}/sbin && \
  ./ibmslapd -I ${SDS_USER} 

