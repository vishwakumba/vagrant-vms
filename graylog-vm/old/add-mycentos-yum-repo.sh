#!/bin/bash

cat <<SECTION > /tmp/mycentos.repo
[mycentos]
name=mycentos packages
baseurl=http://mycentos-yum-repo.myworld.net/centos7
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
SECTION

sudo mkdir -p /etc/yum.repos.d-${NOW}
sudo mv /etc/yum.repos.d/* /etc/yum.repos.d-${NOW}/
sudo cp /tmp/mycentos.repo /etc/yum.repos.d/
sudo yum clean all
echo

