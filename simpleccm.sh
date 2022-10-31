#!/bin/bash
set -E
#Run this script with ./simpleccm.sh Access_ID Secret_id
#Assumption the ubuntu 22.04 ec2 instance has been populated with user data and Role k8srole is attached

# setup the master node with Tag, Nodename format etc
source <(curl -s https://raw.githubusercontent.com/rangapv/metascript/main/metasetup.sh)  >>/dev/null 2>&1

# run containerdD runtime
source <(curl -s https://raw.githubusercontent.com/rangapv/runtimes/main/runcontainerD.sh)  >>/dev/null 2>&1

# TO install latest version of k8s for the Master/Control Node
source <(curl -s https://raw.githubusercontent.com/rangapv/k8s/master/kube_adm/k8sinit-adm.sh)  >>/dev/null 2>&1

#To install flannel and Dashboard
source <(curl -s https://raw.githubusercontent.com/rangapv/k8s/master/kube_adm/k8sfladash.sh)  >>/dev/null 2>&1

#To Install the cloud-provider flags on the components & kubelet
source <(curl -s https://raw.githubusercontent.com/rangapv/metascript/main/ccmstyle.sh)  >>/dev/null 2>&1

#To install the RBAC for CCM
`kubectl apply -f https://raw.githubusercontent.com/rangapv/Kube-Manifests/master/CCM/ccm-rbac-outree.yaml`

#To install the AWS Cloud COntroller Manager
`kubectl apply -f https://raw.githubusercontent.com/rangapv/Kube-Manifests/master/CCM/aws/ccm-aws-outtree.yaml`

echo "check the pods kunectl get pods --all-namespaces"
