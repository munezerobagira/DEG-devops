# Deployment Notes

This document describes how I set up the deployment for the DeployReady application and how to reproduce it.

## Overview

DeployReady is deployed on Microsoft Azure using Terraform. The application runs inside a Docker container on an Azure Linux virtual machine. GitHub Actions builds the container image, publishes it to GitHub Container Registry (GHCR), and then connects to the VM over SSH to pull and restart the new image.

## Infrastructure

The infrastructure is defined in [`DeployReady/infra/`](infra/).

Terraform creates the following Azure resources:

- Resource group
- Virtual network
- Subnet
- Public IP
- Network security group
- Network interface
- Linux virtual machine

The VM uses the `Standard_B1s` size and the current Terraform configuration enables SSH key authentication.

## Required Terraform Inputs

The deployment is controlled through `DeployReady/infra/terraform.tfvars`.

Required values:

- `subscription_id`: Azure subscription ID
- `my_ip`: public IP address used to restrict SSH access
- `admin_username`: VM username

Example:

```hcl
subscription_id = "<your-azure-subscription-id>"
my_ip           = "<your-public-ip>"
admin_username  = "<your-admin-username>"
```

## SSH Key Handling

Terraform generates the SSH key pair during `terraform apply`.

- The private key is written to `DeployReady/infra/ssh_private_key.pem`
- The file is ignored by `.gitignore`
- The public key is injected into the VM during provisioning

Terraform outputs the following values after apply:

```bash
terraform output ssh_public_key
terraform output private_key_path
terraform output public_ip
terraform output admin_username
```

Use the private key to connect to the VM:

```bash
ssh -i infra/ssh_private_key.pem <admin_username>@<public_ip>
```

## Deployment Flow

The deployment flow is:

1. Run tests in GitHub Actions.
2. Build the Docker image.
3. Push the image to GHCR with the commit SHA tag.
4. SSH into the VM.
5. Pull the new image on the VM.
6. Stop and remove the old container.
7. Start the new container.

The image tag format is:

```text
ghcr.io/<github-owner>/deployready:<commit-sha>
```

Example container commands on the VM:

```bash
docker pull ghcr.io/<github-owner>/deployready:<commit-sha>
docker stop deployready || true
docker rm deployready || true
docker run -d --restart unless-stopped -p 80:3000 \
  --env-file /home/<ssh-username>/deployready.env \
  --name deployready \
  ghcr.io/<github-owner>/deployready:<commit-sha>
```

## GitHub Actions

The workflow in [`.github/workflows/deploy.yml`](../.github/workflows/deploy.yml) performs the following steps:

- Runs `npm test`
- Builds the Docker image
- Pushes the image to GHCR
- Connects to the VM with `SSH_HOST`, `SSH_USERNAME`, and `SSH_KEY`
- Pulls the new image and restarts the container

The SSH key is stored as a GitHub secret. The secret must contain the private key that matches the public key configured on the VM.

## Verification
 Confirm the service is running with:

```bash
curl http://<public-ip>/health
```

A successful deployment should return:

```json
{ "status": "ok" }
```

from the `/health` endpoint.

## Notes

- SSH access is restricted to the configured public IP.
- The container image is always deployed using the commit SHA tag from GitHub Actions.
