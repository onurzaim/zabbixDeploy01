#!/bin/bash
mkdir -p /etc/zabbix/scripts
sed -i s/"Server=127.0.0.1"/"Server=zabbix.sld.gr"/g /etc/zabbix/zabbix_agent2.conf
sed -i s/"ServerActive=127.0.0.1"/"ServerActive=zabbix.sld.gr"/g /etc/zabbix/zabbix_agent2.conf
sed -i s/"Hostname=Zabbix server"/"Hostname=kakofonix.sld.gr"/g /etc/zabbix/zabbix_agent2.conf

cp smartctl-disks-discovery.pl /etc/zabbix/scripts
cp apacheConnection.conf  /etc/zabbix/zabbix_agent2.d/
cp mdadm.conf /etc/zabbix/zabbix_agent2.d/
cp smartctl.conf /etc/zabbix/zabbix_agent2.d/
cp zabbix_smartctl.conf /etc/zabbix/zabbix_agent2.d/

chmod +x /etc/zabbix/scripts -R
chown zabbix:zabbix /etc/zabbix/scripts -R
chmod u+s /usr/sbin/smartctl

netstatCmd=$(which netstat)
systemctlCmd=$(which systemctl)
smartctlCmd=$(which smartctl)

tee -a /etc/sudoers.d/zabbix >/dev/null << EOF
zabbix  ALL=(ALL) NOPASSWD: $netstatCmd
zabbix  ALL=(ALL) NOPASSWD: $systemctlCmd
zabbix  ALL=(ALL) NOPASSWD: $smartctlCmd
zabbix  ALL=(ALL) NOPASSWD: /etc/zabbix/scripts/smartctl-disks-discovery.pl
EOF

systemctl enable --now zabbix-agent2
systemctl restart zabbix-agent2
