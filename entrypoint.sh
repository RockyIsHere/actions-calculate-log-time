#!/bin/sh

set -eo pipefail

start(){
    echo "run_id=$(echo $GITHUB_RUN_ID)" >> $GITHUB_OUTPUT
    curl -s -H "Authorization: Bearer ${{ secrets.GITHUB_TOKEN }}" \
    -H "Accept: application/vnd.github.v3+json" \
    https://api.github.com/repos/${{ github.repository }}/actions/runs/$(echo $GITHUB_RUN_ID) \
    > run_details.json
    start_at=$(jq -r '.created_at' run_details.json)
    echo "start_time=$(start_at)" >> $GITHUB_OUTPUT
}

start

echo "[+] Start Time - Working"