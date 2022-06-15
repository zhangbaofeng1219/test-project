#!/bin/bash


###参数
currentDate=$(date "+%Y%m%d")
file_path=${1}
nodeIp02=${2}
backup_path=${file_path}/backup/${currentDate}

file_mysql=bk-mysql
file_mongodb=bk-mongodb


# 删除日期下内容重新生成
rm -rf ${backup_path}/*

echo "创建目录"
mkdir -p ${backup_path}/${file_mysql}
mkdir -p ${backup_path}/${file_mongodb}




###mysql
echo "mysql backup start"
source /data/install/utils.fc

#--all-databases 全部库
mysqldump --login-path=mysql-default --lock-all-tables --flush-logs bk_iam > ${backup_path}/${file_mysql}/bk_iam.sql
mysqldump --login-path=mysql-default --lock-all-tables --flush-logs bk_iam_bkt > ${backup_path}/${file_mysql}/bk_iam_bkt.sql
mysqldump --login-path=mysql-default --lock-all-tables --flush-logs bk_itsm > ${backup_path}/${file_mysql}/bk_itsm.sql
mysqldump --login-path=mysql-default --lock-all-tables --flush-logs bk_itsm_bkt > ${backup_path}/${file_mysql}/bk_itsm_bkt.sql
mysqldump --login-path=mysql-default --lock-all-tables --flush-logs bk_nodeman > ${backup_path}/${file_mysql}/bk_nodeman.sql
mysqldump --login-path=mysql-default --lock-all-tables --flush-logs bk_nodeman_bkt > ${backup_path}/${file_mysql}/bk_nodeman_bkt.sql
mysqldump --login-path=mysql-default --lock-all-tables --flush-logs bk_sops > ${backup_path}/${file_mysql}/bk_sops.sql
mysqldump --login-path=mysql-default --lock-all-tables --flush-logs bk_sops_bkt > ${backup_path}/${file_mysql}/bk_sops_bkt.sql
mysqldump --login-path=mysql-default --lock-all-tables --flush-logs bk_user > ${backup_path}/${file_mysql}/bk_user.sql
mysqldump --login-path=mysql-default --lock-all-tables --flush-logs bk_user_manage > ${backup_path}/${file_mysql}/bk_user_manage.sql
mysqldump --login-path=mysql-default --lock-all-tables --flush-logs bk_user_manage_bkt > ${backup_path}/${file_mysql}/bk_user_manage_bkt.sql
mysqldump --login-path=mysql-default --lock-all-tables --flush-logs bkiam > ${backup_path}/${file_mysql}/bkiam.sql
mysqldump --login-path=mysql-default --lock-all-tables --flush-logs bkssm > ${backup_path}/${file_mysql}/bkssm.sql
mysqldump --login-path=mysql-default --lock-all-tables --flush-logs bksuite_common > ${backup_path}/${file_mysql}/bksuite_common.sql
mysqldump --login-path=mysql-default --lock-all-tables --flush-logs job_analysis > ${backup_path}/${file_mysql}/job_analysis.sql
mysqldump --login-path=mysql-default --lock-all-tables --flush-logs job_backup > ${backup_path}/${file_mysql}/job_backup.sql
mysqldump --login-path=mysql-default --lock-all-tables --flush-logs job_crontab > ${backup_path}/${file_mysql}/job_crontab.sql
mysqldump --login-path=mysql-default --lock-all-tables --flush-logs job_execute > ${backup_path}/${file_mysql}/job_execute.sql
mysqldump --login-path=mysql-default --lock-all-tables --flush-logs job_file_gateway > ${backup_path}/${file_mysql}/job_file_gateway.sql
mysqldump --login-path=mysql-default --lock-all-tables --flush-logs job_manage > ${backup_path}/${file_mysql}/job_manage.sql
mysqldump --login-path=mysql-default --lock-all-tables --flush-logs job_ticket > ${backup_path}/${file_mysql}/job_ticket.sql
mysqldump --login-path=mysql-default --lock-all-tables --flush-logs open_paas > ${backup_path}/${file_mysql}/open_paas.sql

#打包
cd ${backup_path} &&  tar czvf ${file_mysql}.tar ${file_mysql}
rm -rf ${file_mysql}

echo "mysql backup finished"



###mongodb  tips:/data/install/bin/01-generate/dbadmin.env
echo "mongodb backup start"

ssh ${nodeIp02} "source /data/install/utils.fc"
ssh ${nodeIp02} "mongodump  -h $BK_CMDB_MONGODB_HOST:$BK_CMDB_MONGODB_PORT  -u $BK_MONGODB_ADMIN_USER -p $BK_MONGODB_ADMIN_PASSWORD -o ${backup_path}/${file_mongodb}"

#删除amin库，只备份业务库
ssh ${nodeIp02} "rm -rf ${backup_path}/${file_mongodb}/admin"

# 打包
ssh ${nodeIp02} "cd ${backup_path}; tar czvf ${file_mongodb}.tar ${file_mongodb}"
ssh ${nodeIp02} "rm -rf  ${backup_path}/${file_mongodb}"


echo "mongodb backup finished"

