if [ -z "$1" ];
then
ip="";
else
ip=$1;
fi

file="LocalCharts.txt"

line='$9'
ssh root@${ip} "helm list --col-width 200 | sed 1d | awk '{print $line}' | sort | uniq"  > ./${file}
