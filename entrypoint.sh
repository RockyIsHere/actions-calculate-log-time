#!/bin/sh

set -eo pipefail

start(){
    # Fetch run details and store in run_details.json
    wget -q --header="Authorization: Bearer $GITHUB_TOKEN" \
    --header="Accept: application/vnd.github.v3+json" \
    -O run_details.json \
    "https://api.github.com/repos/$GITHUB_REPOSITORY/actions/runs/$GITHUB_RUN_ID"

    # Extract start time from run_details.json
    start_at=$(jq -r '.created_at' run_details.json)

    # Output start time to the specified output file
    echo "start_time=$start_at" >> "$GITHUB_OUTPUT"
}

start

echo "[+] Start Time - Working" # You can put whatever message you want here
