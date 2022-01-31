#!/bin/bash -e
# -----------------------------------------------------------------------------
#
# Package       : azure-mgmt-cosmosdb
# Version       : 0.5.2
# Source repo   : https://github.com/Azure/azure-sdk-for-python
# Tested on		: UBI 8.5
# Language      : Python
# Travis-Check  : True
# Script License: Apache License, Version 2 or later
# Maintainer	: Saurabh Gore <Saurabh.Gore@ibm.com> 
#
# Disclaimer: This script has been tested in root mode on given
# ==========  platform using the mentioned version of the package.
#             It may not work as expected with newer versions of the
#             package and/or distribution. In such case, please
#             contact "Maintainer" of this script.
#
# ----------------------------------------------------------------------------

PACKAGE_NAME=azure-sdk-for-python
PACKAGE_VERSION="${1:-azure-mgmt-cosmosdb_0.5.2}"
PACKAGE_URL=https://github.com/Azure/azure-sdk-for-python.git

#To install dependencies.
yum install -y git  python3 python3-devel make gcc-c++ rust-toolset openssl openssl-devel libffi libffi-devel 

#clone the repo.
git clone $PACKAGE_URL
cd $PACKAGE_NAME/
git checkout $PACKAGE_VERSION

python3 -m pip install pytest pytest-cov setuptools-rust 

python3 scripts/dev_setup.py

cd azure-mgmt-cosmosdb

python3 setup.py install

if ! pytest ; then   
	echo "------------------Build Success but test fails---------------------"
else
	echo "------------------Build and test success-------------------------"
fi
