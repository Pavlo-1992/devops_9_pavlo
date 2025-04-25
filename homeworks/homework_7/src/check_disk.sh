#!/bin/bash

LOG_FILE="/var/log/disk.log"
THRESHOLD=$1  # Threshold passed as an argument to the script

if [ -z "$THRESHOLD" ]; then
  echo "Usage: $0 <threshold>" >&2
  exit 1
fi

CURRENT_USAGE=$(df --output=pcent / | tail -1 | tr -dc '0-9')

if [ "$CURRENT_USAGE" -ge "$THRESHOLD" ]; then
  echo "[$(date)] WARNING: Disk usage is at ${CURRENT_USAGE}% which exceeds the threshold of ${THRESHOLD}%." >> $LOG_FILE

