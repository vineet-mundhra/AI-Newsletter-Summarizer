#!/bin/bash

# Exit on any error
set -e

# Variables
BACKUP_DIR="/home/ubuntu/n8n-backups"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/n8n-backup-$TIMESTAMP.sql.gz"

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Run pg_dump and compress the output
docker compose exec -T postgres pg_dump -U ${POSTGRES_USER} -d ${POSTGRES_DB} | gzip > $BACKUP_FILE

# Optional: Remove old backups (e.g., older than 7 days)
find $BACKUP_DIR -type f -name '*.sql.gz' -mtime +7 -delete

echo "Backup successful: $BACKUP_FILE"
