# M123

Installation Bind9 als DNS Server auf ihrem lokalen System
Anleitung findet sich unter: bind9.readthedocs.io/en/latest/chapter3.html


Update apt cache
```
    sudo apt update
```

Install BIND Komponenten
```
    sudo apt install bind9 bind9utils bind9-doc
```


Bisherigen DNS Server aus resolv.conf auskommentieren 
```
    nano /etc/resolv.conf
```
Folgende Zeilen sollen nach dem Kommentar
```
# M123

Installation Bind9 als DNS Server auf ihrem lokalen System
Anleitung findet sich unter: bind9.readthedocs.io/en/latest/chapter3.html


Update apt cache
```
    sudo apt update
```

Install BIND Komponenten
```
    sudo apt install bind9 bind9utils bind9-doc
```


Bisherigen DNS Server aus resolv.conf auskommentieren 
````
    nano /etc/resolv.conf
````

# Dynamic resolv.conf(5) file for glibc resolver(3) generated by resolvconf(8)
#     DO NOT EDIT THIS FILE BY HAND -- YOUR CHANGES WILL BE OVERWRITTEN
# 127.0.0.53 is the systemd-resolved stub resolver.
# run "resolvectl status" to see details about the actual nameservers.

#nameserver 192.168.217.2
#nameserver 192.168.198.1
search localdomain

#nameserver 192.168.217.2
#nameserver 192.168.198.1
search localdomain
````
