#!/bin/bash
echo "Step 1 \nIt is assumed that for installation of sonatype nexus the install-sonatype-nexus3.sh has been use. \nOtherwise it is not recommended to use this script for uninstallation of OSS Sonatype Nexus server. \nRun this script as root. \nNow checking if service is running."
sleep 2

nexus_service_isactive_status=`systemctl is-active nexus`
if [ $nexus_service_isactive_status == "unknown" ]; then
	echo "Are you sure that nexus is installed with the install-sonatype-nexus3.sh script? \nMAKE SURE THAT install-sonatype-nexus3.sh script is used and come back to this script after. /nFor now Bye"
	sleep 1
	exit 3
elif [ $nexus_service_isactive_status == "inactive" ]; then
	echo "Nexus service is stopped and now it will be disabled"
	systemctl disable nexus
	sleep 1
elif [ $nexus_service_isactive_status == "active" ]; then
	echo "Nexus service will be stopped and disabled"
	systemctl stop nexus
	systemctl disable nexus
	sleep 1
else
	echo "Something fishy is going on here. \nScript will be stopped now!!!"
	sleep 1
	exit 3
fi

echo "Step 2 \nRemoving nexus.service file, from /etc/systemd/system."
sleep 2

nexus_service_file="/etc/systemd/system/nexus.service"
if [[ -f $nexus_service_file ]]; then
	rm -rf $nexus_service_file
	echo $nexus_service_file" file got removed."
	systemctl daemon-reload
	sleep 1
else
	echo $nexus_service_file" file does not exist."
	sleep 1
fi

nexus_service_file_multiuser="/etc/systemd/system/multi-user.target.wants/nexus.service"

if [[ -f $nexus_service_file_multiuser ]]; then
        rm -rf $nexus_service_file_multiuser
        echo $nexus_service_file_multiuser" file got removed."
        systemctl daemon-reload
        sleep 1
else
        echo $nexus_service_file_multiuser" file does not exist."
        sleep 1
fi

echo "Step 3 \nClosing nexus tcp port 8081."
sleep 2
firewall-cmd --list-ports | grep 8081
firewall_port_check=$?
if [ $firewall_port_check -eq 0 ]; then
	echo "Nexus port - 8081/tcp is open, we are closing it now."
	firewall-cmd --permanent --remove-port 8081/tcp
	firewall-cmd --reload
else
	echo "Either nexus port - 8081/tcp is not open, or it has not been open ever."
	sleep 1
fi

echo "Step 4 \nRemoving nexus installation folder."
sleep 2

nexus_dir="/var/nexus"
if [[ -d $nexus_dir ]]; then
	rm -rf $nexus_dir
	echo "nexus installation folder has been removed"
	sleep 1
else
	echo "nexus installation folder does not exist! \nTry to use install-sonatype-nexus3.sh script first."
	sleep 1
	exit 1
fi

echo "Step 5 \nRemoval of user nexus"
userdel nexus
sleep 1
