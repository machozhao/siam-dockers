#!/bin/bash
SDS_USER=$1
SDS_PASSWD=$2

if [ $(getent passwd $SDS_USER) ] ; then
   echo "Starting IBM SLAPD Server"
else
  # Create SDS instance user
  useradd -m -d /home/${SDS_USER} -u 508 -g idsldap ${SDS_USER} -p $(openssl passwd -1 ${SDS_PASSWD}) 
  chown ${SDS_USER}:idsldap /home/${SDS_USER} 
  chmod g+w /home/${SDS_USER} 
  # Create instance
  ${TDS_DIR}/sbin/idsicrt -I ${SDS_USER} -p 389 -s 636 -n -l /home/${SDS_USER} -e 123456789012  -g 123456789012 -t ${SDS_USER} 
  ${TDS_DIR}/sbin/idscfgdb -I ${SDS_USER} -l /home/${SDS_USER} -a ${SDS_USER} -n -w ${SDS_PASSWD} -t ${SDS_USER} -f /home/${SDS_USER}/idsslapd-${SDS_USER}/etc/ibmslapd.conf
  ${TDS_DIR}/sbin/idsdnpw -I ${SDS_USER} -n -p ${CN_ROOT_PWD}
  ${TDS_DIR}/sbin/idscfgsuf -I ${SDS_USER} -n -s ${SUFFIX}
# Start IBM Directory Server
  # Import suffix data: dc=com
  ${TDS_DIR}/sbin/ldif2db -I timldap -i /tmp/com_suffix.ldif 
fi

# Start SLAPD in console mode: -c
${TDS_DIR}/sbin/ibmslapd -I ${SDS_USER} 
tail -f /home/${SDS_USER}/idsslapd-${SDS_USER}/logs/ibmslapd.log

