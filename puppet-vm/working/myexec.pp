#
class myexec(
  $first_name = 'Clark',
  $last_name = 'Kent',
) {

  exec { 'do-good-work' :
    command     => "/vagrant/learn-puppet/myexec.sh",
    environment => ["FIRST_NAME=${first_name}", "LAST_NAME=${last_name}"],
    logoutput   => true,
  }
}

include myexec
