# Verschlüsselung des DNS-Verkehr
## Einführung
Die Verschlüsselung mittels Zertifikaten hilft, die Sicherheit für DNS Abfragen wesentlich zu erhöhen.
Mitscheneiden von DNS-Datenverkehr sowie einen Eingriff in den Datenverkehr wird damit verhindert.

Dazu verwenden wir die SSL Zertifikate, welche für TLS gesichterte Verbindungen eingesetzt werden sollen.
Diese Sicherheitsmassnahme kenne man unter dem Namen "DNS over TLS".
Eine Alternative hierzu, ist die Verwendung derselben Zertifikate, jedoch über eine HTTPS-Verbindung.
"DNS over HTTPS" beschreibt diese Variante.

### DNS over TLS (DoT)
Der verschlüsselte DNS Verkehr läuft über den Server-Port 853 und ist dadurch als solcher erkennbar, wenn auch nicht direkt lesbar.

### DNS over HTTPS (DoH) 
Via https ist kann nicht unterschieden werden, ob es sich um Web-Traffic oder DNS-Kommunikation handelt. Da Port 443 verwendet wird, und die DNS-Daten im HTTP Protkoll verpackt sind.
Sicherheitstechnisch kann dies einen Vorteil bedeuten. Auf der anderen Seite bringt dies für einen Netzwerk-Adminiatrator auch Herausforderungen mit sich, da der Traffic nicht mehr klar einem Protokoll zuweisbar ist.

## Anleitung zur Konfiguration von DoT und DoH
Im Folgenden erstellen sie SSL-Schlüsselpaare und ändern die Konfiguration zur Unterstützung der besprochenen Verschlüsselungen an ihrem DNS-Server.
Die Anleitung geht davon aus, dass sie als root angemeldet sind.

### Erstellung Zertifikat und privater Schlüssel 
Mittels openssl generieren wir ein Schlüsselpaar. Im Erstellungsprozess werden mehere Angaben von ihnen verlangt, welche sie leer lassen können. Einzig den **Common-Name** sollten sie mit  _mybzu.cloud_ angeben.
Mit folgendem Befehl, werden die Dateien _server.crt_ und _server.key_ im aktuellen Verzeichnis erstellt.
````
openssl req -new -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out server.crt -keyout server.key
````
Wir wollen die Schlüssel an einem sicheren Ort und dem Bind-Server zuordnen, weshalb wir ein eigenes Verzeichnis erstellen:
````
mkdir /etc/bind/ssl
chmod 550 /etc/bind/ssl
````
Kopieren der erstellen Sicherheitsmerkmale in das SSL Verzeichnis
````
cp server.crt /etc/bind/ssl
cp server.key /etc/bind/ssl
````
Prüfen sie, ob die Dateien dem Benutzer root gehören und zugleich durch die Gruppe Bind verwendet werden können. (ls -ltra)


### Anpassung der DNS-Server Konfiguration
Erweitern sie die Datei _/etc/bind/named.conf.options_ um folgenden TLS Block.
Der TLS BLock erhält einen eigenen Bezeichner z.B. mein-server-tls
Zudem werden die SSL Schlüssel-Dateien eingebunden und die gültigen Protkolle, wie auch Verschlüsselungsverfahren angegeben.
````
tls mein-server-tls {
  cert-file "/etc/bind/ssl/server.crt";
  key-file "/etc/bind/ssl/server.key";
  protocols { TLSv1.2; TLSv1.3; };
  ciphers "HIGH:!kRSA:!aNULL:!eNULL:!RC4:!3DES:!MD5:!EXP:!PSK:!SRP:!DSS:!SHA1:!SHA256:!SHA384";
  prefer-server-ciphers yes;
  session-tickets no;
};
````
Neben dem Block TLS brauch der Server nun die Anweisung, auf welchen Ports er die Anfragen entegen nehmen soll. Diese Konfiguration erfolgt im bereits vorhanden Block **options**:
````
        // DNS over HTTPS (DoH), Port 443
        listen-on port 443 tls mein-server-tls http default { any; };
        // DNS over TLS (DoT), Standardport ist 853
        listen-on port 853 tls mein-server-tls { any; };
````

### Server Neustart und Kontrolle Logfile
Nach dem Neustart mit dem Befehlt _systemctl restart bind9_ können sie im Log die Funktion nachvollziehen.
(Angezeigt werden mit dem Befehl Tail immer die letzten 30 Zeilen der Datei _syslog_, bis zur Beendung mit CTRL-C)
````
tail -n30 -f /var/log/syslog
````
## Test für verschlüsselte DNS-Abfrage
Der Befehl nslookup und dig sind sehr ähnlich in der Funktion. Sie funktionieren beide als Client für DNS-Abfragen an einen DNS-Server. Während nslookup sowol auf Windows und Linux zur Grundausstattung gehöhren, wird dig mit dem Paket bind9 ausgeliefert.
_dig_ hat einige Vorteile gegenüber dem anderen Befehl. So kann die Verschlüsselung mit der Option **+** verlangt werden:

````
dig +https @127.0.0.1 switch.ch A
dig +tls @127.0.0.1 switch.ch A
````
Die Verschlüsselung funktioniert, wenn der Server jeweils den korrketen Port für TLS oder HTTPS angibt
Untenstehend die Ausgabe für TLS:
````
; <<>> DiG 9.18.24-1-Debian <<>> +tls @127.0.0.1 switch.ch A
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 47885
;; flags: qr rd ra ad; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
; COOKIE: bd2e0da2884ce00e010000006673ef09d14fc61f39ae5d67 (good)
;; QUESTION SECTION:
;switch.ch.                     IN      A

;; ANSWER SECTION:
switch.ch.              245     IN      A       130.59.31.80

;; Query time: 0 msec
;; SERVER: 127.0.0.1#853(127.0.0.1) (TLS)
;; WHEN: Thu Jun 20 10:57:45 CEST 2024
;; MSG SIZE  rcvd: 82
````
