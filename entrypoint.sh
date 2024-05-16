#!/bin/sh

set -eo pipefail

start(){
    echo "start_time=$(date +%s)" >> $GITHUB_OUTPUT
}

start

echo "[+] Start Time - Working"