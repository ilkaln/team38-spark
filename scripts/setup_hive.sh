#!/usr/bin/env bash
set -euo pipefail

VERSION="4.1.0"
ARCHIVE="apache-hive-${VERSION}-bin.tar.gz"
URL="https://archive.apache.org/dist/hive/hive-${VERSION}"
DIR="$HOME/opt/apache-hive-${VERSION}-bin"

if [[ -x "$DIR/bin/hive" ]]; then
    "$DIR/bin/hive" --version
    exit 0
fi

mkdir -p "$HOME/opt" && cd "$HOME/opt"
wget "$URL/$ARCHIVE"
wget "$URL/$ARCHIVE.sha256"
sha256sum -c "$ARCHIVE.sha256"
tar -xzf "$ARCHIVE"
rm "$ARCHIVE" "$ARCHIVE.sha256"
"$DIR/bin/hive" --version
echo "Hive ${VERSION} installed in $DIR"
