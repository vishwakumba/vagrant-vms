#!/bin/bash

echo "Step 1: Destroying the VM if present.."
echo vagrant destroy -f 
vagrant destroy -f 
echo

echo "Step 2: Creating the VM.."
echo vagrant up 
vagrant up 
echo
echo "*******Before restarting the VM, the sestatus information********"
echo vagrant ssh -c sestatus
vagrant ssh -c sestatus
echo

# As selinux is enabled, the VM needs to be restarted after creating it.
echo "Step 3: Stopping the VM.."
echo vagrant halt 
vagrant halt
echo 

echo "Step 4: Restarting the VM.."
echo vagrant up 
vagrant up 
echo
echo "*******After restarting the VM, the sestatus information********"
echo vagrant ssh -c sestatus
vagrant ssh -c sestatus
echo

echo Done
