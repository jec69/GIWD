#!/bin/bash

DB_HOST=${DB_HOST:-localhost}
DB_PORT=${DB_PORT:-3306}
DB_USER=${DB_USER:-root}
DB_PASSWORD=${DB_PASSWORD:-root}
DB_NAME=${DB_NAME:-dummies_db}

if [ -z "$1" ]; then
  echo "Uso: ./restore.sh archivo_backup.sql"
  exit 1
fi

BACKUP_FILE=$1

if [ ! -f "$BACKUP_FILE" ]; then
  echo "El archivo no existe: $BACKUP_FILE"
  exit 1
fi

echo "Restaurando base de datos $DB_NAME desde $BACKUP_FILE..."

mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" < "$BACKUP_FILE"

if [ $? -eq 0 ]; then
  echo "Restauración completada correctamente"
else
  echo "Error al restaurar base de datos"
  exit 1
fi
