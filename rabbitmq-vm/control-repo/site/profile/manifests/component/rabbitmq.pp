# This class installs rabbitmq-server
class profile::component::rabbitmq(
  $user,
  $password,
  $vhost,
  $admin_user,
  $admin_password,
  $port         = hiera('rabbitmq::port'),
  $admin_enable = hiera('rabbitmq::admin_enable'),
  $admin_port   = hiera('rabbitmq::management_port'),
) {

  include rabbitmq

  rabbitmq_user { $user :
    admin    => false,
    password => $password,
  }

  rabbitmq_vhost { $vhost :
    ensure => present,
  }

  rabbitmq_user_permissions { "${user}@${vhost}" :
    configure_permission => '.*',
    read_permission      => '.*',
    write_permission     => '.*',
  }

  if ( $admin_enable == true ) {
    rabbitmq_user { $admin_user :
      admin    => true,
      password => $admin_password,
    }

    rabbitmq_user_permissions { "${admin_user}@${vhost}" :
      configure_permission => '.*',
      read_permission      => '.*',
      write_permission     => '.*',
    }
  }

  profile::common::open_firewall_port { 'rabbitmq-port' :
    port => $port,
  }
  profile::common::open_firewall_port { 'rabbitmq-admin-port' :
    port => $admin_port
  }

  file { ['/usr/local/gysp', '/usr/local/gysp/utils' ] :
    ensure => directory,
    mode   => '0755',
  }

  file {'/usr/local/gysp/utils/uninstall-rabbitmq.sh' :
    ensure => 'present',
    source => 'puppet:///modules/profile/utils/uninstall-rabbitmq.sh',
    mode   => '0755',
  }

}

