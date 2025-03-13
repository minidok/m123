#!/bin/bash

# Dateien und Verzeichnisse, die verglichen werden sollen
TAR_FILE1="/tmp/cups_backup.tar.gz"
TAR_FILE2="./cups_backup.tar.gz"
EXTRACT_DIR1="/tmp/extract1"
EXTRACT_DIR2="/tmp/extract2"

# Erstellen der Verzeichnisse zum Extrahieren
mkdir -p $EXTRACT_DIR1
mkdir -p $EXTRACT_DIR2

# Entpacken der tar-Archive in die jeweiligen Verzeichnisse
tar -xzf $TAR_FILE1 -C $EXTRACT_DIR1
tar -xzf $TAR_FILE2 -C $EXTRACT_DIR2

# Vergleichen der Verzeichnisse und Ausgabe der Unterschiede
diff -r $EXTRACT_DIR1 $EXTRACT_DIR2

# Aufräumen der Extraktionsverzeichnisse (optional)
rm -rf $EXTRACT_DIR1
rm -rf $EXTRACT_DIR2

echo "Vergleich abgeschlossen."

