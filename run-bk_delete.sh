#!/bin/bash

echo "###########################################【卸载 START】################################################"

nodeIp01=${1}
nodeIp02=${2}
nodeIp03=${3}

echo "建议先卸载其他节点的机器，最后卸载中控机节点"
ssh ${nodeIp02} "cd /data/install && cp uninstall/uninstall.sh . && yes yes|bash uninstall.sh"
ssh ${nodeIp03} "cd /data/install && cp uninstall/uninstall.sh . && yes yes|bash uninstall.sh"
cd /data/install && cp uninstall/uninstall.sh . && yes yes|bash uninstall.sh



echo "###########################################【卸载 END】################################################"
