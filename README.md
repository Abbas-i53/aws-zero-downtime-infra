# AWS Zero-Downtime Infra + Cost Optimization

Blue-green deploys + Jenkins + Docker. Saves $50K+/yr pattern from resume.

Maps to resume: `AWS EC2/S3/Lambda/RDS, 25% cost cut, 40% faster deploys, zero-downtime`.

## Architecture
```
Git push -> Jenkins -> build Docker -> push ECR
  -> Blue (live) + Green (new) behind ALB -> flip target group
  -> RDS (Multi-AZ) + ElastiCache + S3 + CloudWatch alarms
  -> Lambda (image resize / webhook) + auto-scaling
```

## Cost levers (the $50K story)
1. Right-size EC2 + Graviton where possible
2. Reserved Instances / Savings Plans for baseline, on-demand for peak
3. RDS gp3 + stop dev DBs nights/weekends via Lambda schedule
4. S3 lifecycle: Standard -> IA -> Glacier, CloudFront cache
5. Scale-in at night, scale-out on CPU/latency alarms

Track in `cost/` sheet: before/after monthly bill screenshots.

## Quick start
```bash
# local blue-green simulation
docker compose up --build
curl http://localhost:8080/health  # ALB stub -> blue
./scripts/deploy-green.sh
```

## Files
- `Jenkinsfile` - build/test/push/promote
- `docker-compose.yml` - blue + green + nginx router
- `scripts/deploy-green.sh` - health-check then flip
- `infra/` - minimal Terraform-style notes (bring your own backend)

## Interview lines
- How health-check gates the flip, instant rollback = flip back.
- How DB migrations stay backward-compatible across blue/green.
