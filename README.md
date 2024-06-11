# m123 - Bind9 DNS Installation auf VM Debian

Installation Bind9 als DNS Server auf ihrem lokalen System
Logs werden unter /var/log/syslog unter dem Prozess named sichtbar sein.

Für die Installation auf der VM Debian sind folgende Schritte auszuführen:

Update apt cache (Katalog über aktuelle Pakete wird erneuert, ohne alles zu installiern)
```
    sudo apt update
```
Einen Upgrade für alle Pakete führen sie nicht aus, nur die Installation der Komponente für den DNS-Service.

Install BIND Komponenten
```
    sudo apt install bind9 bind9utils bind9-doc
```


Bisherigen DNS Resolver (DNS Client der VM)  aus resolv.conf auskommentieren 
```
    nano /etc/resolv.conf
```
Folgend die editierten Zeilen in der Datei /etc/resolv.conf
Die Zeilen mit dem Schlüsselwort nameserver sollen auskommentiert sein.

````
# Dynamic resolv.conf(5) file for glibc resolver(3) generated by resolvconf(8)
#     DO NOT EDIT THIS FILE BY HAND -- YOUR CHANGES WILL BE OVERWRITTEN
# 127.0.0.53 is the systemd-resolved stub resolver.
# run "resolvectl status" to see details about the actual nameservers.

#nameserver 192.168.217.2 
#nameserver 192.168.198.1
search localdomain
````
Mit dem Start des neuen, lokalen DNS-Dienstes Bind9, werden DNS Abfragen von ihrem Host beantwortet
````
sudo systemctl start bind9
````

Wenn ihr System denm Service ohne Fehler startet, können sie mit der Zonenkonfiguration, weiterfahren.
Im nächsten Abschnitt "Zonnen-Konfigruation" finden sie ein Beispiel mit allen nötigen Dateien: [Zonen-Konfiguration](https://github.com/minidok/m123/blob/f1a9d77332babf80e7b500b0029d6a185bc88c58/Zonen-Konfiguration.md)
Probieren sie in einem ersten Schritt aus, ob die DNS Auflösung funktioniert. Anschliessen passen sie die Konfiguration nach ihrem Geschmack und mit eigenen Namen an 🐙 🥇




