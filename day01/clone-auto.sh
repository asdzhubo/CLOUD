#!/bin/bash
VMDIR=/var/lib/libvirt/images

read -p "number of vms: " number
if [[ ! "$number" =~ ^[0-9]+$ ]]; then
    echo "you must input a number."
    exit 1
fi

if [ $number -le 0 -o $number -gt 9 ]; then
    echo "number out of range(1~9)."
    exit 2
fi

VMNUM=$number
if [ $VMNUM -le 9 ];then
VMNUM=0$VMNUM
fi

counter=0
vms=0
num=$(virsh  list --all | grep asd  | wc -l)
if [ $num -ge 9 ];then
  echo -e "\033[31m You already have 9 virtual machines \033[0m"
  exit 3
fi

while [ $vms -lt $number ]
do
    let counter++
    newvm=asd_node${counter}
    if [ -f ${VMDIR}/${newvm}.img ]; then
        continue
    fi

qemu-img create -b ${VMDIR}/node.qcow2 -f qcow2 ${VMDIR}/${newvm}.img  16G	&>  /dev/null

sed "s,node,${newvm},"  ${VMDIR}/node.xml > /etc/libvirt/qemu/${newvm}.xml	

virsh define /etc/libvirt/qemu/${newvm}.xml  &> /dev/null

    echo -e "created ${newvm}\t\t\t\t\t\033[32;1m[Done]\033[0m"
    let vms++
done








