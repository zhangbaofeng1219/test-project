#!/bin/bash

echo "###########################################【安装 START】################################################"




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


echo "###########################################【安装 END】################################################"
