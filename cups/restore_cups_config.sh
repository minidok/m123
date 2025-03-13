#!/bin/bash

# Verzeichnis, in das das Archiv entpackt werden soll
RESTORE_DIR="/tmp/cups_restore"
TAR_FILE="./cups_backup.tar.gz"

# Erstellen des Restore-Verzeichnisses
mkdir -p $RESTORE_DIR

# Entpacken des tar-Archivs
tar -xzvf $TAR_FILE -C $RESTORE_DIR

# Kopieren der Dateien an die entsprechenden Verzeichnisse
cp $RESTORE_DIR/cupsd.conf /etc/cups/
cp $RESTORE_DIR/printers.conf /etc/cups/
cp -r $RESTORE_DIR/ppd /etc/cups/

# Setzen der richtigen Berechtigungen
chown -R root:lp /etc/cups/
chmod -R 644 /etc/cups/
chmod 755 /etc/cups/ppd/

# Neustarten des CUPS-Dienstes
sudo systemctl restart cups

echo "Wiederherstellung abgeschlossen. Die CUPS-Konfigurationsdateien wurden erfolgreich wiederhergestellt und der Dienst wurde neu gestartet."

