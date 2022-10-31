#!/bin/bash
set -E
#Run this script with ./simplenodeccm.sh Access_ID Secret_id
#Assumption the ubuntu 22.04 ec2 instance has been populated with user data and Role k8srole is attached
#SFTP the kubeconfig file from the master node to this particualr worker node(ec2 instance)
#Keep the JOIN comand handy....

# setup the node with Tag, Nodename format etc
source <(curl -s https://raw.githubusercontent.com/rangapv/metascript/main/metasetup.sh)  >>/dev/null 2>&1

# run containerdD runtime
source <(curl -s https://raw.githubusercontent.com/rangapv/runtimes/main/runcontainerD.sh)  >>/dev/null 2>&1

# TO install latest version of k8s for the Worker Node
source <(curl -s https://raw.githubusercontent.com/rangapv/k8s/master/kube_node/k8snodeinstall.sh)  >>/dev/null 2>&1

# TO setup config file transferred from Master node 
source <(curl -s https://raw.githubusercontent.com/rangapv/metascript/main/nodeconfig.sh)  >>/dev/null 2>&1

#To CCM only configure the cloud-provider flags on the kubelet
source <(curl -s https://raw.githubusercontent.com/rangapv/metascript/main/ccmstyle.sh)  >>/dev/null 2>&1

#
echo "Component install complete sudo kubeadm join ....NOW"
