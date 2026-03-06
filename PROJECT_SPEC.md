Below is a **production‑ready master prompt** you can give directly to Manus.

It is structured, explicit, and artifact-driven so Manus generates a complete, deployable system — not just explanations.

You can paste this as-is.

---

# ✅ FULL PRODUCTION-READY PROMPT FOR MANUS

---

You are a senior DevOps + backend automation engineer.

I need you to generate a **complete, production-ready repository** for a self-hosted automation system using **n8n**, deployed on a VPS, secured properly, and fully CI/CD-enabled.

This must be structured, secure, reproducible, and professional-grade.

Do NOT provide explanations only.  
Generate actual files with full contents.

---

# 🎯 SYSTEM GOAL

Build a production-ready, self-hosted n8n automation system with:

- Docker-based deployment
- PostgreSQL database
- GitHub as source of truth
- Encrypted secrets using SOPS (Age method preferred)
- CI/CD auto-deploy to VPS
- Workflow JSON import system
- Backup and restore scripts
- WhatsApp Business API integration capability
- Secure handling of credentials
- Proper .gitignore hygiene

The output must be a complete repository structure.

---

# 🏗 ARCHITECTURE REQUIREMENTS

## Infrastructure

- Ubuntu VPS (22.04 compatible)
- Docker + Docker Compose
- PostgreSQL container
- n8n container
- Reverse proxy ready (optional config stub for Nginx or Caddy)
- HTTPS-ready environment variables
- No plaintext secrets in repo

---

# 🔐 SECURITY MODEL

- All secrets must be stored in `secrets.enc.yaml`
- Use SOPS with Age encryption
- Include `.sops.yaml` config
- No `.env` committed
- `.env` generated only during deploy
- `N8N_ENCRYPTION_KEY` must be environment-based and persistent
- GitHub Actions must not expose secrets in logs
- Add secure .gitignore

---

# 🚀 DEPLOYMENT FLOW

Push to `main` branch →  
GitHub Actions →  
SSH into VPS →  
Pull repo →  
Decrypt secrets via SOPS →  
Generate `.env` →  
Run `docker compose pull` →  
Run `docker compose up -d --remove-orphans` →  
Import workflows automatically →  
Restart services safely  

Include safe restart logic and basic health wait.

---

# 📂 REQUIRED REPOSITORY STRUCTURE

Generate this full structure:

```
n8n-production-system/
│
├── docker-compose.yml
├── .sops.yaml
├── secrets.enc.yaml (template example)
├── workflows/
│   ├── example_workflow.json
│
├── scripts/
│   ├── bootstrap-vps.sh
│   ├── deploy.sh
│   ├── backup.sh
│   ├── restore.sh
│
├── .github/
│   └── workflows/
│       └── deploy.yml
│
├── nginx/
│   └── example.conf (optional reverse proxy template)
│
├── .gitignore
├── README.md
└── PROJECT_SPEC.md
```

All files must contain full content.

---

# 🐳 DOCKER REQUIREMENTS

docker-compose.yml must:

- Use Postgres 15+
- Use official n8n image
- Use named volumes
- Use environment variables from `.env`
- Support webhook URL configuration
- Include restart policies
- Include healthchecks where appropriate

---

# 🔄 WORKFLOW HANDLING

- Include CLI import command
- Support import of all JSON files from `/workflows`
- Do NOT overwrite active workflows unintentionally
- Include script logic to handle safe re-import

---

# 💾 BACKUP STRATEGY

Provide:

- `backup.sh` for Postgres dump
- Timestamped backups
- Restore script
- Instructions in README
- Cron example

---

# 🔑 SECRETS CONFIG

Include:

- Example `secrets.enc.yaml` structure (fake placeholder values)
- `.sops.yaml` configured for Age
- Clear instructions for:
  - generating age key
  - storing private key on VPS
  - encrypting secrets
  - decrypting during deploy

---

# 🧠 CREDENTIAL SAFETY

Document:

- How n8n credentials are stored
- Importance of `N8N_ENCRYPTION_KEY`
- Safe backup strategy
- Restore procedure
- Disaster recovery steps

---

# 🤖 WHATSAPP API PREP

Include environment placeholders for:

- WHATSAPP_PHONE_NUMBER_ID
- WHATSAPP_ACCESS_TOKEN
- WHATSAPP_BUSINESS_ACCOUNT_ID

Do not hardcode real values.

---

# 🧪 CI/CD REQUIREMENTS

GitHub Actions must:

- Use latest stable action versions
- Use SSH deploy method
- Use GitHub Secrets:
  - VPS_HOST
  - VPS_USER
  - VPS_SSH_KEY
- Never echo decrypted secrets
- Include minimal error handling
- Use safe shell practices

---

# 📘 README REQUIREMENTS

README must include:

1. Architecture overview
2. First-time VPS setup
3. Age key generation
4. Encrypting secrets
5. Initial deployment
6. Updating workflows
7. Backup & restore
8. Disaster recovery
9. Security notes
10. Production hardening suggestions

Make it professional and clear.

---

# 📌 OUTPUT FORMAT RULES

- Provide each file in a separate clearly labeled code block.
- Use this format:

```
File: docker-compose.yml
<code>
```

- No placeholders like “...”
- No missing content
- No explanatory essay outside file blocks except short section headers

---

# 🚨 CONSTRAINTS

- Do not assume cloud provider specifics
- Do not include paid services
- Must work on a generic Ubuntu VPS
- Must be reproducible
- Must be secure by default

---

# ✅ END GOAL

When I copy this repository to GitHub and run:

```
bash scripts/bootstrap-vps.sh
```

Then configure secrets and push to main,

The system should deploy automatically and run securely.

---

Generate everything now.

---
