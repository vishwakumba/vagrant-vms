#
class profile::il2_database {
    notify { 'il2_database..' : }

    file { '/tmp/database.conf' :
      content => epp('profile/il2_database.epp'),
      mode    => '0644',
  }
}