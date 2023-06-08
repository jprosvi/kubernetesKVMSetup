#!/bin/bash
if [ ${#@} -ne 1 ]
then 
	exit 1
fi

sudo virsh undefine "${1}_control"
sudo virsh undefine "${1}_worker1"
sudo virsh undefine "${1}_worker2"
