#!/bin/sh

todeployfile="ToDeploy.txt"

if [ $1 -eq "15" ];then GALAXIAS_PROJECT_ENV_ID="5"
elif [ $1 -eq "241" ];then GALAXIAS_PROJECT_ENV_ID="83"
elif [ $1 -eq "65" ];then GALAXIAS_PROJECT_ENV_ID="118"
elif [ $1 -eq "96" ];then GALAXIAS_PROJECT_ENV_ID="151"
else echo "GALAXIAS_PROJECT_ENV_ID was not configured!" exit
fi

IP=
Port=

# get token
curl --silent -L -c ./token.txt --user-agent Mozilla/5.0 -d '{"name": "","password": ""}' http://${IP}:${Port}/v1/auth/login > login.log
token=$(cat ./token.txt | xargs -n 1 | sed '26!d')

for eachline in `cat ${todeployfile}`; do
RepoName=`echo $eachline | sed 's/:.*//g'`;
if [ "$RepoName" == "gpu-searcher" ]; then RepoName="engine-timespace-feature-db";
fi
app_id=`cat apps.json | jq -r --arg RepoName "$RepoName" '.items[] | select(.name==$RepoName) | .id'`
chart_version=`echo $eachline | sed 's/.*://g'`;
echo $RepoName - $app_id - $chart_version;
done

# curl -X  POST   http://{galaxias-ip}:32001/v1/deployments   -H 'Accept: */*'   -H 'Connection: keep-alive'   -H 'Content-Type: application/json'   -H "Cookie: hibext_instdsigdipv2=1; token=\"${token}\"; userKey=33,hibext_instdsigdipv2=1; token=\"${token}\"; userKey=33; token=\"${token}\""   -d "{\"app_id\":{\"id\":${app_id}},\"chart_name\":\"${RepoName}\",\"chart_version\":\"${chart_version}\",\"description\":\"A Helm chart for Kubernetes\",\"project_env_id\":{\"id\":${GALAXIAS_PROJECT_ENV_ID}}}"
