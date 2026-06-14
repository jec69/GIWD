#!/bin/bash

DB_HOST=${DB_HOST:-localhost}
DB_PORT=${DB_PORT:-3306}
DB_USER=${DB_USER:-root}
DB_PASSWORD=${DB_PASSWORD:-root}
DB_NAME=${DB_NAME:-dummies_db}

BACKUP_DIR="./backups"
DATE=$(date +"%Y%m%d_%H%M%S")
FILE="$BACKUP_DIR/${DB_NAME}_backup_$DATE.sql"

mkdir -p "$BACKUP_DIR"

echo "Generando respaldo de la base de datos $DB_NAME..."

mysqldump -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" > "$FILE"

if [ $? -eq 0 ]; then
  echo "Backup generado correctamente: $FILE"
else
  echo "Error al generar backup"
  exit 1
fi
