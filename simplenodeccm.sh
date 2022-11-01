#!/bin/bash
set -E
#Run this script with ./simplenodeccm.sh Access_ID Secret_id
#Assumption the ubuntu 22.04 ec2 instance has been populated with user data and Role k8srole is attached
#SFTP the kubeconfig file from the master node to this particualr worker node(ec2 instance)
#Keep the JOIN comand handy....

# setup the node with Tag, Nodename format etc
source <(curl -s https://raw.githubusercontent.com/rangapv/metascript/main/metasetup.sh)  >>/dev/null 2>&1

echo "Installing runtime ContainerD...."
# run containerdD runtime
source <(curl -s https://raw.githubusercontent.com/rangapv/runtimes/main/runcontainerD.sh)  >>/dev/null 2>&1
echo "FINISHED installing runtime ContainerD"

echo "Installing the k8s core components for the Node...."
# TO install latest version of k8s for the Worker Node
source <(curl -s https://raw.githubusercontent.com/rangapv/k8s/master/kube_node/k8snodeinstall.sh)  >>/dev/null 2>&1
echo "FINISHED Installing the k8s core components for the Node"

echo "Setting up the config file "
# TO setup config file transferred from Master node 
source <(curl -s https://raw.githubusercontent.com/rangapv/metascript/main/nodeconfig.sh)  >>/dev/null 2>&1

echo "Setting up the machine for Cloud Controller nitty gritty"
#To CCM only configure the cloud-provider flags on the kubelet
source <(curl -s https://raw.githubusercontent.com/rangapv/metascript/main/ccmstyle.sh)  >>/dev/null 2>&1
#
echo "check the pods \"kubectl get pods --all-namespaces\" & ensure they are Running "
#
echo "Execute the JOIN command got fromt eh \"flag.txt\" file from the Control Plane"
#
echo "Check the CLuster status \"kubectl get nodes\""
