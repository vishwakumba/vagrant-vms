# This is the base role containing the resources that will be present on all nodes 
class profile::common::base(
  $artifactory_url,
  $yum_repo,
) {
  notify { "Environment=${::environment}": }
  notify { "FQDN=${::fqdn}": }
  notify { "IP Address=${::ipaddress}": }

  yumrepo {  $yum_repo:
    enabled         => 1,
    descr           =>  "${yum_repo} Repo",
 #   baseurl         => "${artifactory_url}/artifactory/${yum_repo}",
     baseurl         => "http://192.168.150.150/mylocal",
    gpgcheck        => 0,
    metadata_expire => '1m',
  }
}
