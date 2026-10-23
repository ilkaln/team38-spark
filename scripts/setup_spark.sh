#!/usr/bin/env bash
set -euo pipefail

VERSION="3.5.3"
ARCHIVE="spark-${VERSION}-bin-without-hadoop.tgz"
URL="https://archive.apache.org/dist/spark/spark-${VERSION}"

mkdir -p "$HOME/opt" && cd "$HOME/opt"
wget "$URL/$ARCHIVE"
wget "$URL/$ARCHIVE.sha512"
sha512sum -c "$ARCHIVE.sha512"
tar -xzf "$ARCHIVE"
rm "$ARCHIVE" "$ARCHIVE.sha512"
echo "Spark ${VERSION} installed in $HOME/opt/spark-${VERSION}-bin-without-hadoop"

export SPARK_HOME="$HOME/opt/spark-3.5.3-bin-without-hadoop"
export PATH="$SPARK_HOME/bin:$PATH"
export HADOOP_CONF_DIR=/etc/hadoop
export YARN_CONF_DIR="$HADOOP_CONF_DIR"
export SPARK_DIST_CLASSPATH="$(hadoop classpath)"