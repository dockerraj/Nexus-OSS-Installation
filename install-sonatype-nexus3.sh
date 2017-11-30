#!/bin/bash
echo "Step 1 \ninstallation of epel repository, Development Packages and update of the system."
sleep 2

yum install epel-release -y
yum groupinstall "Development Tools" -y
yum update -y


echo "Step 2 \nInstallation of JDK, initialization of java home, if it is not installed already."
sleep 2

rpm -qa | grep jdk > /dev/null 
is_jdk_installed=$(echo $?)

if [ $is_jdk_installed -eq 0 ]; then
	echo "JDK is installed"
else
	jdk_package_name=$(echo `ls -alF /opt | grep jdk- | grep bin.rpm`)
	if [ -z "$jdk_package_name" ]; then
		echo "jdk...bin.rpm package is not located on /opt, make sure that you copied it in /opt."
	else
		jdk_package_name=$(echo $jdk_package_name | tr ' ' '\n' | tail -1)
		rpm -ihv /opt/$jdk_package_name
	fi

fi	

cat /etc/profile | grep JAVA_
is_java_home_defined=$(echo $?)
if [ $is_java_home_defined -eq 0 ]; then
	echo "JAVA_HOME is defined."
else
	echo -e "#Java Environment \nexport JAVA_HOME=\"/usr/java/default\" \nexport PATH=$JAVA_HOME/bin:$PATH" >> /etc/profile
	source /etc/profile
	echo "Validating the JAVA_HOME location and java installation"
	sleep 1
	java -version
	sleep 1
	echo "JAVA_HOME location is" $JAVA_HOME
fi	


echo "Step 3 \nGet the exact name of the nexus tar.gz file"
sleep 2
nexus_package_name=$(echo `ls -alF /opt | grep nexus | grep tar.gz`)

if [ -z "$nexus_package_name" ]; then
      echo "nexus...tar.gz package is not located on /opt, make sure that you copied it in /opt."
else
      nexus_package_name=$(echo $nexus_package_name | tr ' ' '\n' | tail -1)
      echo "Nexus package name" /opt/$nexus_package_name
      sleep 1
      nexus_dir="/var/nexus"
      if [ ! -d "$nexus_dir" ]; then
      	mkdir $nexus_dir
      	tar -zxvf /opt/$nexus_package_name -C $nexus_dir
      	echo "Tunning the Nexus JVM settings"
		sleep 2
		nexus_vmoptions_filename=`find / -name nexus.vmoptions`
		sed -i "/-Xms1200M/c\-Xms2703M" $nexus_vmoptions_filename
		sed -i "/-Xmx1200M/c\-Xmx2703M" $nexus_vmoptions_filename
		sed -i "/-XX:MaxDirectMemorySize=2G/c\-XX:MaxDirectMemorySize=2703M" $nexus_vmoptions_filename
		sleep 2
		echo "Update the JVM path in the nexus runner script"
		nexus_runner_script=`find / -name nexus | grep bin`
		sed -i "/# INSTALL4J_JAVA_HOME_OVERRIDE=/c\INSTALL4J_JAVA_HOME_OVERRIDE=/usr/java/default" $nexus_runner_script
		echo -e "[Unit] \nDescription=nexus service \nAfter=network.target \n\n[Service] \nType=forking \nLimitNOFILE=65536 \nExecStart="$nexus_runner_script" start \nExecStop="$nexus_runner_script" stop \nUser=root \nRestart=on-abort \n[Install] \nWantedBy=multi-user.target \n" > /etc/systemd/system/nexus.service
		systemctl daemon-reload
		systemctl enable nexus
		firewall-cmd --permanent --add-port=8081/tcp
		firewall-cmd --reload
		systemctl start nexus		
	  else
	  	echo $nexus_dir" already exists"	
	  fi
fi