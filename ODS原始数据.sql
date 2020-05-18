ODS层的原始数据：

drop table if exists ods_kubernetes_pods;
CREATE EXTERNAL TABLE ods_kubernetes_pods
(
`host_id` string,
`pod_name` string, 
`namespace` string, 
`uid` string, 
`create_time` string, 
`node_name` string, 
`host_ip` string,
`pod_ip` string,
`status` string,
`start_time` string
)
partitioned by (dt string)
stored as parquet
location '/warehouse/spm/ods/ods_kubernetes_pods';





drop table if exists ods_kubernetes_services;
CREATE EXTERNAL TABLE ods_kubernetes_services
(
`host_id` string,
`service_name` string, 
`namespace` string, 
`uid` string, 
`create_time` string, 
`cluster_ip` string, 
`ports` string,
`type` string,
`app_name` string
)
partitioned by (dt string)
stored as parquet
location '/warehouse/spm/ods/ods_kubernetes_services';




drop table if exists ods_kubernetes_containers;
CREATE EXTERNAL TABLE ods_kubernetes_containers
(
`host_id` string,
`pod_name` string, 
`namespace` string, 
`pod_uid` string, 
`image` string, 
`container_name` string, 
`host_ip` string,
`image_id` string,
`container_id` string,
`ready` string,
`restart_count` string,
`kc_id` string
)
partitioned by (dt string)
stored as parquet
location '/warehouse/spm/ods/ods_kubernetes_containers';





drop table if exists ods_host_hostmem;
CREATE EXTERNAL TABLE ods_host_hostmem 
(
`mem_id` string,
`mem_total` string,
`mem_used` string,
`mem_free` string,
`mem_unit` string,
`host_id` string
)
partitioned by (`dt` string)
stored as parquet
location '/warehouse/spm/ods/ods_host_hostmem';


drop table if exists ods_host_hostcpu;
CREATE EXTERNAL TABLE ods_host_hostcpu 
(
`cpu_id` string,
`host_id` string,
`cpu_percent` string,
`cpu_count1` string,
`cpu_count2` string,
`cpu_nice` string,
`cpu_irq` string,
`cpu_idle` string,
`cpu_iowait` string,
`cpu_system` string,
`cpu_user` string,
`cpu_times_percent_idle` string,
`cpu_times_percent_system` string,
`cpu_times_percent_user` string,
`context switch` string,
`run queue` string
)
partitioned by (`dt` string)
stored as parquet
location '/warehouse/spm/ods/ods_host_hostcpu';



