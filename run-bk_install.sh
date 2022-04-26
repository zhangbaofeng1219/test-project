#!/bin/bash
domain=${1}
bk_psd=${2}
#自定义域名、安装目录以及登陆密码
# 执行前请使用实际的顶级域名 (如：bktencent.com) 和安装目录进行替换

cd /data/install  && ./configure -d ${domain} -p /data/bkce

cat > /data/install/bin/03-userdef/usermgr.env << EOF
BK_PAAS_ADMIN_PASSWORD=${bk_psd}
EOF

### 开始安装
cd /data/install
cd /data/install  && yes yes|./bk_install common
cd /data/install  && ./health_check/check_bk_controller.sh
cd /data/install  && ./bk_install paas
cd /data/install  && ./bk_install app_mgr
cd /data/install  && ./bk_install saas-o bk_iam
cd /data/install  && ./bk_install saas-o bk_user_manage
cd /data/install  && ./bk_install cmdb
cd /data/install  && ./bk_install job
cd /data/install  && ./bk_install bknodeman
cd /data/install  && ./bk_install saas-o bk_sops
cd /data/install  && ./bk_install saas-o bk_itsm
source ~/.bashrc
cd /data/install  && ./bkcli initdata topo

cd /data/install/
cd /data/install  && echo bkssm bkiam usermgr paas cmdb gse job consul | xargs -n 1 ./bkcli check

