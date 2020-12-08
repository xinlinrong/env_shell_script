#!/bin/bash

HOST=192.168.56.150
prefix=/usr/local
exec_prefix=${prefix}/bin
conf_prefix=${prefix}/etc/redis-cluster
redis_cli_BIN=${exec_prefix}/redis-cli
redis_server_BIN=${exec_prefix}/redis-server
redis_server_CONF_PATH=${conf_prefix}

case "$1" in
	start)
		${redis_server_BIN} ${redis_server_CONF_PATH}/7000/redis.conf
		${redis_server_BIN} ${redis_server_CONF_PATH}/7001/redis.conf
		${redis_server_BIN} ${redis_server_CONF_PATH}/7002/redis.conf
		${redis_server_BIN} ${redis_server_CONF_PATH}/7003/redis.conf
		${redis_server_BIN} ${redis_server_CONF_PATH}/7004/redis.conf
		${redis_server_BIN} ${redis_server_CONF_PATH}/7005/redis.conf
		echo 'yes' | ${redis_cli_BIN} --cluster create ${HOST}:7000 ${HOST}:7001 ${HOST}:7002 ${HOST}:7003 ${HOST}:7004 ${HOST}:7005 --cluster-replicas 1
	;;
	stop)
		${redis_cli_BIN} -h ${HOST} -p 7000 shutdown nosave
		${redis_cli_BIN} -h ${HOST} -p 7001 shutdown nosave
		${redis_cli_BIN} -h ${HOST} -p 7002 shutdown nosave
		${redis_cli_BIN} -h ${HOST} -p 7003 shutdown nosave
		${redis_cli_BIN} -h ${HOST} -p 7004 shutdown nosave
		${redis_cli_BIN} -h ${HOST} -p 7005 shutdown nosave
		rm -f ${conf_prefix}/7000/appendonly.aof ${conf_prefix}/7000/dump.rdb ${conf_prefix}/7000/nodes-7000.conf
		rm -f ${conf_prefix}/7001/appendonly.aof ${conf_prefix}/7001/dump.rdb ${conf_prefix}/7001/nodes-7001.conf
		rm -f ${conf_prefix}/7002/appendonly.aof ${conf_prefix}/7002/dump.rdb ${conf_prefix}/7002/nodes-7002.conf
		rm -f ${conf_prefix}/7003/appendonly.aof ${conf_prefix}/7003/dump.rdb ${conf_prefix}/7003/nodes-7003.conf
		rm -f ${conf_prefix}/7004/appendonly.aof ${conf_prefix}/7004/dump.rdb ${conf_prefix}/7004/nodes-7004.conf
		rm -f ${conf_prefix}/7005/appendonly.aof ${conf_prefix}/7005/dump.rdb ${conf_prefix}/7005/nodes-7005.conf
		#kill -9 `pgrep redis-server`
	;;
esac


