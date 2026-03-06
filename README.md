
# Production-Ready Self-Hosted n8n

This repository contains everything you need to deploy a production-ready, self-hosted n8n automation system using Docker, PostgreSQL, and GitHub Actions for CI/CD.

## 1. Architecture Overview

The system is designed to be secure, reproducible, and easy to maintain. It consists of the following components:

- **n8n:** The core automation platform, running in a Docker container.
- **PostgreSQL:** A dedicated PostgreSQL database for n8n data, running in a separate Docker container.
- **Docker Compose:** To define and manage the multi-container Docker application.
- **SOPS:** For encrypting secrets, ensuring no sensitive information is stored in plaintext in the repository.
- **Age:** The encryption tool used with SOPS.
- **GitHub Actions:** For continuous integration and continuous deployment (CI/CD), automatically deploying changes to your VPS.
- **Nginx (optional):** A template for a reverse proxy to provide HTTPS and custom domain support.

## 2. First-time VPS setup

1.  **Provision a VPS:** Start with a fresh Ubuntu 22.04 server.

2.  **Clone the repository:**

    ```bash
    git clone https://github.com/your-username/n8n-production-system.git
    cd n8n-production-system
    ```

3.  **Run the bootstrap script:** This will install Docker, Docker Compose, SOPS, and Age.

    ```bash
    bash scripts/bootstrap-vps.sh
    ```

4.  **Log out and log back in:** This is necessary for the `docker` group changes to take effect.

## 3. Age key generation

1.  **Generate an Age key:**

    ```bash
    age-keygen -o age.key
    ```

2.  **Secure the private key:** The `age.key` file contains your private key. **DO NOT** commit this file to your repository. Store it in a safe place, such as a password manager or an encrypted volume.

3.  **Get your public key:**

    ```bash
    cat age.key | grep public
    ```

4.  **Update `.sops.yaml`:** Replace the placeholder public key in `.sops.yaml` with your public key.

## 4. Encrypting secrets

1.  **Create a `secrets.yaml` file:** This file will contain your secrets in plaintext. **DO NOT** commit this file to your repository.

    ```yaml
    POSTGRES_USER: "myuser"
    POSTGRES_PASSWORD: "mypassword"
    POSTGRES_DB: "n8n"
    N8N_ENCRYPTION_KEY: "a-very-long-and-random-string"
    WEBHOOK_URL: "https://your-domain.com"
    WHATSAPP_PHONE_NUMBER_ID: "your-whatsapp-phone-number-id"
    WHATSAPP_ACCESS_TOKEN: "your-whatsapp-access-token"
    WHATSAPP_BUSINESS_ACCOUNT_ID: "your-whatsapp-business-account-id"
    ```

2.  **Encrypt the secrets:**

    ```bash
    sops --encrypt --in-place secrets.yaml
    ```

    This will create `secrets.enc.yaml`.

## 5. Initial deployment

1.  **Set up GitHub Secrets:** In your GitHub repository, go to `Settings` > `Secrets and variables` > `Actions` and add the following secrets:

    -   `VPS_HOST`: The IP address of your VPS.
    -   `VPS_USER`: The username you use to SSH into your VPS.
    -   `VPS_SSH_KEY`: The private SSH key you use to access your VPS.

2.  **Push to `main`:**

    ```bash
    git add .
    git commit -m "Initial commit"
    git push origin main
    ```

3.  **Monitor the deployment:** The GitHub Actions workflow will automatically trigger, deploying your n8n system to the VPS.

## 6. Updating workflows

1.  **Add new workflows:** Place your n8n workflow JSON files in the `workflows/` directory.

2.  **Commit and push:**

    ```bash
    git add workflows/
    git commit -m "Add new workflow"
    git push origin main
    ```

3.  **Automatic import:** The CI/CD pipeline will automatically import the new workflows into your n8n instance.

## 7. Backup & restore

### Backup

To create a backup of your n8n database, run the following command on your VPS:

```bash
bash scripts/backup.sh
```

This will create a timestamped backup file in the `/home/ubuntu/n8n-backups` directory.

### Restore

To restore your n8n database from a backup, run the following command on your VPS:

```bash
bash scripts/restore.sh /home/ubuntu/n8n-backups/n8n-backup-YYYY-MM-DD_HH-MM-SS.sql.gz
```

Replace the filename with the actual backup file you want to restore.

## 8. Disaster recovery

In the event of a complete server failure, you can recover your n8n system by following these steps:

1.  **Provision a new VPS:** Follow the "First-time VPS setup" instructions.
2.  **Restore your database:** Copy your latest backup file to the new VPS and use the `restore.sh` script.
3.  **Deploy:** Push your repository to the new VPS to redeploy your n8n instance.

## 9. Security notes

-   **`N8N_ENCRYPTION_KEY`:** This key is used to encrypt credentials within n8n. It is critical to keep this key safe and persistent. If you lose it, your credentials will be unrecoverable.
-   **Secrets:** All secrets are encrypted using SOPS and Age. The private Age key is the master key to all your secrets. Keep it secure and backed up.
-   **SSH Key:** The SSH key used for deployment should be a dedicated key for this purpose and should not have a passphrase.
-   **Firewall:** It is highly recommended to configure a firewall on your VPS to restrict access to only the necessary ports (e.g., 22, 80, 443).

## 10. Production hardening suggestions

-   **Reverse Proxy:** Use a reverse proxy like Nginx or Caddy to provide HTTPS, custom domains, and an additional layer of security.
-   **Firewall:** Configure a firewall (e.g., ufw) to restrict incoming traffic to only the necessary ports.
-   **Regular Updates:** Keep your VPS, Docker, and all other software up to date with the latest security patches.
-   **Monitoring:** Set up monitoring and alerting to be notified of any issues with your n8n instance or the underlying server.
-   **Log Rotation:** Configure log rotation for the Docker containers to prevent logs from consuming all available disk space.
