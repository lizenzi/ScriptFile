#!/bin/bash

# 定义变量方便修改
APP=spm

# 如果是输入的日期按照取输入日期；如果没输入日期取当前时间的前一天
if [ -n "$1" ] ;then
        do_date=$1
else
        do_date=`date -d "-1 day" +%F`
fi

sql="
set hive.exec.dynamic.partition.mode=nonstrict;

insert overwrite table "$APP".dwd_host_hostcpu
PARTITION (dt='$do_date')
select 
    get_json_object(line,'$.cpu_id') cpu_id,
    get_json_object(line,'$.host_id') host_id,
    get_json_object(line,'$.cpu_percent') cpu_percent,
    get_json_object(line,'$.cpu_count1') cpu_count1,
    get_json_object(line,'$.cpu_count2') cpu_count2,
    get_json_object(line,'$.cpu_nice') cpu_nice,
    get_json_object(line,'$.cpu_irq') cpu_irq,
    get_json_object(line,'$.cpu_iowait') cpu_iowait,
    get_json_object(line,'$.cpu_idle') cpu_idle,
    get_json_object(line,'$.cpu_system') cpu_system,
    get_json_object(line,'$.cpu_user') cpu_user,
    get_json_object(line,'$.cpu_times_percent_idle') cpu_times_percent_idle,
    get_json_object(line,'$.cpu_times_percent_system') cpu_times_percent_system,
    get_json_object(line,'$.cpu_times_percent_user') cpu_times_percent_user,
    get_json_object(line,'$.context switch') context switch,
    get_json_object(line,'$.run queue') run queue
from "$APP".ods_host_hostcpu
where dt='$do_date';


insert overwrite table "$APP".dwd_host_hostmem
PARTITION (dt='$do_date')
select 
    get_json_object(line,'$.mem_id') mem_id,
    get_json_object(line,'$.mem_total') mem_total,
    get_json_object(line,'$.mem_used') mem_used,
    get_json_object(line,'$.mem_free') mem_free,
    get_json_object(line,'$.mem_unit') mem_unit,
    get_json_object(line,'$.host_id') host_id
from "$APP".ods_host_hostmem
where dt='$do_date';



insert overwrite table "$APP".dwd_redis_keyspace
PARTITION (dt='$do_date')
select 
    get_json_object(line,'$.db_id') db_id,
    get_json_object(line,'$.host_id') host_id,
    get_json_object(line,'$.db_device') db_device,
    get_json_object(line,'$.db_keys') db_keys,
    get_json_object(line,'$.db_expires') db_expires,
    get_json_object(line,'$.avg_ttl') avg_ttl,
    get_json_object(line,'$.tcp_port') tcp_port
  from "$APP".dwd_redis_keyspace
where dt='$do_date';


insert overwrite table "$APP".dwd_spark_hdfs_application
PARTITION (dt='$do_date')
select 
    get_json_object(line,'$.application_name') application_name
  from "$APP".dwd_spark_hdfs_application
where dt='$do_date';


insert overwrite table "$APP".dwd_kubernetes_pods
PARTITION (dt='$do_date')
select 
    get_json_object(line,'$.host_id') host_id,
    get_json_object(line,'$.pod_name') pod_name,
    get_json_object(line,'$.namespace') namespace,
    get_json_object(line,'$.uid') uid,
    get_json_object(line,'$.create_time') create_time,
    get_json_object(line,'$.node_name') node_name,
    get_json_object(line,'$.host_ip') host_ip,
    get_json_object(line,'$.pod_ip') pod_ip,
    get_json_object(line,'$.status') status,
    get_json_object(line,'$.start_time') start_time
    from "$APP".dwd_kubernetes_pods
where dt='$do_date';


insert overwrite table "$APP".dwd_kubernetes_services
PARTITION (dt='$do_date')
select 
    get_json_object(line,'$.host_id') host_id,
    get_json_object(line,'$.service_name') service_name,
    get_json_object(line,'$.namespace') namespace,
    get_json_object(line,'$.uid') uid,
    get_json_object(line,'$.create_time') create_time,
    get_json_object(line,'$.cluster_ip') cluster_ip,
    get_json_object(line,'$.ports') ports,
    get_json_object(line,'$.type') type,
    get_json_object(line,'$.app_name') app_name
    from "$APP".dwd_kubernetes_services
where dt='$do_date';

insert overwrite table "$APP".dwd_kubernetes_containers
PARTITION (dt='$do_date')
select 
    get_json_object(line,'$.host_id') host_id,
    get_json_object(line,'$.pod_name') pod_name,
    get_json_object(line,'$.namespace') namespace,
    get_json_object(line,'$.pod_uid') pod_uid,
    get_json_object(line,'$.image') image,
    get_json_object(line,'$.container_name') container_name,
    get_json_object(line,'$.host_ip') host_ip,
    get_json_object(line,'$.image_id') image_id,
    get_json_object(line,'$.container_id') container_id,
    get_json_object(line,'$.ready') ready,
    get_json_object(line,'$.restart_count') restart_count,
    get_json_object(line,'$.kc_id') kc_id
    from "$APP".ods_kubernetes_containers
where dt='$do_date';

"

hive -e "$sql"
