#!/bin/sh

set -eo pipefail

# Ensure that $GITHUB_RUN_ID and $GITHUB_REPOSITORY are provided
if [ -z "$GITHUB_RUN_ID" ]; then
    echo "Error: GITHUB_RUN_ID is not set"
    exit 1
fi

if [ -z "$GITHUB_REPOSITORY" ]; then
    echo "Error: GITHUB_REPOSITORY is not set"
    exit 1
fi

# Fetch run details from GitHub Actions API and capture start time
run_details=$(curl -s -H "Authorization: Bearer $GITHUB_TOKEN" \
    -H "Accept: application/vnd.github.v3+json" \
    "https://api.github.com/repos/$GITHUB_REPOSITORY/actions/runs/$GITHUB_RUN_ID")

# Extract start time from run details
start_at=$(echo "$run_details" | grep -o '"created_at":[^,]*' | cut -d '"' -f 4)

# Convert ISO 8601 date string to Unix timestamp
start_time=$(date -d "$start_at" +%s || true)

# Check if conversion was successful
if [ -z "$start_time" ]; then
    echo "Error: Failed to parse start time"
    exit 1
fi

echo "Start Time: $start_time"

# Output end time (current time)
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
