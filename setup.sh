#!/bin/bash
# =============================================================
# LAN Orangutan – Setup Script
# Legt Verzeichnisse an und schreibt die Config-Datei.
# Aufruf: sudo ./setup.sh
# =============================================================

set -e

CONFIG_PATH="/opt/lan-orangutan/config/config.ini"

# Verzeichnisse anlegen
mkdir -p "$(dirname "$CONFIG_PATH")"

# --- Config schreiben ---
cat > "$CONFIG_PATH" << 'EOF'
[server]
port = 2910
bind_address = 0.0.0.0
enable_api = true

[scanning]
scan_interval = 300
min_scan_interval = 30
enable_port_scan = true
port_scan_range = 1-1024,3000-3099,8000-8099

# Passe das Subnetz an dein LAN an:
scan_targets = 192.168.XXX.0/24

[storage]
max_devices = 1000
retention_days = 30
# data_dir = /var/lib/lan-orangutan

[tailscale]
# enable = true
# auto_detect = true

[ui]
theme = auto
EOF

echo ""
echo "✅ Config geschrieben nach: $CONFIG_PATH"
echo ""
echo "📝 Bitte jetzt scan_targets in der Config anpassen:"
echo "   nano $CONFIG_PATH"
echo ""
echo "🐳 Danach Docker-Image bauen:"
echo "   git clone https://github.com/291-Group/LAN-Orangutan.git"
echo "   cd LAN-Orangutan && docker build -t lan-orangutan:latest ."
echo ""
echo "🚀 Stack in Portainer deployen und aufrufen:"
echo "   http://$(hostname -I | awk '{print $1}'):2910"
