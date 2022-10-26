#!/usr/bin/bash
set -E
#IT IS IMPORTANT TO include user-data for ec2 instance for ubuntu 22.04 file.. when creating the instance on AWS
# https://raw.githubusercontent.com/rangapv/QuikFix/master/awsuserdata.txt
#Install the runtime in this case it is the containerd
source <(curl -s https://raw.githubusercontent.com/rangapv/runtimes/main/runcontainerD.sh)
#Call the init.d command
source <(curl -s https://raw.githubusercontent.com/rangapv/k8s/master/kube_node/k8snodeinstall.sh)
#Call this after TRANSFERRING config file from master via ftp 
source <(curl -s https://raw.githubusercontent.com/rangapv/metascript/main/nodeconfig.sh)
#Then the JOIN command from master node(flag.txt file)
