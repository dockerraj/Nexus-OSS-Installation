#Requirements

VM (KVM Virtualization)
CentOS Linux release 7.4.1708 (Core) 
Memory: 8192 MB
cpu: 4 cores (vendor_id	: GenuineIntel, cpu family:6, model:61, model name:Intel Core Processor (Broadwell),stepping:2, cpu MHz:2195.170, cache size:4096 KB)

File System layout
/dev/mapper/centos-root   32G   64M   32G   1% /
/dev/mapper/centos-usr    32G  892M   32G   3% /usr
/dev/sda1                2.0G  143M  1.9G   7% /boot
/dev/mapper/centos-opt    16G   33M   16G   1% /opt
/dev/mapper/centos-var   250G  139M  250G   1% /var
/dev/mapper/centos-home   16G   33M   16G   1% /home

Logical volume layout

--- Logical volume ---
LV Path                /dev/centos/swap
...
LV Size                2.00 GiB
...

--- Logical volume ---
LV Path                /dev/centos/root
...
LV Size                32.00 GiB
...

--- Logical volume ---
LV Path                /dev/centos/home
...
LV Size                16.00 GiB
...

--- Logical volume ---
LV Path                /dev/centos/var
...
LV Size                250.00 GiB
...

--- Logical volume ---
LV Path                /dev/centos/usr
...
LV Size                32.00 GiB
...

--- Logical volume ---
LV Path                /dev/centos/opt
...
LV Size                <16.00 GiB
...

#Expected Packages

jdk-8u151-linux-x64.rpm from http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html as for 29.11.2017

[http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-x64.rpm] as for 29.11.2017

nexus-3.6.1-02-unix.tar.gz from https://www.sonatype.com/download-oss-sonatype as for 29.11.2017

Both of these packages suppose to be located on /opt partition.