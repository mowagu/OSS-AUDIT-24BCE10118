#!/bin/bash
# Script 4: Log File Analyzer
# Author: Arpit Raj Singh | Course: Open Source Software
# Usage: ./script4_log_analyzer.sh /path/to/logfile [keyword]
# Example: ./script4_log_analyzer.sh /var/log/kern.log error

# --- Accept command-line arguments ---
LOGFILE=$1               # First argument: path to the log file to analyze
KEYWORD=${2:-"error"}    # Second argument: keyword to search for (default: "error")
COUNT=0                  # Counter to track how many matching lines are found

# --- Validate that a log file argument was provided ---
if [ -z "$LOGFILE" ]; then
    echo "Usage: $0 <logfile> [keyword]"
    echo "Example: $0 /var/log/kern.log error"
    exit 1
fi

# --- Check that the log file exists and is a regular file ---
if [ ! -f "$LOGFILE" ]; then
    echo "Error: File '$LOGFILE' not found or is not a regular file."
    exit 1
fi

# --- Check that the file is not empty before processing ---
if [ ! -s "$LOGFILE" ]; then
    echo "Warning: File '$LOGFILE' is empty. Nothing to analyze."
    exit 0
fi

echo "============================================"
echo "  LOG FILE ANALYZER"
echo "============================================"
echo "  Log File : $LOGFILE"
echo "  Keyword  : '$KEYWORD' (case-insensitive)"
echo "============================================"
echo ""

# --- Read the file line by line using a while-read loop ---
while IFS= read -r LINE; do
    # If the current line contains the keyword (case-insensitive), increment counter
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))
    fi
done < "$LOGFILE"

# --- Count total lines in file using wc -l ---
TOTAL=$(wc -l < "$LOGFILE")

# --- Print the summary results ---
echo "  Total lines in file       : $TOTAL"
echo "  Lines matching '$KEYWORD' : $COUNT"

# --- Calculate match percentage if total is non-zero ---
if [ "$TOTAL" -gt 0 ]; then
    PERCENT=$(( COUNT * 100 / TOTAL ))
    echo "  Match percentage          : $PERCENT%"
fi

echo ""
echo "=== Last 5 lines matching '$KEYWORD' ==="

# --- Use grep to find matches, then tail to show the last 5 ---
MATCHES=$(grep -i "$KEYWORD" "$LOGFILE" | tail -5)

if [ -z "$MATCHES" ]; then
    echo "  (No matches found for '$KEYWORD')"
else
    echo "$MATCHES"
fi

echo ""
echo "Analysis complete."
