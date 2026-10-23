#!/usr/bin/env bash
set -euo pipefail

VERSION="3.5.3"
ARCHIVE="spark-${VERSION}-bin-without-hadoop.tgz"
URL="https://archive.apache.org/dist/spark/spark-${VERSION}"

if [[ -d "$HOME/opt/spark-${VERSION}-bin-without-hadoop" ]]; then
    echo "Spark ${VERSION} is already installed"
    exit 0
fi

mkdir -p "$HOME/opt" && cd "$HOME/opt"
wget "$URL/$ARCHIVE"
wget "$URL/$ARCHIVE.sha512"
sha512sum -c "$ARCHIVE.sha512"
tar -xzf "$ARCHIVE"
rm "$ARCHIVE" "$ARCHIVE.sha512"
echo "Spark ${VERSION} installed in $HOME/opt/spark-${VERSION}-bin-without-hadoop"
