cat <<SECTION > /tmp/mylocal.repo
[mylocal]
name=mylocal packages
baseurl=http://mycentos-yum-repo.myworld.net/mylocal
gpgcheck=0
SECTION

sudo cp /tmp/mylocal.repo /etc/yum.repos.d/
sudo yum clean all
echo

