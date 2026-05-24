WatchTower — Submission

Summary

I built an observability stack with three services, Prometheus, and Grafana. It runs locally with Docker Compose.

Quick links

- App and compose: [app](app)
- Grafana dashboards: [app/grafana/dashboards](app/grafana/dashboards)
- Prometheus config: [app/prometheus](app/prometheus)

Architecture

Local stack running under `docker compose`:

- Three app services expose `/metrics` and `/health`.
- Prometheus scrapes each service every 15s.
- Grafana loads a dashboard JSON on startup.

Start the stack

```bash
cd WatchTower/app
docker compose up --build
```

Verify

- Prometheus UI: http://localhost:9090 — check `/targets` to confirm services are `UP`.
- Grafana UI: http://localhost:3000 — the dashboard loads automatically.

Dashboard walkthrough

- The dashboard includes uptime, request rate, and basic health panels.

Alerting

- Alerting was not completed in this challenge.

Structured logging

- The Docker Compose file uses `logging` with the `json-file` driver.
- Example commands:

View live logs for all services:

```bash
docker compose logs -f
```

View only errors for a specific service (example for `order-service`):

```bash
docker compose logs -f order-service | grep -i "error"
```

Attempted bonus work

- The bonus project I did was the uptime graph in Grafana.
