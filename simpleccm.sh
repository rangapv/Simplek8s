#!/bin/bash
set -E
#Run this script with ./simpleccm.sh Access_ID Secret_id
#Assumption the ubuntu 22.04 ec2 instance has been populated with user data and Role k8srole is attached

echo "Setting up the machine "
# setup the master node with Tag, Nodename format etc
source <(curl -s https://raw.githubusercontent.com/rangapv/metascript/main/metasetup.sh)  >>/dev/null 2>&1

echo "Installing runtime ContainerD...."
# run containerdD runtime
source <(curl -s https://raw.githubusercontent.com/rangapv/runtimes/main/runcontainerD.sh)  >>/dev/null 2>&1
echo "FINISHED installing runtime ContainerD"

echo "Installing the k8s core components...."
# TO install latest version of k8s for the Master/Control Node
source <(curl -s https://raw.githubusercontent.com/rangapv/k8s/master/kube_adm/k8sinit-adm.sh)  >>/dev/null 2>&1
echo "FINISHED Installing the k8s core components"

echo "Installing the Networking and Dashboard..."
#To install flannel and Dashboard
source <(curl -s https://raw.githubusercontent.com/rangapv/k8s/master/kube_adm/k8sfladash.sh)  >>/dev/null 2>&1
echo "FINISHED Installing the Networking and Dashboard..."

echo "Setting up the machine for Cloud Controller nitty gritty"
#To Install the cloud-provider flags on the components & kubelet
source <(curl -s https://raw.githubusercontent.com/rangapv/metascript/main/ccmstyle.sh)  >>/dev/null 2>&1

while (true)
do
	{
        podc=`kubectl get po --all-namespaces | awk '{ split($0,a," "); if (a[4] == "Running") print a[4] }' | wc -l 2> /dev/null`
	if [[ (( $podc -gt 7 )) ]]
	then
	        sleep 10s
		break
	fi
	echo "Waiting for k8s components to be in the Running state..."
	}
done

echo "Installing CCM RBAC"
#To install the RBAC for CCM
`kubectl apply -f https://raw.githubusercontent.com/rangapv/Kube-Manifests/master/CCM/ccm-rbac-outree.yaml`

echo "Installing CCM for AWS"
#To install the AWS Cloud COntroller Manager
`kubectl apply -f https://raw.githubusercontent.com/rangapv/Kube-Manifests/master/CCM/aws/ccm-aws-outtree.yaml`

echo "check the pods kubectl get pods --all-namespaces"
