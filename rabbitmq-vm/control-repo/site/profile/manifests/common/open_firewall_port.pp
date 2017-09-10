# Opens a firewall port using the native firewall-cmd command if the port is not open
define profile::common::open_firewall_port(
  $port,
) {
  exec { "opening-port-${port}" :
    command => "/usr/bin/firewall-cmd --zone=public --add-port=${port}/tcp --permanent",
    onlyif  => "/usr/bin/firewall-cmd --zone=public --query-port=${port}/tcp --permanent | grep no",
    notify  => Exec["firewall-reload-port-${port}"],
  }

  exec { "firewall-reload-port-${port}" :
    command     => '/usr/bin/firewall-cmd --reload',
    refreshonly => true,
  }
}
