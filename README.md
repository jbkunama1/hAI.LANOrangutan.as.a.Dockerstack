# 🦧 LAN Orangutan – Docker Stack für Portainer

> **Original Source:** [291-Group/LAN-Orangutan](https://github.com/291-Group/LAN-Orangutan)  
> Self-hosted Netzwerk-Scanner mit Web-UI, Device-Labeling und nmap-Backend.

Produktiv-Setup für [LAN Orangutan](https://github.com/291-Group/LAN-Orangutan) als Portainer-Stack im Heimnetz/LAN.

---

## 📋 Voraussetzungen

- Docker + Portainer installiert
- Git installiert
- Linux-Host (empfohlen)
- Root-/sudo-Zugriff

---

## 🚀 Schritt-für-Schritt

### 1. Upstream-Repo klonen & Image bauen

```bash
git clone https://github.com/291-Group/LAN-Orangutan.git
cd LAN-Orangutan
docker build -t lan-orangutan:latest .
```

### 2. Setup-Script ausführen

```bash
git clone https://github.com/jbkunama1/hAI.LANOrangutan.as.a.Dockerstack.git
cd hAI.LANOrangutan.as.a.Dockerstack
chmod +x setup.sh
sudo ./setup.sh
```

### 3. Config anpassen

```bash
nano /opt/lan-orangutan/config/config.ini
```

Wichtig: `scan_targets` auf dein Subnetz setzen, z.B.:
```ini
scan_targets = 192.168.XXX.0/24
```

### 4. Stack in Portainer deployen

- Portainer öffnen → **Stacks → Add Stack → Web Editor**
- Inhalt von `docker-compose.yml` einfügen
- **Deploy the stack** klicken

### 5. Web-UI aufrufen

```
http://<HOST-IP>:2910
```

---

## ⚙️ Konfiguration

| Parameter | Standard | Beschreibung |
|---|---|---|
| `port` | `2910` | Web-UI Port (muss > 1024 sein) |
| `scan_interval` | `300` | Scan-Intervall in Sekunden |
| `enable_port_scan` | `true` | Port-Scan aktivieren |
| `port_scan_range` | `1-1024,3000-3099,8000-8099` | Zu scannende Ports |
| `scan_targets` | `192.168.XXX.0/24` | Zu scannendes Subnetz |
| `retention_days` | `30` | Tage für Offline-Geräte-Historie |
| `theme` | `auto` | UI-Theme: light / dark / auto |

---

## 🔧 Warum `network_mode: host`?

nmap benötigt für ARP-Scans (MAC-Adressen, Hersteller-Erkennung) direkten Zugriff auf das Netzwerk-Interface des Hosts. Mit `network_mode: host` sieht der Container dasselbe Netzwerk wie der Host.

## 🔧 Warum Port > 1024?

Der Container läuft als non-root User (`orangutan`). Unter Linux dürfen nur root-Prozesse Ports unter 1024 binden. Daher wird Port `2910` statt `291` verwendet.

## 🔧 Warum `cap_add: NET_RAW + NET_ADMIN`?

nmap braucht Raw-Sockets für ARP-Scans. Diese Capabilities erlauben das, ohne den Container komplett als root laufen zu lassen.

---

## 📁 Dateien

```
.
├── docker-compose.yml      # Portainer Stack
├── config.example.ini      # Config-Vorlage (Platzhalter)
├── setup.sh                # Setup-Script
├── .gitignore              # Schützt echte Config vor Git
└── README.md               # Diese Anleitung
```

---

## ⚠️ Sicherheitshinweis

- Die **echte `config.ini`** (mit deiner LAN-IP) niemals in ein öffentliches Repo einchecken
- `.gitignore` schützt `/opt/` und `config.ini` bereits
- Für öffentlichen Zugriff einen Nginx Reverse Proxy mit Basic Auth vorschalten

---

*Basierend auf [LAN Orangutan](https://github.com/291-Group/LAN-Orangutan) von [291 Group](https://291group.com)*
