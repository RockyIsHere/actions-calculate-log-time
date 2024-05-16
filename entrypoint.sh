#!/bin/sh

set -eo pipefail

start(){
    # Fetch run details and store in run_details.json
    curl -s -H "Authorization: Bearer $GITHUB_TOKEN" \
    -H "Accept: application/vnd.github.v3+json" \
    "https://api.github.com/repos/$GITHUB_REPOSITORY/actions/runs/$GITHUB_RUN_ID" \
    > run_details.json

    # Extract start time from run_details.json
    start_at=$(jq -r '.created_at' run_details.json)

    # Output start time to the specified output file
    echo "start_time=$start_at" >> "$GITHUB_OUTPUT"
}

start

echo "[+] Start Time - Working" # You can put whatever message you want here
