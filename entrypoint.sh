#!/bin/sh

set -eo pipefail

start(){
    start_time=$(echo "${{ github.event.repository.created_at }}")
    end_time=$(date +%s)
    duration=$((end_time - start_time))
    if [[ $duration -lt 60 ]]; then
        echo "duration=${duration}s" >> $GITHUB_OUTPUT
        else
        duration_minutes=$((duration / 60))
        if [[ $duration_minutes -lt 60 ]]; then
            echo "duration=${duration_minutes}m" >> $GITHUB_OUTPUT
        else
            duration_hours=$((duration_minutes / 60))
            duration_remaining_minutes=$((duration_minutes % 60))
            echo "duration=${duration_hours}h ${duration_remaining_minutes}m" >> $GITHUB_OUTPUT
        fi
    fi
}

start

echo "[+] Start Time - Done" # You can put whatever message you want here
