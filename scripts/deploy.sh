#!/bin/bash

# Exit on any error
set -e

# Decrypt secrets and create .env file
sops -d secrets.enc.yaml > .env

# Pull latest images
docker compose pull

# Start services
docker compose up -d --remove-orphans

# Wait for n8n to be healthy
# This is a simple wait, a more robust solution would check the API
sleep 30

# Import workflows
for workflow in workflows/*.json; do
  if [ -f "$workflow" ]; then
    docker compose exec -T n8n n8n import:workflow --input="$workflow"
  fi
done

echo "Deployment complete."
