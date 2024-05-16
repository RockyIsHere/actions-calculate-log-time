set -eo pipefail

start(){
    echo "start_time=$(date +%s)" >> $GITHUB_OUTPUT
}

echo "[+] Start Time - Working"