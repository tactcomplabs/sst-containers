# sst-containers
Development Repository for Sandia Structural Simulation Toolkit Containerization

## Introduction

This repository contains the necessary scripts and tools to construct various 
different styles of containers for the [Sandia SST Infrastructure](http://sst-simulator.org/).

## Containers

### Preinstallation

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
