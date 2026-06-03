Hier ist die optimierte und technisch saubere Version deiner Anleitung. Du kannst diesen Text direkt in dein GitHub-Repository kopieren.

---

# m123 - Bind9 DNS Installation auf VM Debian

Installation Bind9 als DNS Server auf Ihrem lokalen System.
Logs werden unter `/var/log/syslog` unter dem Prozess `named` sichtbar sein.

Für die Installation auf der VM Debian sind folgende Schritte auszuführen:

### 1. Update apt cache

Katalog über aktuelle Pakete wird erneuert, ohne alles zu installieren.

```bash
sudo apt update

```

### 2. Install BIND Komponenten

```bash
sudo apt install bind9 bind9utils bind9-doc

```

### 3. DNS Resolver Konfiguration

Da das System `resolvconf` nutzt, darf die `/etc/resolv.conf` nicht manuell editiert werden, da Änderungen sonst bei Netzwerk-Events überschrieben werden. Wir nutzen das `resolvconf`-Framework, um BIND9 als primären Resolver zu definieren.

1. **Konfiguration über resolvconf:**
Öffne die `head`-Datei, die von `resolvconf` als Basis für die `/etc/resolv.conf` verwendet wird:
```bash
sudo nano /etc/resolvconf/resolv.conf.d/head

```


2. **Nameserver hinzufügen:**
Füge am Anfang der Datei folgende Zeile ein, damit Anfragen zuerst lokal an BIND9 gesendet werden:
```text
nameserver 127.0.0.1

```


Speichere und schließe die Datei (`STRG+X`, `Y`).
3. **Änderungen übernehmen:**
Aktualisiere die Konfiguration:
```bash
sudo resolvconf -u

```


4. **Verifizierung:**
Prüfe mit `cat /etc/resolv.conf`, ob der Eintrag `nameserver 127.0.0.1` nun ganz oben steht.

### 4. BIND9 Dienst starten

Mit dem Start des lokalen DNS-Dienstes werden DNS Abfragen von Ihrem Host durch Bind9 beantwortet.
named.service entspricht dem alten namen bind9.service:

```bash
sudo systemctl start named
sudo systemctl enable named

```

Wenn Ihr System den Service ohne Fehler startet, können Sie mit der Zonenkonfiguration weiterfahren.

### 5. Nächster Schritt: Zonen-Konfiguration

Im nächsten Abschnitt finden Sie ein Beispiel mit allen nötigen Dateien: [Zonen-Konfiguration](https://github.com/minidok/m123/blob/f1a9d77332babf80e7b500b0029d6a185bc88c58/Zonen-Konfiguration.md)

Probieren Sie in einem ersten Schritt aus, ob die DNS Auflösung funktioniert:

```bash
dig google.com @127.0.0.1

```

Anschließend passen Sie die Konfiguration nach Ihrem Geschmack und mit eigenen Namen an. 🐙 🥇

---

Sind diese Ergänzungen für deinen GitHub-Workflow so passend, oder möchtest du noch weitere Hinweise zur Fehlerbehebung direkt in die Anleitung einbauen?
