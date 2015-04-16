Steps to install tomcat as Service in Linux machine

Here are the steps require to install on a new machine:
NOTE: These assume that the latest server are installed in /usr/local/server. 

All commands must be ran as root.

1) Create the tomcat group and user:
	groupadd tomcat
	useradd -g tomcat tomcat

2) Copy the tomcat script to /etc/init.d and make it executable:
	cp tomcat /etc/init.d/tomcat
	chmod +x /etc/init.d/tomcat

3) Install the tomcat service:
	chkconfig tomcat --levels 35 on

4) Make sure that everything in /usr/local/server is owned by tomcat
	chown -R tomcat:tomcat /usr/local/server

5) Start the tomcat service:
	service tomcat start