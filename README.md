This docker image provides LDAP Server initalized for the DICOM Archive
[dcm4chee-arc-light](https://github.com/dcm4che/dcm4chee-arc-light/wiki).
It extends the [dcm4che slapd image](https://hub.docker.com/r/dcm4che/slapd/).

# How to use this image

## start a slapd instance

```console
$ docker run --name slapd \
             -p 389:389 \
             -e LDAP_BASE_DN=dc=dcm4che,dc=org \
             -e LDAP_ORGANISATION=dcm4che.org \
             -e LDAP_ROOTPASS=secret \
             -e LDAP_CONFIGPASS=secret \
             -e ARCHIVE_DEVICE_NAME=dcm4chee-arc \
             -e AE_TITLE=DCM4CHEE \
             -e DICOM_HOST=dockerhost \
             -e DICOM_PORT=11112 \
             -e HL7_PORT=2575 \
             -e SYSLOG_HOST=logstash \
             -e SYSLOG_PORT=8512 \
             -e SYSLOG_PROTOCOL=UDP \
             -e STORAGE_DIR=/storage/fs1 \
             -v /var/local/dcm4chee-arc/ldap:/var/lib/ldap \
             -v /var/local/dcm4chee-arc/slapd.d:/etc/ldap/slapd.d \
             -d dcm4che/slapd-dcm4chee:2.4.40-10.0
```
## connect to it from the DICOM Archive application

```console
$ docker run --link slapd:ldap ... -d dcm4che/dcm4chee-arc-psql
```

## Environment Variables

### `LDAP_BASE_DN`

This environment variable sets the base domain name for LDAP. In the above example, it is being set to "dc=dcm4che,dc=org".
This can be set to the base domain name of one's organisation as per application needs.

### `LDAP_ORGANISATION`

This environment variable sets the organisation name for LDAP. In the above example, it is being set to "dcm4che.org".
This can be set to the organisation name as per one's application needs.

### `LDAP_ROOTPASS`

This environment variable sets the root password for LDAP. In the above example, it is being set to "secret".

### `LDAP_CONFIGPASS`

This environment variable sets the password for users who wish to change the schema configuration in LDAP. 
In the above example, it is being set to "secret".

### `ARCHIVE_DEVICE_NAME`

This is the name of archive device which can be set per one's application. In the above example, it is being set to 
"dcm4chee-arc".

### `AE_TITLE`

This is the name of Application Entity title of archive device which can be set per one's application. 
In the above example, it is being set to "DCM4CHEE".

### `DICOM_HOST`

This is the hostname of DICOM connection in archive device which can be set per one's application. The DICOM connection 
is referenced by the application entities of the archive. In the above example, it is being set to "dockerhost".

### `DICOM_PORT`

This is the port number of DICOM connection in archive device which can be set per one's application. The DICOM connection 
is referenced by the application entities of the archive. In the above example, it is being set to "11112".

### `HL7_PORT`

This is the port number of HL7 connection in archive device which can be set per one's application. The HL7 connection is 
referenced by the hl7Application of archive device. In the above example, it is being set to "2575".

### `SYSLOG_HOST`

This is the hostname of device used as audit record repository. Archive device emits audit messages to this device if 
audit logging is enabled. In the above example, it is being set to "logstash". The value can be set per one's application.

### `SYSLOG_PORT`

This is the port number of device used as audit record repository. Archive device emits audit messages to this device if 
audit logging is enabled. In the above example, it is being set to "8512". The value can be set per one's application.

### `SYSLOG_PROTOCOL`

This is the protocol set to device used as audit record repository. Archive device emits audit messages to this device if 
audit logging is enabled. In the above example, it is being set to "UDP". The value can be set per one's application.

### `STORAGE_DIR`

This is the URI of the storage location where the objects of a study will be stored when studies are sent to the archive.
In the above example, it is being set to "/storage/fs1". The value can be set per one's application.