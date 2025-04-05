#!/bin/bash

# Thresholds
CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=90
LOG_FILE="/var/log/system_health.log"
EMAIL="pardhasardhiraob@gmail.com"

# Get system metrics
get_cpu_usage() {
    top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}' | cut -d'.' -f1
}

get_mem_usage() {
    free | awk '/Mem:/ {print $3/$2 * 100}' | cut -d'.' -f1
}

get_disk_usage() {
    df / | awk 'NR==2 {print $5}' | tr -d '%'
}

get_uptime() {
    uptime -p
}

#Get Network usage
get_network_usage() {
    ifstat -t 1 1 | awk 'NR==3 {print "RX: " $1 " KB/s | TX: " $2 " KB/s"}'
}

# Logging function
log_message() {
    echo "$(date): $1" | tee -a "$LOG_FILE"
}

# Alert function (email + GUI popup)
send_alert() {
    MESSAGE=$1
    echo "$MESSAGE" | mail -s "⚠️ System Health Alert" "$EMAIL"

    # GUI notification (only if display exists)
    if command -v notify-send &>/dev/null && [ -n "$DISPLAY" ]; then
        notify-send "System Health Alert" "$MESSAGE"
    fi
}

# CPU Check
CPU_USAGE=$(get_cpu_usage)
if (( CPU_USAGE > CPU_THRESHOLD )); then
    ALERT="⚠️ High CPU Usage: ${CPU_USAGE}%"
    log_message "$ALERT"
    send_alert "$ALERT"
else
    log_message "✅ CPU Usage: ${CPU_USAGE}%"
fi

# Memory Check
MEM_USAGE=$(get_mem_usage)
if (( MEM_USAGE > MEM_THRESHOLD )); then
    ALERT="⚠️ High Memory Usage: ${MEM_USAGE}%"
    log_message "$ALERT"
    send_alert "$ALERT"
else
    log_message "✅ Memory Usage: ${MEM_USAGE}%"
fi

# Disk Check
DISK_USAGE=$(get_disk_usage)
if (( DISK_USAGE > DISK_THRESHOLD )); then
    ALERT="⚠️ High Disk Usage: ${DISK_USAGE}%"
    log_message "$ALERT"
    send_alert "$ALERT"
else
    log_message "✅ Disk Usage: ${DISK_USAGE}%"
fi

# System Uptime
UPTIME=$(get_uptime)
log_message "ℹ️ System Uptime: ${UPTIME}"

# Network
NETWORK=$(get_network_usage)
log_message "🌐 Network Usage: $NETWORK"

# Final output
log_message "✅ System health check completed!"

