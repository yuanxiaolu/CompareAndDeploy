localfile=`ls | grep -i LocalCharts.txt`
inputfile="Inputs.txt"
standardfile="Standard.txt"
todeployfile="ToDeploy.txt"

logfile="log.txt"
delimiter=":"

current_time=`date "+%Y-%m-%-dT%H:%M:%S.100%:z"`
echo $current_time >> $logfile

# 如果文件存在则删除
if [ -e $todeployfile ]; then rm $todeployfile; fi
# 清理日志文件
#if [ -e $logfile ]; then rm $logfile; fi

for eachline in `cat $standardfile`;do
num=`grep -c -e "$eachline$delimiter" $localfile`;
num_input=`grep -c "$eachline" $inputfile`;
# 如果当前环境存在0个chart,则去inputfile找,找不到则告警缺少chart,找到了则写到 todeployfile文件中
# 如果当前环境存在1个chart,则去inputfile找,找不到则提示inputfile未给出chart版本,写入log.txt; 找到后比较,相同不管,不相同则写到 todeployfile文件中
# 如果当前环境存在多个chart,则打印告警信息,手工处理
if [ $num -eq 0 ]; then
        if [ $num_input -eq 0 ];then
                echo "请手动检查未部署chart:" $eachline >> $logfile;
        elif [ $num_input -eq 1 ];then
                grep -i $eachline $inputfile >> $todeployfile;        
        fi
elif [ $num -eq 1 ];then
        chart_local=`cat $localfile | grep -e "$eachline$delimiter"`;
        chart_input=`cat $inputfile | grep -e "$eachline$delimiter"`;
        if [ $num_input -eq 0 ]; then
                echo "暂保留本机版本," $inputfile "未给出版本chart: " $eachline >> $logfile;
        elif [ $chart_local != $chart_input ]; then
                grep -i $eachline $inputfile >> $todeployfile;
        fi
elif [ $num -gt 1 ];then
echo "请手动检查多个pod的chart:" $eachline >> $logfile;
fi
done
