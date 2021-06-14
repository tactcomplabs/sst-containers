#!/bin/bash -xe
which yum
singularity build --fakeroot sstcore-11.0.0-centos7.sif sstcore-11.0.0-centos7.def
