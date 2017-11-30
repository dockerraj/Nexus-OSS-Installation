# Installation of OSS NEXUS Server on CentOS 7

Parameters of server, where the OSS NEXUS Server will be deployed.

```
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
```

## What we expect to have on the server.

Since OSS Nexus is tested and validated on Java version 8 (Java 9 is not yet recommended [PurpleBooth](https://help.sonatype.com/display/NXRM3/System+Requirements)), we need e.g. `jdk-8u151-linux-x64.rpm` from [PurpleBooth](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html) as for 29.11.2017.

More precisely from here [PurpleBooth](http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-x64.rpm) as for 29.11.2017.

Also we need the OSS Nexus itself, e.g. `nexus-3.6.1-02-unix.tar.gz` from [PurpleBooth](https://www.sonatype.com/download-oss-sonatype) as for 29.11.2017

Both of these packages suppose to be located on `/opt` partition of the server.

## Installation

Installation requires making executable `chmod +x install-sonatype-nexus3.sh` the `install-sonatype-nexus3.sh` script and executing it `./install-sonatype-nexus3.sh`, it's self explanatory. Take into account that it will create user `nexus` and the user will be an owner of the service and the folder `/var/nexus`.

## Uninstallation

To uninstall the OSS Nexus server, one need make the uninstallation script executable `chmod +x uninstall-sonatype-nexus3.sh` the `uninstall-sonatype-nexus3.sh` script and executing it `./uninstall-sonatype-nexus3.sh`, it's self explanatory.

## Migration

It will be there soon.

[Erekle Magradze](erekle@magradze.de)

# OSS NEXUS სერვერის ინსტალაცია CentOS 7-ზე

სერვერის პარამეტრები, რომელზეც ყენდება OSS NEXUS.

```
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
```

## რა უნდა გვქონდეს სერვერზე.

რადგან OSS Nexus შემოწმებულია და დამოწმებულია Java-ს მე-8 ვერსიისთვის (Java-ს მე-9 ვერსიის გამოყენება ჯერ რეკომენდირებული არ არის იხ. [PurpleBooth](https://help.sonatype.com/display/NXRM3/System+Requirements)), საჭიროა მაგალითად შემდეგი პაკეტის `jdk-8u151-linux-x64.rpm` ჩამოტვირთვა [PurpleBooth](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html) ბმულიდან 29.11.2017-ის მდგომარეობით.

უფრო კონკრეტულად კი Java-ს მე-8 ვერსიის საინსტალაციო შეიძლება ჩამოქაჩული იქნას [PurpleBooth](http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-x64.rpm) ბმულიდან 29.11.2017-ის მდგომარეობით.

ჯავას გარდა საჭიროა თვითონ OSS Nexus, მაგალითად ერთ-ერთი ბოლო და სტაბილური ვერსია `nexus-3.6.1-02-unix.tar.gz`, რომელიც შეიძლება მოიქაჩოს შემდეგი [PurpleBooth](https://www.sonatype.com/download-oss-sonatype) ბმულიდან 29.11.2017-ის მდგომარეობით.

ჯავაც და ნექსუსის პაკეტებიც განთავსებული უნდა იყოს სერვერის `/opt` დისკზე.

## დაყენება

ინსტალაცია საჭიროებს რომ `install-sonatype-nexus3.sh` სკრიპტი გახდეს გაშვებადი `chmod +x install-sonatype-nexus3.sh` და ამის შემდეგ საჭიროა მხოლოდ სცრიპტის გაშვება `./install-sonatype-nexus3.sh`, სკრიპტი გაშვების ეტაპებზე იძლევა შესაბამის ინფორმაციას. საინსტალაციო სკრიპტი ქმნის მომხმარებელს სახელით `nexus` და მის მფლობელობაში გადააქვს დაყენებული სერვერის სამუშაო და საკონფიგურაციო დირექტორიები `/var/nexus`.

## წაშლა

OSS Nexus-ის წასაშლელად საჭიროა რომ შესაბამისი სკრიპტი გახდეს გაშვებადი სისტემაში, რაც მიღწევადია შემდეგი ბრძანებით `chmod +x uninstall-sonatype-nexus3.sh` რის შემდეგაც საჭიროა სკრიპტის გაშვება  `./uninstall-sonatype-nexus3.sh`, მუშაობის პროცესში ტერმინალში გამოტანილი იქნება შესაბამისი შეტყობინებები, რაც უფრო ცხადს გახდის თუ რა ეტაპზეა სერვერის წაშლის პროცესი.

## გადატანა

...

[ერეკლე მაღრაძე](erekle@magradze.de)