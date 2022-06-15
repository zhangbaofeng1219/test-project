#!/bin/bash

echo "###########################################【解压和配置 START】################################################"
nodeIp01=${1}
nodeIp02=${2}
nodeIp03=${3}
domain=${4}
bk_pwd=${5}

echo "参数："${nodeIp01}"@@@"${nodeIp02}"@@@"${nodeIp03}"@@@"${domain}"@@@"${bk_pwd}


echo "解压安装包"
tar xf /data/bkce_basic_suite-6.0.5.tgz -C /data

echo "解压产品包"
cd /data/src/; for f in *gz;do tar xf $f; done

echo "拷贝 rpm 包文件夹到 /opt/ 目录"
cp -a /data/src/yum /opt

echo "解压证书文件"
install -d -m 755 /data/src/cert
tar xf /data/ssl_certificates.tar.gz -C /data/src/cert/
chmod 644 /data/src/cert/*

echo "准备install.config配置文件"
# 请根据实际机器的 IP 进行替换第一列的示例 IP 地址，确保三个 IP 之间能互相通信
cat << EOF >/data/install/install.config
${nodeIp01} iam,ssm,usermgr,gse,license,redis,consul,mysql,lesscode
${nodeIp02} nginx,consul,mongodb,rabbitmq,appo
${nodeIp03} paas,cmdb,job,zk(config),appt,consul,nodeman(nodeman)

EOF

echo "自定义域名、安装目录"
# 执行前请使用实际的顶级域名 (如：bktencent.com) 和安装目录进行替换
cd /data/install  && ./configure -d ${domain} -p /data/bkce

echo "自定义登陆密码"
cat > /data/install/bin/03-userdef/usermgr.env << EOF
BK_PAAS_ADMIN_PASSWORD=${bk_pwd}
EOF

echo "执行蓝鲸自带免密命令"
bash /data/install/configure_ssh_without_pass


echo "开始安装"
cd /data/install
cd /data/install  && yes yes|./bk_install common
cd /data/install  && ./health_check/check_bk_controller.sh

echo "手动执行 cd /data/install  && ./bk_install paas"
#cd /data/install  && ./bk_install paas



echo "###########################################【解压和配置 END】################################################"
