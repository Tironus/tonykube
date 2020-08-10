#!/bin/bash

ncsdir=/opt/ncs/current
confdir=/etc/ncs
rundir=/var/opt/ncs
logdir=/var/log/ncs

. $ncsdir/ncsrc
NCS_CONFIG_DIR=${confdir}
NCS_RUN_DIR=${rundir}
NCS_LOG_DIR=${logdir}

curl -XPUT 'http://elasticsearch:9200/_template/filebeat' -d@/etc/filebeat/filebeat.template.json -H "Content-Type:application/json"
/etc/init.d/filebeat start

export NCS_CONFIG_DIR NCS_RUN_DIR NCS_LOG_DIR
/opt/ncs/current/bin/ncs --cd $rundir --foreground -c /etc/ncs/ncs.conf
