#!/bin/bash

# Slack webhook URL
SLACK_WEBHOOK_URL="YOUR_SLACK_WEBHOOK_URL"

# Array of IP addresses to ping
IP_ADDRESSES=("192.168.1.1" "8.8.8.8" "10.0.0.1")

# Function to send message to Slack
send_slack_message() {
    local message="$1"
    curl -s -X POST -H 'Content-type: application/json' --data "{\"text\":\"$message\"}" "$SLACK_WEBHOOK_URL" >/dev/null
}

# Loop through the IP addresses and ping each one
for ip in "${IP_ADDRESSES[@]}"; do
    # Get the current date and time
    current_datetime=$(date +"%Y-%m-%d %H:%M:%S")

    # Ping the IP address and capture the result
    ping_result=$(ping -c 3 "$ip")

    # Create the message with date, time, IP address, and ping result
    message="[$current_datetime] Ping result for $ip:\n$ping_result"

    # Send the message to Slack
    send_slack_message "$message"
done
