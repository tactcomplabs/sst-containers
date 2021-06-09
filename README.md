# sst-containers
Development Repository for Sandia Structural Simulation Toolkit Containerization

## Introduction

This repository contains the necessary scripts and tools to construct various 
different styles of containers for the [Sandia SST Infrastructure](http://sst-simulator.org/).

## Containers

### Preinstallation

#### CentOS7 Notes

* CentOS/RHEL 7 does not provide a package for `newuidmap` and `newgidmap`, so you may need to
  compile/install `shadow-utils` separately.

We have included a sample bootstrap script that initializes the container environment 
and verifies that various tools are already installed on the target system.  The script
assumes that you are utilizing a Linux/Unix environment with the `BASH` shell installed.  
The script searches for the installed tools, downloads the necessary SST release packages 
and verifies the packages using their equivalent SHA1 checksums.  Bootstrapping your environment 
can be performed using the following command:

`$> ./bootstrap.sh`

### Singularity

This repository contains two types of singularity containers.  The first includes the SST-Core
package and the second contains the SST-Core and SST-Elements packages.  The naming 
convention for the singularity `def` files is as follows:

* sstcore-VERSION-OS.def : SST-Core only
* sstpackage-VERSION-OS.def : SST-Core + SST-Elements

The version numbers supported are listed as follows:
* 11.0.0 : SST 11.0.0 Release
* MASTER : SST github master branches

The supported operating systems are listed as follows:
* ubuntu-18.04
* ubuntu-20.04
* centos7
* centos8

Building one or more singularity containers can be performed using the following commands:
(edit the commands for your particular environment)
```
$> cd ./containers/singularity/
$> sudo singularity build sstcore-11.0.0-ubuntu-18.04.sif sstcore-11.0.0-ubuntu-18.04.def
```

#### Using Singularity's `fakeroot`
To create a singularity container without using `sudo` privilages it is possible to use
singularity's `fakeroot` option.  Depending on your Linux kernel version, additional
system configuration steps must be taken. 

* On CentOS7 you must first run:
```
$> sudo sh -c 'echo user.max_user_namespaces=15000 >/etc/sysctl.d/90-max_net_namespaces.conf'

$> sudo sysctl -p /etc/sysctl.d /etc/sysctl.d/90-max_net_namespaces.conf
```

Once your OS is properly configured (if necessary) the easiest way to enable `fakeroot`
on singularity >= v3.5 is:
```
sudo /usr/local/bin/singularity config fakeroot --add <your_user_name>
```
The above command will modify user mappings set in `/etc/subuid` and group mappings 
in `/etc/subgid`. 

Once built, the container functions as normal. The `.def` files in this repo work with 
or without the `fakeroot` switch and can be built using a command similar to the example below:
```
singularity build --fakeroot sstcore-11.0.0-centos7.sif sstcore-11.0.0-centos7.def
```

Verifying that the container was build successfully can be performed using the following:
```
$> singularity exec sstcore-11.0.0-ubuntu-18.04.sif sst --help
```

### Docker

Coming soon....

## Contributors

* *John Leidel* - *Chief Scientist* - [Tactical Computing Labs](http://www.tactcomplabs.com)
* *David Donofrio* - *Chief Hardware Architect* - [Tactical Computing Labs](http://www.tactcomplabs.com)
* *Matthew Barondeau* - *Research Engineer* - [Tactical Computing Labs](http://www.tactcomplabs.com)

## Acknowledgements
* None at this time
