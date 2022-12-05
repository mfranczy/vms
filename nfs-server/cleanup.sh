#!/bin/sh

virsh destroy nfs-server 
virsh undefine nfs-server
rm focal-server-cloudimg-amd64.raw
