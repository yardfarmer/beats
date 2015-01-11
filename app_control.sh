#!/bin/bash
# application running state control

# read config

source /usr/local/beats/config.properties

basepath=$cfg_basepath
# application runtime logs.
runtimelog=$cfg_basepath/$cfg_runtimelogname
# application running pid
runningpid=$cfg_basepath/$cfg_runningpid

case "$1" in
    
    start)
	nohup java -jar $cfg_app1 > $runtimelog 2>&1 &
        echo $! > $runningpid
	chmod 755 $runningpid
	#chown oracle server.pid
	;;
	
    stop)
	kill `cat $runningpid`
        rm -rf $runningpid
	;;

    restart)
	$0 stop
	sleep 1
 	$0 start
	;;

    *)
     	echo "Usage: app_control.sh(start|stop|restart)"
	;;
esac

exit 0
