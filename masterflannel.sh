#!/usr/bin/bash
set -E
#IT IS IMPORTANT TO include user-data for ec2 instance for ubuntu 22.04 file.. when creating the instance on AWS
# https://raw.githubusercontent.com/rangapv/QuikFix/master/awsuserdata.txt
#Install the runtime in this case it is the containerd
source <(curl -s https://raw.githubusercontent.com/rangapv/runtimes/main/runcontainerD.sh)
#Call the init.d command
source <(curl -s https://raw.githubusercontent.com/rangapv/k8s/master/kube_adm/k8sinit-adm.sh)
#Call the flannel and dashboard install
source <(curl -s https://raw.githubusercontent.com/rangapv/k8s/master/kube_adm/k8sfladash.sh)
#To install Statefulset
source <(curl -s https://raw.githubusercontent.com/rangapv/Kube-Manifests/master/StatefulSet/aws/ebs-csi/install-csi.sh)
