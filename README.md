# 🖥️ System Health Monitor - Bash Script

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Platform](https://img.shields.io/badge/platform-Linux-blue.svg)
![Language](https://img.shields.io/badge/language-Bash-yellow.svg)

A simple yet powerful Bash script that helps you monitor your Linux system's vital statistics like CPU usage, memory consumption, disk space, uptime, and network usage. It logs data, sends alerts via email, and notifies you through desktop popups.

---

## 📌 What is this?

This is a lightweight Bash script designed to:

- Monitor your system's **CPU**, **Memory**, **Disk**, **Network**, and **Uptime**
- Log system health details to a file (`system_health.log`)
- Send alerts when resource usage exceeds safe thresholds:
  - 📧 Email alerts
  - 🖥️ GUI desktop notifications (if supported)

---

## ❓ Why use this?

This script is useful for:

- Keeping an eye on your system performance
- Being alerted when resource usage is high
- Automating system health checks
- Saving time compared to opening tools manually like `top`, `free`, or `df`

Perfect for:
- Developers
- System administrators
- Power users

---

## ⚙️ Requirements

Ensure the following tools are installed on your Linux system:

| Tool         | Purpose                        | Install on Ubuntu/Debian                 |
|--------------|--------------------------------|------------------------------------------|
| `mail`       | To send email alerts            | `sudo apt install mailutils`             |
| `notify-send`| For GUI popup notifications     | `sudo apt install libnotify-bin`         |
| `ifstat`     | For network monitoring          | `sudo apt install ifstat`                |
| `awk`, `cut`, `df`, `uptime`, `top`, `free` | Default Linux tools                     | Usually pre-installed                    |

---

## 🚀 How to Use

### 1. Download the Script

Save the script to your desired location (e.g., `~/system_health.sh`).

### 2. Make it Executable

```bash
chmod +x ~/system_health.sh
```

### 3. Configure Your Email

Open the script and update the email address:

```bash
EMAIL="you@example.com"  # Replace with your email
```

### 4. Run the Script Manually

```bash
./system_health.sh
```

### 5. (Optional) Schedule It with Cron

To run the script automatically every 5 minutes:

```bash
crontab -e
```
Add this line at the end:

```bash
*/5 * * * * /full/path/to/system_health.sh
```

---

## �� Output Details

- ✅ Logs are saved to: `~/system_health.log`
- ✅ Alerts are sent via email
- ✅ Popups are shown on the desktop (if GUI and `notify-send` is available)

---

## 🛠️ Customization

You can change the alert thresholds by editing these lines in the script:

```bash
CPU_THRESHOLD=80      # CPU alert if usage > 80%
MEM_THRESHOLD=80      # Memory alert if usage > 80%
DISK_THRESHOLD=90     # Disk alert if usage > 90%
```

You can also:
- Modify or add more alert types (e.g., Slack, Telegram)
- Extend monitoring for:
  - Temperature
  - Battery
  - Specific processes or services

---

## 📸 Sample Output

**Log File Example:**
```
Sat Apr  5 12:00:00 UTC 2025: ✅ CPU Usage: 42%
Sat Apr  5 12:00:00 UTC 2025: ✅ Memory Usage: 37%
Sat Apr  5 12:00:00 UTC 2025: ⚠️ High Disk Usage: 91%
Sat Apr  5 12:00:00 UTC 2025: ℹ️ System Uptime: up 1 hour, 5 minutes
Sat Apr  5 12:00:00 UTC 2025: 🌐 Network Usage: RX: 205.00 KB/s | TX: 110.00 KB/s
```

---

## 📬 Need Help?

If you face issues or want to enhance the script further, feel free to open a pull request or raise an issue.

---

## ✅ Summary

- 📊 Monitors key system metrics
- 🔔 Sends alerts and logs data
- 🧰 Requires minimal dependencies
- 🛡️ Great for automating system checks

Give your system some care — run the **System Health Monitor** and stay informed! 💻


