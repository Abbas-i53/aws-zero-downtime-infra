#!/bin/sh
# health-gate then flip (stub for ALB target-group flip)
set -e
BUILD=${1:-latest}
echo "checking green health for build $BUILD..."
curl -sf http://localhost:8082/ > /dev/null || echo "green not up yet (local stub)"
echo "flip router to green, keep blue for instant rollback"
