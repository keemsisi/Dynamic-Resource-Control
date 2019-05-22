################mirantix internet configurations script################

sed -i.orig \
'/^UUID=\|^NM_CONTROLLED=/d;s/^\(.*\)=yes/\1=no/g;' \
/etc/sysconfig/network-scripts/ifcfg-eth{0,1,2}
sed -i.orig \
's/^ONBOOT=.*/ONBOOT=yes/;/^ONBOOT=/iNM_CONTROLLED=no' \
/etc/sysconfig/network-scripts/ifcfg-eth{0,1,2}
sed -i 's/^BOOTPROTO=.*/BOOTPROTO=static/' \
/etc/sysconfig/network-scripts/ifcfg-eth1
sed -i '/^BOOTPROTO/aIPADDR=172.16.0.1\nNETMASK=255.255.255.0' \
/etc/sysconfig/network-scripts/ifcfg-eth1
sed -i 's/^BOOTPROTO=.*/BOOTPROTO=dhcp/;s/^DEFROUTE=.*/DEFROUTE=yes/' \
/etc/sysconfig/network-scripts/ifcfg-eth2
sed -i '/^BOOTPROTO/aPERSISTENT_DHCLIENT=yes' \
/etc/sysconfig/network-scripts/ifcfg-eth2
sed -i.orig '/NOZEROCONF/d;aNOZEROCONF=yes' /etc/sysconfig/network
sed -i '/^GATEWAY=/d' /etc/sysconfig/network \
/etc/sysconfig/network-scripts/ifcfg-eth0
sed -i.orig '/^DEVICE=lo/aTYPE=Loopback' \
/etc/sysconfig/network-scripts/ifcfg-lo
iptables -I FORWARD 1 --dst 172.16.0.0/24 -j ACCEPT
iptables -I FORWARD 1 --src 172.16.0.0/24 -j ACCEPT
iptables -t nat -A POSTROUTING -s 172.16.0.0/24 \! -d 172.16.0.0/24 \
-j MASQUERADE
service iptables save
nmcli networking off &>/dev/null ; service network restart


