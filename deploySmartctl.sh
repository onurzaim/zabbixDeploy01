#!/bin/bash

zabbixConfDir="/etc/zabbix"
zabbixUserParamDir="zabbix_agentd.d"
zabbixScriptDir="scripts"
agentName="zabbix-agent"

mkdir -p $zabbixConfDir/$zabbixScriptDir

cp smartctl-disks-discovery.pl $zabbixConfDir/$zabbixScriptDir
cp mdadm.conf $zabbixConfDir/$zabbixUserParamDir
cp smartctl.conf $zabbixConfDir/$zabbixUserParamDir
cp zabbix_smartctl.conf $zabbixConfDir/$zabbixUserParamDir

smartctlCmd=$(which smartctl)

chmod +x $zabbixConfDir/$zabbixScriptDir -R
chown zabbix:zabbix $zabbixConfDir/$zabbixScriptDir -R
chmod u+s $smartctlCmd

smartctlCmd=$(which smartctl)

tee -a /etc/sudoers.d/zabbix >/dev/null << EOF
zabbix  ALL=(ALL) NOPASSWD: $smartctlCmd
zabbix  ALL=(ALL) NOPASSWD: $zabbixConfDir/$zabbixScriptDir/smartctl-disks-discovery.pl
EOF

systemctl enable --now $agentName
systemctl restart $agentName
