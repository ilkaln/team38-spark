#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

source "$SCRIPT_DIR/spark_env.sh"

export HIVE_HOME="$HOME/opt/apache-hive-4.1.0-bin"

cd "$PROJECT_DIR"

SQL_FILE="$PROJECT_DIR/sql/register_penguins_filtered.sql"
LOG_DIR="$PROJECT_DIR/logs"
LOG_FILE="$LOG_DIR/register_hive_table.log"

mkdir -p "$LOG_DIR"

if [[ ! -x "$HIVE_HOME/bin/schematool" ]]; then
    echo "Error: Hive schematool not found"
    exit 1
fi

if [[ ! -f "$SQL_FILE" ]]; then
    echo "Error: SQL file not found: $SQL_FILE"
    exit 1
fi

echo "Checking Hive Metastore schema"

if "$HIVE_HOME/bin/schematool" -dbType derby -info \
    >"$LOG_FILE" 2>&1; then
    echo "Metastore schema is initialized"
else
    echo "Initializing Metastore schema"

    if ! "$HIVE_HOME/bin/schematool" -dbType derby -initSchema \
        >"$LOG_FILE" 2>&1; then
        cat "$LOG_FILE"
        exit 1
    fi
fi

echo "Registering the penguins table and running the query"

if "$HIVE_HOME/bin/beeline" \
    --force=false \
    --silent=true \
    -u 'jdbc:hive2:///' \
    -f "$SQL_FILE" >"$LOG_FILE" 2>&1; then

    echo
    echo "Query result:"
    grep -E 'species|Adelie|Chinstrap|Gentoo|rows selected' "$LOG_FILE" || true
    echo
    echo "Hive stage completed successfully"
    echo "Full log: $LOG_FILE"
else
    echo "Hive execution failed. Full log:"
    cat "$LOG_FILE"
    exit 1
fi
