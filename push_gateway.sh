#!/bin/bash

instance_name=`hostname -f |cut -d '.' -f1`

if [ $instance_name == "localhost" ];then
    echo "must FQDN hostname"
    exit 1
fi

# for waiting connections
label="count_netstat_wait_connnections" # 定义一个新的key
count_netstat_wait_connnections=`netstat -an |grep -i wait|wc -l`

echo "$label: $count_netstat_wait_connnections"

# --data-binary  将HTTP POST请求中的数据发送给HTTP 服务器(push gateway), 与用户提价HTML表单是浏览器的行为完全一样。 HTTP POST请求中的数据为纯二进制数据
echo "$label $count_netstat_wait_connnections" |curl --data-binary @- http://216.172.109.149:9091/metrics/job/pushgateway/instance/$instance_name

# url 地址分为三个部分
#http://216.172.109.149:9091/metrics/job/pushgateway/ 这是url的主Location

#job/pushgateway 推送到哪一个prometehus.yaml定义的job里

#instance/$instance_name  推送后显示的机器名是什么