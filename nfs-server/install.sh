#!/bin/bash

set -eu

#genisoimage -output seed.iso -volid cidata -joliet -rock user-data meta-data network-data

cloud-localds -v --network-config=network-data.yaml seed.qcow2 user-data.yaml 

qemu-img convert -f qcow2 -O raw focal-server-cloudimg-amd64.img focal-server-cloudimg-amd64.raw
qemu-img resize focal-server-cloudimg-amd64.raw 20G

virt-install \
  --virt-type kvm \
  --name nfs-server \
  --ram 4096 \
  --vcpus 2 \
  --network network=default \
  --graphics none \
  --os-type=linux --os-variant=ubuntu20.04 \
  --disk=./focal-server-cloudimg-amd64.raw,device=disk,bus=virtio \
  --disk=./seed.qcow2,device=cdrom \
  --console pty,target_type=serial \
  --import
