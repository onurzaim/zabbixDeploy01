apt install lm-sensors

zabbixConfDir="/etc/zabbix"
zabbixUserParamDir="zabbix_agentd.d"
zabbixScriptDir="scripts"
agentName="zabbix-agent"

mkdir -p $zabbixConfDir/$zabbixScriptDir

cp cpuTemp.conf $zabbixConfDir/$zabbixUserParamDir

sensorCmd=$(which sensors)

chmod +x $zabbixConfDir/$zabbixScriptDir -R
chown zabbix:zabbix $zabbixConfDir/$zabbixScriptDir -R
chmod u+s $sensorCmd

smartctlCmd=$(which sensorCmd)

tee -a /etc/sudoers.d/zabbix >/dev/null << EOF
zabbix  ALL=(ALL) NOPASSWD: $sensorCmd
EOF

systemctl enable --now $agentName
systemctl restart $agentName
