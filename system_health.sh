#!/bin/bash

# Thresholds
CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=90
LOG_FILE="/var/log/system_health.log"

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

# Log function
log_message() {
    echo "$(date): $1" | tee -a "$LOG_FILE"
}

# Check CPU
CPU_USAGE=$(get_cpu_usage)
if (( CPU_USAGE > CPU_THRESHOLD )); then
    log_message "⚠️ High CPU Usage: ${CPU_USAGE}%"
fi

# Check Memory
MEM_USAGE=$(get_mem_usage)
if (( MEM_USAGE > MEM_THRESHOLD )); then
    log_message "⚠️ High Memory Usage: ${MEM_USAGE}%"
fi

# Check Disk
DISK_USAGE=$(get_disk_usage)
if (( DISK_USAGE > DISK_THRESHOLD )); then
    log_message "⚠️ High Disk Usage: ${DISK_USAGE}%"
fi

# System Uptime
UPTIME=$(get_uptime)
log_message "ℹ️ System Uptime: ${UPTIME}"

# Final output
log_message "✅ System health check completed!"

