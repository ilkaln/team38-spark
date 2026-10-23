#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <hdfs-path> <format>" >&2
    echo "Formats: csv, json, parquet, text" >&2
    exit 1
fi

HDFS_PATH="$1"
FORMAT="$2"

exec "$SCRIPT_DIR/run_session.sh" \
    "$PROJECT_DIR/src/read_hdfs.py" \
    "$HDFS_PATH" \
    --format "$FORMAT"

