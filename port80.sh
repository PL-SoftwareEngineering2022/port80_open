#!/bin/bash
gcloud services list --available --format json | jq -r ".[].config.name" >> endpoints.txt
# File containing the list of endpoints
endpoints_file="endpoints.txt"

# Loop through each endpoint in the file
while IFS= read -r endpoint || [[ -n "$endpoint" ]]; do
  # Perform the TCP ping for port 80 with a timeout of 5 seconds
  if tcping -t 5 "$endpoint" 80; then
    echo "$endpoint is reachable" >> port80open.txt
  else
    echo "$endpoint is not reachable" >> port80closed.txt
  fi
done < "$endpoints_file"
echo "script is done"
