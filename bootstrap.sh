#!/bin/bash -e
#
# Copyright (C) 2017-2021 Tactical Computing Laboratories, LLC
# All Rights Reserved
# contact@tactcomplabs.com
#
# See LICENSE in the top level directory for licensing details
#

SSTCORE_11_0_0="sstcore-11.0.0.tar.gz"
SSTCORE_11_1_0="sstcore-11.1.0.tar.gz"
SSTCORE_12_1_0="sstcore-12.1.0.tar.gz"
SSTELEMENTS_11_0_0="sstelements-11.0.0.tar.gz"
SSTELEMENTS_11_1_0="sstelements-11.1.0.tar.gz"
SSTELEMENTS_12_1_0="sstelements-12.1.0.tar.gz"

SSTCORE_11_0_0_URL="https://github.com/sstsimulator/sst-core/releases/download/v11.0.0_Final/sstcore-11.0.0.tar.gz"
SSTCORE_11_1_0_URL="https://github.com/sstsimulator/sst-core/releases/download/v11.1.0_Final/sstcore-11.1.0.tar.gz"
SSTCORE_12_1_0_URL="https://github.com/sstsimulator/sst-core/releases/download/v12.0.1_Final/sstcore-12.0.1.tar.gz"
SSTELEMENTS_11_0_0_URL="https://github.com/sstsimulator/sst-elements/releases/download/v11.0.0_Final/sstelements-11.0.0.tar.gz"
SSTELEMENTS_11_1_0_URL="https://github.com/sstsimulator/sst-elements/releases/download/v11.1.0_Final/sstelements-11.1.0.tar.gz"
SSTELEMENTS_12_1_0_URL="https://github.com/sstsimulator/sst-elements/releases/download/v12.0.1_Final/sstelements-12.0.1.tar.gz"

SSTCORE_11_0_0_SHA1="a1d0dd4f6b0c4216c35589179da0f677bbe5fdf3"
SSTCORE_11_1_0_SHA1="9e2d6efcf94e395555de5ceb6a5c7c19f5684892"
SSTCORE_12_1_0_SHA1="2d601101d88dfca8ad032d71e43a6ce3197ebe81"
SSTELEMENTS_11_0_0_SHA1="8b9e779a8ace79a2d5767692a65505c63d3c5cd1"
SSTELEMENTS_11_1_0_SHA1="8f2050e907466f32d8e2f81f1622aab1db3011e0"
SSTELEMENTS_12_1_0_SHA1="a3917fdae7bf1c89efa5b7252f2db1527117529c"

GETCMD=""
SHA1SUM=""

MY_LN=`which ln`
MY_PWD=`pwd`

setup_get()  {
  if [ -x `which wget` ]
  then
    GETCMD="wget -O"
  elif [ -x `which curl` ]
  then
    GETCMD="curl --output"
  else
    echo "Error: could not find WGET or CURL to download files"
    exit -1
  fi
}

setup_sha1() {
  if [ -x `which sha1sum` ]
  then
    SHA1SUM="sha1sum"
  else
    echo "Error: could not find SHA1SUM command"
    exit -1
  fi
}

check_container_tools() {
  if [ -x `which singularity` ]
  then
    echo "Singularity: FOUND"
  else
    echo "Singularity: MISSING"
  fi

  if [ -x `which docker` ]
  then
    echo "Docker: FOUND"
  else
    echo "Docker: MISSING"
  fi
}

download_packages_11() {
  #-- SST 11.0.0
  $GETCMD $SSTCORE_11_0_0 $SSTCORE_11_0_0_URL >> /dev/null 2>&1
  $GETCMD $SSTELEMENTS_11_0_0 $SSTELEMENTS_11_0_0_URL >> /dev/null 2>&1

  if test -f "$SSTCORE_11_0_0"; then
    echo "Downloaded $SSTCORE_11_0_0"
  else
    echo "Failed to download $SSTCORE_11_0_0"
    exit -1
  fi

  if test -f "$SSTELEMENTS_11_0_0"; then
    echo "Downloaded $SSTELEMENTS_11_0_0"
  else
    echo "Failed to download $SSTELEMENTS_11_0_0"
    exit -1
  fi
}

download_packages_111() {
  #-- SST 11.1.0
  $GETCMD $SSTCORE_11_1_0 $SSTCORE_11_1_0_URL >> /dev/null 2>&1
  $GETCMD $SSTELEMENTS_11_1_0 $SSTELEMENTS_11_1_0_URL >> /dev/null 2>&1

  if test -f "$SSTCORE_11_1_0"; then
    echo "Downloaded $SSTCORE_11_1_0"
  else
    echo "Failed to download $SSTCORE_11_1_0"
    exit -1
  fi

  if test -f "$SSTELEMENTS_11_1_0"; then
    echo "Downloaded $SSTELEMENTS_11_1_0"
  else
    echo "Failed to download $SSTELEMENTS_11_1_0"
    exit -1
  fi
}

download_packages_121() {
  #-- SST 12.1.0
  $GETCMD $SSTCORE_12_1_0 $SSTCORE_12_1_0_URL >> /dev/null 2>&1
  $GETCMD $SSTELEMENTS_12_1_0 $SSTELEMENTS_12_1_0_URL >> /dev/null 2>&1

  if test -f "$SSTCORE_12_1_0"; then
    echo "Downloaded $SSTCORE_12_1_0"
  else
    echo "Failed to download $SSTCORE_12_1_0"
    exit -1
  fi

  if test -f "$SSTELEMENTS_12_1_0"; then
    echo "Downloaded $SSTELEMENTS_12_1_0"
  else
    echo "Failed to download $SSTELEMENTS_12_1_0"
    exit -1
  fi
}

verify_packages_11() {
  #-- get the sha1 of the package
  SSTCORE_SHA1=`$SHA1SUM $SSTCORE_11_0_0 | awk '{print $1}'`
  SSTELEMENTS_SHA1=`$SHA1SUM $SSTELEMENTS_11_0_0 | awk '{print $1}'`

  if [ "$SSTCORE_SHA1" = "$SSTCORE_11_0_0_SHA1" ]; then
    echo "SSTCORE 11 SHA1 VERIFIED!"
  else
    echo "FAILED TO VERIFY SSTCORE 11 SHA1 HASH"
    exit -1
  fi

  if [ "$SSTELEMENTS_SHA1" = "$SSTELEMENTS_11_0_0_SHA1" ]; then
    echo "SSTELEMENTS 11 SHA1 VERIFIED!"
  else
    echo "FAILED TO VERIFY SSTCORE 11 SHA1 HASH"
    exit -1
  fi

}

verify_packages_111() {
  #-- get the sha1 of the package
  SSTCORE_SHA1=`$SHA1SUM $SSTCORE_11_1_0 | awk '{print $1}'`
  SSTELEMENTS_SHA1=`$SHA1SUM $SSTELEMENTS_11_1_0 | awk '{print $1}'`

  if [ "$SSTCORE_SHA1" = "$SSTCORE_11_1_0_SHA1" ]; then
    echo "SSTCORE 11.1.0 SHA1 VERIFIED!"
  else
    echo "FAILED TO VERIFY SSTCORE 11.1.0 SHA1 HASH"
    exit -1
  fi

  if [ "$SSTELEMENTS_SHA1" = "$SSTELEMENTS_11_1_0_SHA1" ]; then
    echo "SSTELEMENTS 11.1.0 SHA1 VERIFIED!"
  else
    echo "FAILED TO VERIFY SSTCORE 11.1.0 SHA1 HASH"
    exit -1
  fi

}

verify_packages_121() {
  #-- get the sha1 of the package
  SSTCORE_SHA1=`$SHA1SUM $SSTCORE_12_1_0 | awk '{print $1}'`
  SSTELEMENTS_SHA1=`$SHA1SUM $SSTELEMENTS_12_1_0 | awk '{print $1}'`

  if [ "$SSTCORE_SHA1" = "$SSTCORE_12_1_0_SHA1" ]; then
    echo "SSTCORE 12.1.0 SHA1 VERIFIED!"
  else
    echo "FAILED TO VERIFY SSTCORE 12.1.0 SHA1 HASH"
    exit -1
  fi

  if [ "$SSTELEMENTS_SHA1" = "$SSTELEMENTS_12_1_0_SHA1" ]; then
    echo "SSTELEMENTS 12.1.0 SHA1 VERIFIED!"
  else
    echo "FAILED TO VERIFY SSTCORE 12.1.0 SHA1 HASH"
    exit -1
  fi

}

setup_symlinks_11() {
  $MY_LN -fs $MY_PWD/$SSTCORE_11_0_0 ./containers/singularity/$SSTCORE_11_0_0
  $MY_LN -fs $MY_PWD/$SSTELEMENTS_11_0_0 ./containers/singularity/$SSTELEMENTS_11_0_0
}

setup_symlinks_111() {
  $MY_LN -fs $MY_PWD/$SSTCORE_11_1_0 ./containers/singularity/$SSTCORE_11_1_0
  $MY_LN -fs $MY_PWD/$SSTELEMENTS_11_1_0 ./containers/singularity/$SSTELEMENTS_11_1_0
}

setup_symlinks_121() {
  $MY_LN -fs $MY_PWD/$SSTCORE_12_1_0 ./containers/singularity/$SSTCORE_12_1_0
  $MY_LN -fs $MY_PWD/$SSTELEMENTS_12_1_0 ./containers/singularity/$SSTELEMENTS_12_1_0
}

#-- STAGE1: Setup the download mechanism
setup_get
setup_sha1

#-- STAGE2: Check for container tools
check_container_tools

#-- STAGE3: Download our packages
download_packages_11
download_packages_111
download_packages_121

#-- STAGE4: Verify the packages
verify_packages_11
verify_packages_111
verify_packages_121

#-- STAGE5: Setup the symlinks
setup_symlinks_11
setup_symlinks_111
setup_symlinks_121

echo "Bootstrapping complete!"

exit 0

# EOF
