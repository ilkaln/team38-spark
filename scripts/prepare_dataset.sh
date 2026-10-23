#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

DATASET_URL="https://raw.githubusercontent.com/allisonhorst/palmerpenguins/main/inst/extdata/penguins.csv"
LOCAL_FILE="$PROJECT_DIR/data/penguins.csv"
HDFS_DIR="/user/team/spark-course/input"

echo "Downloading dataset..."

if ! curl -fsSL "$DATASET_URL" -o "$LOCAL_FILE"; then
    echo "Error: failed to download dataset" >&2
    exit 1
fi

echo "Uploading dataset to HDFS..."

if ! hdfs dfs -mkdir -p "$HDFS_DIR" ||
   ! hdfs dfs -put -f "$LOCAL_FILE" "$HDFS_DIR/penguins.csv"; then
    echo "Error: failed to upload dataset to HDFS" >&2
    exit 1
fi

echo "Dataset downloaded and uploaded successfully"
