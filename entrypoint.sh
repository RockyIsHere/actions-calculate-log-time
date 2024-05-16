#!/bin/sh

set -eo pipefail

curl -s -H "Authorization: Bearer $GITHUB_TOKEN" \
            -H "Accept: application/vnd.github.v3+json" \
            https://api.github.com/repos/$GITHUB_REPOSITORY/actions/runs/$GITHUB_RUN_ID \
            > run_details.json
# Fetch run details from GitHub Actions API and capture start time
start_at=$(jq -r '.created_at' run_details.json)
start_time=$(date -d "$start_at" +%s)
echo "Start Time: $(date -d "$start_at" +%s)"
echo "End Time: $(date +%s)"

# Function to calculate and output duration
calculate_duration() {
    local end_time=$(date +%s)
    local duration=$((end_time - start_time))

    # Convert duration to minutes and hours if needed
    if [ "$duration" -lt 60 ]; then
        echo "duration=${duration}s" >> $GITHUB_OUTPUT
    else
        local duration_minutes=$((duration / 60))
        if [ "$duration_minutes" -lt 60 ]; then
            echo "duration=${duration_minutes}m" >> $GITHUB_OUTPUT
        else
            local duration_hours=$((duration_minutes / 60))
            local duration_remaining_minutes=$((duration_minutes % 60))
            echo "duration=${duration_hours}h ${duration_remaining_minutes}m" >> $GITHUB_OUTPUT
        fi
    fi
}

# Call function to calculate and output duration
calculate_duration


echo "[+] Start Time - Done"
