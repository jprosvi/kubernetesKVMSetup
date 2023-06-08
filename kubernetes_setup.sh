#!/bin/bash
if [ ${#@} -ne 1 ]
then 
	exit 1
fi

# Creating snapshots 
sudo qemu-img create -f qcow2 -F qcow2 -b /var/lib/libvirt/images/k8s_control.qcow2 /var/lib/libvirt/images/test_images/"${1}_control".qcow2 
sudo qemu-img create -f qcow2 -F qcow2 -b /var/lib/libvirt/images/k8s_worker1.qcow2 /var/lib/libvirt/images/test_images/"${1}_worker1".qcow2 
sudo qemu-img create -f qcow2 -F qcow2 -b /var/lib/libvirt/images/k8s_worker2.qcow2 /var/lib/libvirt/images/test_images/"${1}_worker2".qcow2 

function createVM() {
sudo virt-install --name "${1}" \
--os-variant ubuntu22.04 \
--ram 8192 \
--disk path=/var/lib/libvirt/images/test_images/"${1}".qcow2,format=qcow2 \
--network bridge=kvmbr0 \
--vcpus 2 \
--import \
--noautoconsole
}

createVM "${1}_control"
createVM "${1}_worker1"
createVM "${1}_worker2"
