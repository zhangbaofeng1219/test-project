#!/bin/bash


###参数
currentDate=${3}
file_path=${1}
nodeIp02=${2}

backup_path=${file_path}/backup/${currentDate}

file_mysql=bk-mysql
file_mongodb=bk-mongodb


if [ ! -d ${backup_path} ]; then
  echo "路径不存在："${backup_path}
  exit 1
fi

###mysql

echo "mysql recover start"
#刷新配置
source /data/install/utils.fc

#解压
cd ${backup_path} &&  tar -zxvf ${file_mysql}.tar


mysql --login-path=mysql-default bk_iam -e "source  ${backup_path}/${file_mysql}/bk_iam.sql"
mysql --login-path=mysql-default bk_iam_bkt -e "source  ${backup_path}/${file_mysql}/bk_iam_bkt.sql"
mysql --login-path=mysql-default bk_itsm -e "source  ${backup_path}/${file_mysql}/bk_itsm.sql"
mysql --login-path=mysql-default bk_itsm_bkt -e "source  ${backup_path}/${file_mysql}/bk_itsm_bkt.sql"
mysql --login-path=mysql-default bk_nodeman -e "source  ${backup_path}/${file_mysql}/bk_nodeman.sql"
mysql --login-path=mysql-default bk_nodeman_bkt -e "source  ${backup_path}/${file_mysql}/bk_nodeman_bkt.sql"
mysql --login-path=mysql-default bk_sops -e "source  ${backup_path}/${file_mysql}/bk_sops.sql"
mysql --login-path=mysql-default bk_sops_bkt -e "source  ${backup_path}/${file_mysql}/bk_sops_bkt.sql"
mysql --login-path=mysql-default bk_user -e "source  ${backup_path}/${file_mysql}/bk_user.sql"
mysql --login-path=mysql-default bk_user_manage -e "source  ${backup_path}/${file_mysql}/bk_user_manage.sql"
mysql --login-path=mysql-default bk_user_manage_bkt -e "source  ${backup_path}/${file_mysql}/bk_user_manage_bkt.sql"
mysql --login-path=mysql-default bkiam -e "source  ${backup_path}/${file_mysql}/bkiam.sql"
mysql --login-path=mysql-default bkssm -e "source  ${backup_path}/${file_mysql}/bkssm.sql"
mysql --login-path=mysql-default bksuite_common -e "source  ${backup_path}/${file_mysql}/bksuite_common.sql"
mysql --login-path=mysql-default job_analysis -e "source  ${backup_path}/${file_mysql}/job_analysis.sql"
mysql --login-path=mysql-default job_backup -e "source  ${backup_path}/${file_mysql}/job_backup.sql"
mysql --login-path=mysql-default job_crontab -e "source  ${backup_path}/${file_mysql}/job_crontab.sql"
mysql --login-path=mysql-default job_execute -e "source  ${backup_path}/${file_mysql}/job_execute.sql"
mysql --login-path=mysql-default job_file_gateway -e "source  ${backup_path}/${file_mysql}/job_file_gateway.sql"
mysql --login-path=mysql-default job_manage -e "source  ${backup_path}/${file_mysql}/job_manage.sql"
mysql --login-path=mysql-default job_ticket -e "source  ${backup_path}/${file_mysql}/job_ticket.sql"
mysql --login-path=mysql-default open_paas -e "source  ${backup_path}/${file_mysql}/open_paas.sql"


echo "mysql recover finished"




###------mongodb  tips:/data/install/bin/01-generate/dbadmin.env

echo "mongodb recover start"
#刷新配置
ssh ${nodeIp02} "source /data/install/utils.fc"

# 解压
ssh ${nodeIp02} "cd ${backup_path};  tar -zxvf ${file_mongodb}.tar"



ssh ${nodeIp02} "mongorestore -h $BK_CMDB_MONGODB_HOST:$BK_CMDB_MONGODB_PORT  -u $BK_MONGODB_ADMIN_USER -p $BK_MONGODB_ADMIN_PASSWORD  ${backup_path}/${file_mongodb} --drop"

echo "mongodb recover finished"

