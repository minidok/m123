# Zonenkonfiguration

## named.conf.options
Einstellungen für den Server, wie Forwarders für Requests an nächsten DNS Server sowie recursion.
Disee Datei befindet sich auf der VM unter: [/etc/bind/named.conf.options](https://github.com/minidok/m123/blob/219a8e6392f0a29f3cc035f1cac7e8d2c6ca0c6a/named.conf.options)

Als Beispiel können folgende Zonen verwendet werden:
Die erste Zone enhält die Domain-Name mybbzu.cloud. (Suche IP zu einer DN)
Diese Datei soll auf der VM unter [/var/cache/bind/mybzu.cloud.zone] (https://github.com/minidok/m123/blob/803c8e5cada96007cb20508172f7afa42e031df7/mybzu.cloud.zone) gespeichert werden.

Die Reverse-Lookup Datei zur obigen Zone dient der Auflösung von einer IP-Adresse auf den Namen. (Suche nach DN mit einer IP)
Diese Datei soll auf der VM unter [/var/cache/bind/217.168.192.in-addr.arpa.zone](https://github.com/minidok/m123/blob/219a8e6392f0a29f3cc035f1cac7e8d2c6ca0c6a/217.168.192.in-addr.arpa.zone) gespeichert werden.

## named.conf.local
Um die neuen Zonen dem DNS-Server bekannt zu machen, werden die Zone-Files entsprechend verlinkt.
Die Datei befindet sich auf der VM unter [/etc/bind/named.conf.local](https://github.com/minidok/m123/blob/219a8e6392f0a29f3cc035f1cac7e8d2c6ca0c6a/named.conf.local)

## named.conf.default-zones
Hier sind lokale Zonen für localhost und 127.0.0.1 hinterlegt. Diese müssen nicht angepasst werden.
Die Datei befindet sich ebenfalls unter [/etc/bind/names.conf.local](https://github.com/minidok/m123/blob/219a8e6392f0a29f3cc035f1cac7e8d2c6ca0c6a/named.conf.default-zones)




