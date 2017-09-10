#!/bin/bash

modulename="mongod"

sudo yum install policycoreutils-python -y 

cp ${modulename}.te /var/tmp/${modulename}.te
checkmodule -M -m -o /var/tmp/${modulename}.mod /var/tmp/${modulename}.te
semodule_package -o  /var/tmp/${modulename}.pp -m /var/tmp/${modulename}.mod
semodule -i /var/tmp/${modulename}.pp

echo Done
