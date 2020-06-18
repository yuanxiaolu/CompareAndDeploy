#!/bin/sh

todeployfile="ToDeploy.txt"

if [ $1 -eq "15" ];then _PROJECT_ENV_ID="5"
elif [ $1 -eq "241" ];then _PROJECT_ENV_ID="83"
elif [ $1 -eq "65" ];then _PROJECT_ENV_ID="118"
elif [ $1 -eq "96" ];then _PROJECT_ENV_ID="151"
else echo "PROJECT_ENV_ID was not configured!" exit
fi

IP=
Port=

# get token
curl --silent -L -c ./token.txt --user-agent Mozilla/5.0 -d '{"name": "","password": ""}' http://${IP}:${Port}/v1/auth/login > login.log
token=$(cat ./token.txt | xargs -n 1 | sed '26!d')

for eachline in `cat ${todeployfile}`; do
RepoName=`echo $eachline | sed 's/:.*//g'`;
if [ "$RepoName" == "" ]; then RepoName="";
fi
app_id=`cat apps.json | jq -r --arg RepoName "$RepoName" '.items[] | select(.name==$RepoName) | .id'`
chart_version=`echo $eachline | sed 's/.*://g'`;
echo $RepoName - $app_id - $chart_version;
done
