#!/bin/bash
set -e
azagent_folder=~/azagent

if [ -z "$1" ] ; then
  echo "Missing argument"
  exit 1
fi
if [ -z "$2" ] ; then
  echo "Missing argument"
  exit 1
fi
if [ -z "$3" ] ; then
  echo "Missing argument"
  exit 1
fi

deploymentgroupname=$1
projectname=$2
token=$3

mkdir $azagent_folder

curl -fkSL -o $azagent_folder/vstsagent.tar.gz https://vstsagentpackage.azureedge.net/agent/3.218.0/vsts-agent-linux-x64-3.218.0.tar.gz;
tar -zxvf $azagent_folder/vstsagent.tar.gz

if [ -x "$(command -v systemctl)" ]
	then ./config.sh --unattended --deploymentgroup --deploymentgroupname $deploymentgroupname --acceptteeeula --agent $HOSTNAME --url https://dev.azure.com/netigate/ --work _work --projectname $projectname --auth PAT --token $token --runasservice; sudo ./svc.sh install; sudo ./svc.sh start;
else
	./config.sh --unattended --deploymentgroup --deploymentgroupname $deploymentgroupname --acceptteeeula --agent $HOSTNAME --url https://dev.azure.com/netigate/ --work _work --projectname $projectname --auth PAT --token $token; ./run.sh;
fi