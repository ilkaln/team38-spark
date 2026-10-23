#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

HDFS_PATH="${1:-hdfs://team-38-nn:9000/user/team/spark-course/input/penguins.csv}"

exec "$SCRIPT_DIR/run_session.sh" \
    "$PROJECT_DIR/src/transform_data.py" \
    "$HDFS_PATH"
