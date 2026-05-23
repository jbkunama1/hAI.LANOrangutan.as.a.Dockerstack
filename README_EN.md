# 🦧 LAN Orangutan – Docker Stack for Portainer

Production-ready setup for [LAN Orangutan](https://github.com/291-Group/LAN-Orangutan) as a Portainer stack in your home network / LAN.

> **Upstream project:** [291-Group/LAN-Orangutan](https://github.com/291-Group/LAN-Orangutan)  
> Self-hosted network scanner with web UI, device labeling and nmap backend.

---

## 📋 Prerequisites

- Docker + Portainer installed
- Git installed
- Linux host (recommended)
- Root / sudo access

---

## 🚀 Step by Step

### 1. Clone upstream repo & build image

```bash
git clone https://github.com/291-Group/LAN-Orangutan.git
cd LAN-Orangutan
docker build -t lan-orangutan:latest .
```

### 2. Run setup script

```bash
git clone https://github.com/jbkunama1/hAI.LANOrangutan.as.a.Dockerstack.git
cd hAI.LANOrangutan.as.a.Dockerstack
chmod +x setup.sh
sudo ./setup.sh
```

### 3. Adjust config

```bash
nano /opt/lan-orangutan/config/config.ini
```

Important: set `scan_targets` to your subnet, e.g.:
```ini
scan_targets = 192.168.XXX.0/24
```

### 4. Deploy stack in Portainer

- Open Portainer → **Stacks → Add Stack → Web Editor**
- Paste contents of `docker-compose.yml`
- Click **Deploy the stack**

### 5. Open Web UI

```
http://<HOST-IP>:2910
```

---

## ⚙️ Configuration

| Parameter | Default | Description |
|---|---|---|
| `port` | `2910` | Web UI port (must be > 1024) |
| `scan_interval` | `300` | Scan interval in seconds |
| `enable_port_scan` | `true` | Enable port scanning |
| `port_scan_range` | `1-1024,3000-3099,8000-8099` | Ports to scan |
| `scan_targets` | `192.168.XXX.0/24` | Target subnet |
| `retention_days` | `30` | Days to keep offline device history |
| `theme` | `auto` | UI theme: light / dark / auto |

---

## 🔧 Why `network_mode: host`?

nmap requires direct access to the host’s network interface for ARP scans (MAC addresses, vendor detection). With `network_mode: host` the container shares the host network stack.

## 🔧 Why port > 1024?

The container runs as a non-root user (`orangutan`). On Linux, only root processes can bind to ports below 1024. Therefore port `2910` is used instead of `291`.

## 🔧 Why `cap_add: NET_RAW + NET_ADMIN`?

nmap needs raw sockets for ARP scans. These capabilities allow that without running the entire container as root.

---

## 📁 Files

```
.
├── docker-compose.yml      # Portainer Stack
├── config.example.ini      # Config template (placeholders)
├── setup.sh                # Setup script
├── .gitignore              # Protects real config from Git
├── README.md               # German documentation
├── README_EN.md            # This file
└── docs/index.html         # GitHub Pages
```

---

## ⚠️ Security Note

- **Never** commit your real `config.ini` (containing your LAN IP) to a public repo
- `.gitignore` already protects `/opt/` and `config.ini`
- For public access, add an Nginx reverse proxy with Basic Auth in front

---

*Based on [LAN Orangutan](https://github.com/291-Group/LAN-Orangutan) by [291 Group](https://291group.com)*
