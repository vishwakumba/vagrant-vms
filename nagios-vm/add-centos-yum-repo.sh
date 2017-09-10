cat <<SECTION > /tmp/mycentos.repo
[mycentos]
name=CentOS-\$releasever - Base
baseurl=http://mycentos-yum-repo.myworld.net/centos7
gpgcheck=0
SECTION

sudo mkdir -p /etc/yum.repos.d-${NOW}
sudo mv /etc/yum.repos.d/* /etc/yum.repos.d-${NOW}/
sudo cp /tmp/mycentos.repo /etc/yum.repos.d/
sudo yum clean all

LINE="192.168.150.150      mycentos-yum-repo.myworld.net"
sudo sed -i "$ a $LINE" /etc/hosts
echo

