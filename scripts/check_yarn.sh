#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/spark_env.sh"

yarn application -list -appStates ALL
