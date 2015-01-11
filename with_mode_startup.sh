#!/bin/bash

# ifbeat is a config file
source /usr/local/beats/config.properties

export JAVA_HOME=/usr/java/jdk1.7.0_60
export JRE=/usr/java/jdk1.7.0_60/jre
export CLASSPATH=.:$JAVA_HOME/lib:$JRE_HOME/lib:$CLASSPATH
export PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$PATH

# if var beat equal true,then start heartbeat. 
if [ "$cfg_beat" == "true" ]; then
    
    service heartbeat start >> /usr/local/beats/heartbeat_startup.log
    java -jar $cfg_switchguard_jar >> /usr/local/beats/switchguard_running.log

fi
 
