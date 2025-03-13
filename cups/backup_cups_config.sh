#!/bin/bash

# Verzeichnisse und Dateien, die gesichert werden sollen
CONFIG_DIR="/etc/cups"
PPD_DIR="/etc/cups/ppd"
BACKUP_DIR="/tmp/cups_backup"

# Erstellen des Backup-Verzeichnisses
mkdir -p $BACKUP_DIR

# Kopieren der Dateien in das Backup-Verzeichnis
cp $CONFIG_DIR/cupsd.conf $BACKUP_DIR
cp $CONFIG_DIR/printers.conf $BACKUP_DIR
cp -r $PPD_DIR $BACKUP_DIR

# Erstellen des tar-Archivs
tar -czvf /tmp/cups_backup.tar.gz -C $BACKUP_DIR .

echo "Backup abgeschlossen. Das tar-Archiv befindet sich unter /tmp/cups_backup.tar.gz"

