if [ -z "$1" ];
then
ip="";
else
ip=$1;
fi

file="LocalCharts.txt"

ssh root@${ip} 'for file in `kubectl get pods --all-namespaces -o jsonpath="{.items[*].spec.containers[*].image}"`;do echo $file;done | awk -F\/ "{print $NF}" | sort | uniq' > ./${file}
sed -i 's/.*\///' ${file}
