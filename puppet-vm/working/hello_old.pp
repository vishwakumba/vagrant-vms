class hello_old {

 file { '/home/vagrant/dest.txt' : 
   source => '/home/vagrant/src.txt',
   notify => Exec['stop-service'],
 }

 exec { 'stop-service' : 
  command => '/bin/echo Stopping Service..',
  refreshonly => true,
  notify => Exec['start-service'],
 }

 exec { 'start-service' : 
  command => '/bin/echo Starting Service..',
  refreshonly => true,
 }

}

include hello

