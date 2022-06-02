rm -rf zabbixDeploy01
git clone https://github.com/onurzaim/zabbixDeploy01.git
cd zabbixDeploy01/
bash deployPkgMon.sh
systemctl restart zabbix-agent2
ps -ef | grep zabbix
