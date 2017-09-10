#!/bin/bash

vagrant destroy -f mygraylog
vagrant up mygraylog
vagrant halt mygraylog
vagrant up mygraylog
vagrant ssh mygraylog -c "/vagrant/install-graylog.sh /vagrant/vagrant-graylog.config"
echo Done
