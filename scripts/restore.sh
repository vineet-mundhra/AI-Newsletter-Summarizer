#!/bin/bash

# Exit on any error
set -e

# Variables
BACKUP_FILE=$1

if [ -z "$BACKUP_FILE" ]; then
  echo "Usage: $0 <path-to-backup-file>"
  exit 1
fi

# Stop n8n to prevent data corruption
docker compose stop n8n

# Restore the database
gunzip < "$BACKUP_FILE" | docker compose exec -T postgres psql -U ${POSTGRES_USER} -d ${POSTGRES_DB}

# Start n8n again
docker compose start n8n

echo "Restore complete."
