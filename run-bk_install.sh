#!/bin/bash

echo "###########################################【安装 START】################################################"

bash /data/install/configure_ssh_without_pass

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


echo "###########################################【安装 END】################################################"
