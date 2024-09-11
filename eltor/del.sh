#!/bin/bash

# Directory to search for log files
LOG_DIR="$HOME/code/chutney/net/nodes.1725051519"

# Check if the directory exists
if [ ! -d "$LOG_DIR" ]; then
  echo "Directory $LOG_DIR does not exist."
  exit 1
fi

# Find and print all .log files in the directory and its subdirectories
find "$LOG_DIR" -type f -name "*.log" -delete
 

# Optional: Print a message indicating the operation is complete
echo "Deleted all log files in $LOG_DIR and its subdirectories."