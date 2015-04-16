#!/bin/sh 
# # chkconfig: - 99 1 
# ### BEGIN INIT INFO 
# Provides: suresh 
# Required-Start: $remote_fs $syslog 
# Required-Stop: $remote_fs $syslog 
# Default-Start: 3 5 
# Default-Stop: 0 1 2 4 6 
# Short-Description: Start and stop Tomcat 
# Description: Enable Tomcat service provided by daemon. 
### END INIT INFO 

# Source function library. . 
/etc/init.d/functions 

# Get config. . 
/etc/sysconfig/network 

# Check that networking is up. 
[ "${NETWORKING}" = "no" ] && exit 0 

export SURESH_USER=suresh 
export CATALINA_HOME="/usr/local/server" 
STARTUP=$CATALINA_HOME/bin/startup.sh 
SHUTDOWN=$CATALINA_HOME/bin/shutdown.sh 
start() { 
	echo -n "Starting Tomcat Instance" 
	cd $CATALINA_HOME /bin/
	su $SURESH_USER 
	$STARTUP 
	echo "done" 
}
 
stop() { 
	echo -n "Shutting down Tomcat Instance" 
	cd $CATALINA_HOME /bin/
	su $SURESH_USER 
	$SHUTDOWN 
	echo "done." 
} 

status() { 
	NUMPROC=`ps -fu $SURESH_USER | grep catalina | grep -v "grep catalina" | wc -l` 
	if [ $NUMPROC -gt 0 ]; then 
		echo "Tomcat is running..." 
	else 
		echo "Tomcat is stopped..." 
	fi 
}
 
restart(){
   stop
   start
}

#how it called
case "$1" in 
start)
   start
   ;;
stop)
   stop
   ;;
status)
   status
   ;;
restart)
   restart
   ;;
*)
	echo $"Usage: $0 {start|stop|status|restart}" 
	exit 1 
esac