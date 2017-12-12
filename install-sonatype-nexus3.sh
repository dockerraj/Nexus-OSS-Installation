#!/bin/bash

nexus_service_isactive_status=`systemctl is-active nexus`
if [ $nexus_service_isactive_status == "unknown" ]; then
	printf "Nexus service has not been detected, we will continue installation.\n"
	sleep 1
elif [ $nexus_service_isactive_status == "inactive" ]; then
	printf "Nexus service is stopped and seems to be installed. \nIf you want to re-install it, first use uninstall-sonatype-nexus3.sh script.\n"
	systemctl disable nexus
	sleep 1
	exit 3
elif [ $nexus_service_isactive_status == "active" ]; then
	printf "Aparently you already installed Nexus service. \nIf you want to re-install it, first use uninstall-sonatype-nexus3.sh script.\n"
	sleep 1
	exit 3
else
	printf "Something fishy is going on here. \nScript will be stopped now!!!\n"
	sleep 1
	exit 3
fi

printf "Step 1 \ninstallation of epel repository, Development Packages and update of the system."
sleep 2

yum install epel-release -y
yum groupinstall "Development Tools" -y
yum update -y

printf "Step 2 \nInstallation of JDK, initialization of java home, if it is not installed already."
sleep 2

rpm -qa | grep jdk > /dev/null 
is_jdk_installed=$(echo $?)

if [ $is_jdk_installed -eq 0 ]; then
	printf "JDK is installed\n"
else
	jdk_package_name=$(echo `ls -alF /opt | grep jdk- | grep .rpm`)
	if [ -z "$jdk_package_name" ]; then
		printf "jdk...rpm package is not located on /opt, make sure that you copied it in /opt.\n"
	else
		jdk_package_name=$(echo $jdk_package_name | tr ' ' '\n' | tail -1)
		rpm -ihv /opt/$jdk_package_name
	fi

fi	

cat /etc/profile | grep JAVA_
is_java_home_defined=$(echo $?)
if [ $is_java_home_defined -eq 0 ]; then
	printf "JAVA_HOME is defined.\n"
else
	echo -e "#Java Environment \nexport JAVA_HOME=\"/usr/java/default\" \nexport PATH=$JAVA_HOME/bin:$PATH" >> /etc/profile
	source /etc/profile
	printf "Validating the JAVA_HOME location and java installation\n"
	sleep 1
	java -version
	sleep 1
	printf "JAVA_HOME location is" $JAVA_HOME
fi	

printf "Adding user nexus (if it doesn't exist), for running the service under it.\n"
sleep 2
id nexus
nexus_id_check_exit_code=`echo $?`
if [ $nexus_id_check_exit_code -eq 0 ]; then
	printf "user nexus exists\n"
else
	useradd nexus
	printf "User nexus appended to the system\n"
fi		

printf "Step 3 \nGet the exact name of the nexus tar.gz file\n"
sleep 2
nexus_package_name=$(echo `ls -alF /opt | grep nexus | grep tar.gz`)

if [ -z "$nexus_package_name" ]; then
      printf "nexus...tar.gz package is not located on /opt, make sure that you copied it in /opt.\n"
else
      nexus_package_name=$(echo $nexus_package_name | tr ' ' '\n' | tail -1)
      printf "Nexus package name" /opt/$nexus_package_name
      sleep 1
      nexus_dir="/var/nexus"
      if [ ! -d "$nexus_dir" ]; then
      	mkdir $nexus_dir
      	tar -zxvf /opt/$nexus_package_name -C $nexus_dir
      	printf "Tunning the Nexus JVM settings"
		sleep 2
		nexus_vmoptions_filename=`find / -name nexus.vmoptions`
		sed -i "/-Xms1200M/c\-Xms2703M" $nexus_vmoptions_filename
		sed -i "/-Xmx1200M/c\-Xmx2703M" $nexus_vmoptions_filename
		sed -i "/-XX:MaxDirectMemorySize=2G/c\-XX:MaxDirectMemorySize=2703M" $nexus_vmoptions_filename
		sleep 2
		printf "Update the JVM path in the nexus runner script"
		nexus_runner_script=`find / -name nexus | grep bin`
		sed -i "/# INSTALL4J_JAVA_HOME_OVERRIDE=/c\INSTALL4J_JAVA_HOME_OVERRIDE=/usr/java/default" $nexus_runner_script
		echo -e "[Unit] \nDescription=nexus service \nAfter=network.target \n\n[Service] \nType=forking \nLimitNOFILE=65536 \nExecStart="$nexus_runner_script" start \nExecStop="$nexus_runner_script" stop \nUser=nexus \nRestart=on-abort \n[Install] \nWantedBy=multi-user.target \n" > /etc/systemd/system/nexus.service
		systemctl daemon-reload
		systemctl enable nexus
		firewall-cmd --permanent --add-port=8081/tcp
		firewall-cmd --reload
		chown -R nexus.nexus /var/nexus
		systemctl start nexus		
	  else
	  	printf $nexus_dir" already exists"	
	  fi
fi