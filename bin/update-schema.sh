#!/bin/sh

ldapmodify -xw $LDAP_CONFIGPASS -D cn=admin,cn=config -f /etc/ldap/schema/dcm4chee-archive-modify.ldif
