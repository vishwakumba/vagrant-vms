#
class profile::il3_database {
    notify { 'il3_database..' : }

    $password_1000 = hiera('IL3_DATABASE_PASSWORD')

    file { '/tmp/database.conf' :
      content => epp('profile/il3_database.epp'),
      mode    => '0644',
  }
}