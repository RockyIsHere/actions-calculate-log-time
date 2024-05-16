start_at=$(jq -r '.created_at' run_details.json)

2024-05-16T17:38:55Z

start_time=$(date -d "2024-05-16T17:38:55Z" +%s)
echo "Start Time: $(date -d "$start_at" +%s)"


start_at="2024-05-16T17:38:55Z"

# Convert start time to Unix timestamp
start_time=$(date -d $start_at +%s)
echo "Start Time: $(date -d $start_at +%s)"
