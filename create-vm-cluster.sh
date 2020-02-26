#/bin/bash
cd /
sudo su
mkdir /vm_store
mkdir /vm_store/virtual_machines
vboxmanage createvm --name "kube-master" --register
vboxmanage createvm --name "sub-node1" --register
vboxmanage createvm --name "sub-node2" --register
vboxmanage createvdi --filename /vm_store/virtual_machines/kube-master/kube-master-vdisk01.vdi --size 30000
vboxmanage createvdi --filename /vm_store/virtual_machines/sub-node1/sub-node1-vdisk01.vdi --size 30000
vboxmanage createvdi --filename /vm_store/virtual_machines/sub-node2/sub-node2-vdisk01.vdi --size 30000
echo "Configuring resources. You might be prompted to select the right network interface. Assumed eth0\n"
vboxmanage modifyvm "kube-master" --cpus 1 --memory 1024 --acpi on --boot1 dvd --nic1 bridged --bridgeadapter1 eth0 --cableconnected1 on --ostype Debian_64
vboxmanage modifyvm "sub-node1" --cpus 1 --memory 1024 --acpi on --boot1 dvd --nic1 bridged --bridgeadapter1 eth0 --cableconnected1 on --ostype Debian_64
vboxmanage modifyvm "sub-node2" --cpus 1 --memory 1024 --acpi on --boot1 dvd --nic1 bridged --bridgeadapter1 eth0 --cableconnected1 on --ostype Debian_64
echo "Sata Controllers\n"
vboxmanage storagectl "kube-master" --name "SATA Controller" --add sata
vboxmanage storagectl "sub-node1" --name "SATA Controller" --add sata
vboxmanage storagectl "sub-node2" --name "SATA Controller" --add sata
echo "Disks and installation paths\n"
vboxmanage storageattach "kube-master" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium /vm_store/virtual_machines/kube-master/kube-master-vdisk01.vdi
vboxmanage storageattach "sub-node1" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium /vm_store/virtual_machines/sub-node1/sub-node1-vdisk01.vdi
vboxmanage storageattach "sub-node2" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium /vm_store/virtual_machines/sub-node2/sub-node2-vdisk01.vdi
vboxmanage storageattach "kube-master" --storagectl "SATA Controller" --port 1 --device 0 --type dvddrive --medium /vm_store/debian-10min.iso
vboxmanage storageattach "sub-node1" --storagectl "SATA Controller" --port 1 --device 0 --type dvddrive --medium /vm_store/debian-10min.iso
vboxmanage storageattach "sub-node2" --storagectl "SATA Controller" --port 1 --device 0 --type dvddrive --medium /vm_store/debian-10min.iso
echo "Starting the first installation\n"
vboxmanage startvm kube-master --type gui &
vboxmanage startvm sub-node1 --type gui &
vboxmanage startvm sub-node2 --type gui &

echo "Check IPs\n"
nmap -T5 -sP 192.168.1.0-255
echo "Running nodes\n"
vboxmanage startvm kube-master --type headless &
vboxmanage startvm sub-node1 --type headless &

