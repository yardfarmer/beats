#!/bin/bash

echo "switchover guard start working..."

#this heartbeat config contain virtual ip
source /usr/local/beats/config.properties


declare -a myips=$(ifconfig | grep 'inet addr' | sed 's/^.*inet addr://g'| cut -d ' ' -f1)

isprim=false


for ip in $myips
do
	echo my ip:"$ip"
	# vip is in  heartbeat's config file, means virutal ip
	# this marchine will be primary node, start java application
	if [ "$ip" == "$cfg_vip" ]; then  
		
		isprim=true

		# if this is primary DB, then set the synchroinze flag,it will let to copy data to standby DB.
      sed -i 's/^cfg_dbsync_mode=.*$/cfg_dbsync_mode=true/' /usr/local/beats/config.properties

		echo  catched virutal ip "$ip", now will be start application.
	       
	        ls $cfg_basepath/$cfg_runningpid  &> /dev/null 

		# pid exist
		if [ "$?" == 0 ]; then 
		
		    # validate pid
		    ps `cat $c$cfg_basepath/$cfg_runningpi` > /dev/null
		
		    if [ "$?" == 0 ]; then 
              	          echo "already startup"

		    # if pid exist, but application already stoped. 
		    else 
			 /etc/rc.d/init.d/app_control.sh  stop 	
			 /etc/rc.d/init.d/app_control.sh  start	
			
		    fi

		else 	
		    
			 /etc/rc.d/init.d/app_control.sh  start	

		fi		
		
		ls /usr/local/beats/tomcat.pid > /dev/null
		#netstat -an | grep $cfg_tomcat_port | grep "LISTEN" &> /usr/local/beats/tomcat.pid
		if [ "$?" != 0 ]; then 
			`$cfg_tomcat_bin/startup.sh` > /usr/local/beats/tomcat.pid
			   
		fi
		
		
	fi
done

#this machine from primary changed to standby
if [ "$isprim" == false ]; then 
	
	# if not primay role, set the DB synchronize flag to false.
	sed -i 's/^cfg_dbsync_mode=.*$/cfg_dbsync_mode=false/' /usr/local/beats/config.properties

	echo "not primary machine,stop applications "
        /etc/rc.d/init.d/app_control.sh  stop
	 &> /dev/null && echo "shutdown success" || echo "shutdown faild"
	# stop tomcat 
	`$cfg_tomcat_bin/shutdown.sh`
 	 rm -rf /usr/local/beats/tomcat.pid
fi

