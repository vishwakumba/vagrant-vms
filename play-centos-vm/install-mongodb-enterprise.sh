#!/bin/bash

MONGODB_VERSION="3.4.0"

function install_mongodb() {
  sudo yum install -y -e 0 -d 1 mongodb-enterprise-server-${MONGODB_VERSION}
  sudo yum install -y -e 0 -d 1 mongodb-enterprise-shell-${MONGODB_VERSION}
}

function create_mongodb_repo() {
  cat << EOM > /tmp/css-mongodb-enterprise-local.repo
[css-mongodb-enterprise-local]
name=CSS MongoDB Enterprise Local Repo
baseurl=http://artifactory.itsshared.net:8081/artifactory/css-mongodb-enterprise-local
enabled=1
gpgcheck=0
EOM

  sudo cp /tmp/css-mongodb-enterprise-local.repo /etc/yum.repos.d/
  rm /tmp/css-mongodb-enterprise-local.repo
}

#--------------------------------------------------------------------------

echo "Installing MongoDB Enterprise.."

create_mongodb_repo

install_mongodb

echo Done

