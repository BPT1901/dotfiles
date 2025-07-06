#!/bin/bash

# File to store previous values
CACHE_FILE="/tmp/network_stats_cache"

# Function to get network stats for active interface
get_network_stats() {
    # Find the active network interface
    ACTIVE_INTERFACE=$(route get default 2>/dev/null | grep interface | awk '{print $2}')
    
    if [[ -z "$ACTIVE_INTERFACE" ]]; then
        # Fallback: find first active interface
        ACTIVE_INTERFACE=$(ifconfig | grep -E "^en[0-9]:" | while read line; do
            INTERFACE=$(echo "$line" | cut -d: -f1)
            if ifconfig "$INTERFACE" 2>/dev/null | grep -q "status: active"; then
                echo "$INTERFACE"
                break
            fi
        done)
    fi
    
    if [[ -n "$ACTIVE_INTERFACE" ]]; then
        # Get bytes in and out
        STATS=$(netstat -ibn | grep "$ACTIVE_INTERFACE" | head -1)
        BYTES_IN=$(echo "$STATS" | awk '{print $7}')
        BYTES_OUT=$(echo "$STATS" | awk '{print $10}')
        
        echo "$ACTIVE_INTERFACE $BYTES_IN $BYTES_OUT"
    else
        echo "none 0 0"
    fi
}

# Function to convert bytes to human readable format
human_readable() {
    local bytes=$1
    local mb_per_sec=$(awk "BEGIN {printf \"%.2f\", $bytes / 1048576}")
    echo "${mb_per_sec}MB/s"
}

# Get current stats
CURRENT_STATS=$(get_network_stats)
CURRENT_TIME=$(date +%s)

INTERFACE=$(echo "$CURRENT_STATS" | awk '{print $1}')
CURRENT_IN=$(echo "$CURRENT_STATS" | awk '{print $2}')
CURRENT_OUT=$(echo "$CURRENT_STATS" | awk '{print $3}')

# Read previous stats if they exist
if [[ -f "$CACHE_FILE" ]]; then
    PREV_DATA=$(cat "$CACHE_FILE")
    PREV_TIME=$(echo "$PREV_DATA" | awk '{print $1}')
    PREV_IN=$(echo "$PREV_DATA" | awk '{print $2}')
    PREV_OUT=$(echo "$PREV_DATA" | awk '{print $3}')
    
    # Calculate time difference
    TIME_DIFF=$((CURRENT_TIME - PREV_TIME))
    
    if [[ $TIME_DIFF -gt 0 ]]; then
        # Calculate speed (bytes per second)
        SPEED_IN=$(( (CURRENT_IN - PREV_IN) / TIME_DIFF ))
        SPEED_OUT=$(( (CURRENT_OUT - PREV_OUT) / TIME_DIFF ))
        
        # Format speeds
        SPEED_IN_FORMATTED=$(human_readable $SPEED_IN)
        SPEED_OUT_FORMATTED=$(human_readable $SPEED_OUT)
        
        # Create display string
        INFO="↓$SPEED_IN_FORMATTED ↑$SPEED_OUT_FORMATTED"
    else
        INFO="↓0B/s ↑0B/s"
    fi
else
    INFO="↓0B/s ↑0B/s"
fi

# Save current stats for next run
echo "$CURRENT_TIME $CURRENT_IN $CURRENT_OUT" > "$CACHE_FILE"

echo "$(date): Interface: $INTERFACE, Info: '$INFO'" >> /tmp/network_debug.log

sketchybar --set network label="$INFO"