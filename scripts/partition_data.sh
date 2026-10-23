#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

HDFS_INPUT="${1:-hdfs://team-38-nn:9000/user/team/spark-course/input/penguins.csv}"
HDFS_OUTPUT="${2:-hdfs://team-38-nn:9000/user/team/spark-course/output/penguins_partitioned}"

"$SCRIPT_DIR/run_session.sh" \
    "$PROJECT_DIR/src/partition_data.py" \
    "$HDFS_INPUT" \
    "$HDFS_OUTPUT"

echo
echo "HDFS partition directories:"
hdfs dfs -ls "$HDFS_OUTPUT"
