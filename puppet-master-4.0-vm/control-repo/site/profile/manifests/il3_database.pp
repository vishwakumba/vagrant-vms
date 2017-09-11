#
class profile::il3_database {
    notify { 'il3_database..' : }

    file { '/tmp/database.conf' :
      content => epp('profile/il3_database.epp'),
      mode    => '0644',
  }
}