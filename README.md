# CompareAndDeploy

### 准备工作:
将执行机器的公钥存放到目标服务器上
```
ssh-keygen
ssh-copy-id root@ip
```
获取目标服务器上所有的chart名称存放到Standard.txt中
```
:%s/:.*//g
```
将想要发版的chart与版本以":"分割，添加到Inputs.txt,以来源为Excel文档的版本为例，用 =C3&":"&H3 将单元格内容拼接成目标格式

### 步骤：
1. 执行sh getLocalCharts.sh 获取目标服务器上的chart版本。测试服务器的IP可通过修改脚本中的IP地址，或者通过命令行传参。
2. 执行sh getCharts2Deploy.sh 获取Inputs.txt与目标服务器不一致的版本并保存到ToDeploy.txt
3. 打开ToDeploy.txt文件查看需要升级的chart和其版本
4. 打开log.txt查看其他信息，比如多个pod；Inputs.txt未给出版本号的chart

### 未完成功能
1. 直接调用接口对比较结果进一步处理
