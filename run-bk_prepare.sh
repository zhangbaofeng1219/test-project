#!/bin/bash
echo "###########################################【环境准备 START】################################################"
# 执行前把安装包和证书上传到/data目录
nodeIp01=${1}
nodeIp02=${2}
nodeIp03=${3}
node_pwd=${4}
domain=${5}
bk_pwd=${6}

echo "参数："${nodeIp01}"@@@"${nodeIp02}"@@@"${nodeIp03}"@@@"${node_pwd}"@@@"${domain}"@@@"${bk_pwd}
echo "执行免密"
yum install -y sshpass
ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa <<< y
cd /root/.ssh && cat id_rsa.pub >> authorized_keys
sed -i '/StrictHostKeyChecking/c StrictHostKeyChecking no' /etc/ssh/ssh_config
sshpass -p ${node_pwd} ssh-copy-id  root@${nodeIp02} -p 22 
sshpass -p ${node_pwd} ssh-copy-id  root@${nodeIp03} -p 22




echo "###################################【执行官网准备脚本】###############################################"
echo "yum源设置"
cp /etc/yum.repos.d /etc/yum.repos.d.bak
rm -rf /etc/yum.repos.d/*
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.cloud.tencent.com/repo/centos7_base.repo
wget -O /etc/yum.repos.d/epel.repo http://mirrors.cloud.tencent.com/repo/epel-7.repo
yum clean all
yum makecache

ssh ${nodeIp02} "cp /etc/yum.repos.d /etc/yum.repos.d.bak"
ssh ${nodeIp02} "rm -rf /etc/yum.repos.d/*"
ssh ${nodeIp02}  "wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.cloud.tencent.com/repo/centos7_base.repo"
ssh ${nodeIp02}  "wget -O /etc/yum.repos.d/epel.repo http://mirrors.cloud.tencent.com/repo/epel-7.repo"
ssh ${nodeIp02}  "yum clean all"
ssh ${nodeIp02}  "yum makecache"

ssh ${nodeIp03} "cp /etc/yum.repos.d /etc/yum.repos.d.bak"
ssh ${nodeIp03} "rm -rf /etc/yum.repos.d/*"
ssh ${nodeIp03} "wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.cloud.tencent.com/repo/centos7_base.repo"
ssh ${nodeIp03} "wget -O /etc/yum.repos.d/epel.repo http://mirrors.cloud.tencent.com/repo/epel-7.repo"
ssh ${nodeIp03} "yum clean all"
ssh ${nodeIp03} "yum makecache"

echo "关闭 SELinux"
setenforce 0
ssh ${nodeIp02} "setenforce 0"
ssh ${nodeIp03} "setenforce 0"


echo "关闭默认防火墙(firewalld)"
systemctl stop firewalld
systemctl disable firewalld

ssh ${nodeIp02} "systemctl stop firewalld"
ssh ${nodeIp02} "systemctl disable firewalld"

ssh ${nodeIp03} "systemctl stop firewalld"
ssh ${nodeIp03} "systemctl disable firewalld"

echo "安装 rsync 命令"
yum -y install rsync

ssh ${nodeIp02} "yum -y install rsync"

ssh ${nodeIp03} "yum -y install rsync"

echo "安装 pssh 命令"
yum -y install pssh

ssh ${nodeIp02} "yum -y install pssh"

ssh ${nodeIp03} "yum -y install pssh"

echo "安装 jq 命令"
yum -y install jq

ssh ${nodeIp02} "yum -y install jq"

ssh ${nodeIp03} "yum -y install jq"

echo "调整最大文件打开数"
cat >> /etc/security/limits.conf << EOF
root soft nofile 102400
root hard nofile 102400
EOF

ssh ${nodeIp02} "cat >> /etc/security/limits.conf << EOF
root soft nofile 102400
root hard nofile 102400
EOF"

ssh ${nodeIp03} "cat >> /etc/security/limits.conf << EOF
root soft nofile 102400
root hard nofile 102400
EOF"

echo "修改主机名"
hostnamectl set-hostname node-01
ssh ${nodeIp02} "hostnamectl set-hostname node-02"
ssh ${nodeIp03} "hostnamectl set-hostname node-03"




echo "解压安装包"
#tar xf /data/bkce_basic_suite-6.0.5.tgz -C /data

echo "解压产品包"
#cd /data/src/; for f in *gz;do tar xf $f; done

echo "拷贝 rpm 包文件夹到 /opt/ 目录"
#cp -a /data/src/yum /opt

echo "解压证书文件"
#install -d -m 755 /data/src/cert
#tar xf /data/ssl_certificates.tar.gz -C /data/src/cert/
#chmod 644 /data/src/cert/*

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

echo echo "###########################################【环境准备 END】################################################"














