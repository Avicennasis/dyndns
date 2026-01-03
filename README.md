# dyndns

A lightweight Dynamic DNS solution for BIND9 that automatically updates DNS records when your home IP address changes. Perfect for self-hosted servers behind dynamic IP connections.

## Features

- **Automatic IP Detection**: Retrieves your external IP from public services
- **Change Detection**: Only updates when your IP actually changes
- **IP Validation**: Validates IP format before applying changes
- **Backup Support**: Optional backups before modifying zone files
- **Error Handling**: Comprehensive error checking and logging
- **Secure Transfer**: Uses SSH/rsync for secure file transfers

## How It Works

```
┌─────────────────┐         ┌─────────────────┐
│  Home Client    │  rsync  │   DNS Server    │
│  (dyndns.sh)    │ ──────► │ (dyndnsupdate)  │
│                 │   SSH   │                 │
│ Fetches IP      │         │ Updates BIND9   │
└─────────────────┘         └─────────────────┘
```

1. **Client** (`dyndns.sh`): Runs on your home machine, fetches your external IP, and syncs it to the DNS server
2. **Server** (`dyndnsupdate.sh`): Runs on your DNS server, reads the IP file, updates the zone, and reloads BIND9

## Prerequisites

### Client Machine
- `curl` - for fetching external IP
- `rsync` - for secure file transfer
- SSH key authentication configured for passwordless access to the server

### DNS Server
- BIND9 installed and configured
- `rndc` utility configured
- Proper permissions to modify zone files

## Installation

### Client Setup

1. Clone this repository:
   ```bash
   git clone https://github.com/Avicennasis/dyndns.git
   cd dyndns
   ```

2. Edit `dyndns.sh` and configure:
   ```bash
   REMOTE_USER="your_username"
   REMOTE_HOST="your.dns.server"
   REMOTE_PATH="/etc/bind/zones"
   ```

3. Set up SSH key authentication:
   ```bash
   ssh-keygen -t ed25519
   ssh-copy-id your_username@your.dns.server
   ```

4. Make the script executable and add to cron:
   ```bash
   chmod +x dyndns.sh
   crontab -e
   # Add: */5 * * * * /path/to/dyndns.sh >> /var/log/dyndns.log 2>&1
   ```

### Server Setup

1. Copy files to your DNS server:
   ```bash
   cp dyndnsupdate.sh /usr/local/bin/
   cp HOME.example /etc/bind/zones/
   ```

2. Edit `dyndnsupdate.sh` and configure:
   ```bash
   ZONES_DIR="/etc/bind/zones"
   ZONE_FILE="db.yourdomain.com"
   ```

3. Edit `HOME.example` to match your domain configuration

4. Make the script executable and add to cron:
   ```bash
   chmod +x /usr/local/bin/dyndnsupdate.sh
   crontab -e
   # Add: */5 * * * * /usr/local/bin/dyndnsupdate.sh >> /var/log/dyndnsupdate.log 2>&1
   ```

## Zone Template

The `HOME.example` file is a BIND9 zone template. Replace:
- `HOST.COM` with your actual domain
- `SERVERIP` with your server's static IP  
- `HOMEREPLACEME` is automatically replaced with your dynamic home IP

## File Structure

```
dyndns/
├── dyndns.sh          # Client script (runs at home)
├── dyndnsupdate.sh    # Server script (runs on DNS server)
├── HOME.example       # Zone file template
├── LICENSE            # MIT License
└── README.md          # This file
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Credits

**Author:** Léon "Avic" Simmons ([@Avicennasis](https://github.com/Avicennasis))
