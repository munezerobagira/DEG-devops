DeployReady — Submission

Summary

This challenge was mainly about deployment. I built the app container, the Docker Compose setup, and a GitHub Actions workflow that tests, builds, and deploys the service. The bonus work I did was Terraform for the deployment infrastructure.

Quick links

- App: [app](app)
- Deployment notes: [DEPLOYMENT.md](DEPLOYMENT.md)
- CI workflow: [.github/workflows/deploy.yml](.github/workflows/deploy.yml)

Local run

1. Build and start locally:

```bash
cd DeployReady/app
npm install
cd ..
docker compose up --build
```

2. Verify health check:

```bash
curl http://localhost:3000/health
```

CI/CD

- The workflow `.github/workflows/deploy.yml` runs on pushes to `main`. It tests, builds a Docker image tagged with the commit SHA, pushes the image to a registry, and deploys the new image to the target VM over SSH.
- The workflow steps are documented in the file and follow the same order I used while building it.

Deployment

- See [DEPLOYMENT.md](DEPLOYMENT.md) for the VM setup, Docker install, and deploy command I used.
- The GitHub Actions section explains the build, push, and deploy steps.

Verification checklist

- `docker compose up --build` starts the API on `localhost:3000`.
- The GitHub Actions workflow shows a successful run on `main` for builds and tests.
- On the deployed VM the health endpoint returns 200.

Bonus work

- The bonus project I did was Terraform for the deployment infrastructure.
