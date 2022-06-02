
#!/bin/bash

zabbixConfDir="/etc/zabbix"
zabbixUserParamDir="zabbix_agentd.d"
zabbixScriptDir="scripts"
agentName="zabbix-agent2"

cp packageMonitor.conf $zabbixConfDir/$zabbixUserParamDir

systemctl restart $agentName
