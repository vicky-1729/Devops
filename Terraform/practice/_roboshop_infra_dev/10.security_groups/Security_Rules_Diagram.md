# 🔐 Security Group Rules - Port Access Diagram

## Simple Port Access Flow

```
🌐 INTERNET
    ↓
┌─────────────────────────────────────────────────────────────────┐
│                         FROM INTERNET                           │
├─────────────────────────────────────────────────────────────────┤
│ Port 22 (SSH)     → Frontend SG                                │
│ Port 22 (SSH)     → Bastion SG                                 │
│ Port 22 (SSH)     → VPN SG                                     │
│ Port 443 (HTTPS)  → VPN SG                                     │
│ Port 943 (Admin)  → VPN SG                                     │
│ Port 953 (Client) → VPN SG                                     │
│ Port 1194 (VPN)   → VPN SG                                     │
└─────────────────────────────────────────────────────────────────┘
    ↓
┌─────────────────────────────────────────────────────────────────┐
│                      FROM BASTION HOST                          │
├─────────────────────────────────────────────────────────────────┤
│ Port 80 (HTTP)    → Backend ALB SG                             │
│ Port 22 (SSH)     → MongoDB SG                                 │
│ Port 27017 (DB)   → MongoDB SG                                 │
│ Port 22 (SSH)     → MySQL SG                                   │
│ Port 3306 (DB)    → MySQL SG                                   │
│ Port 22 (SSH)     → Redis SG                                   │
│ Port 6379 (Cache) → Redis SG                                   │
│ Port 22 (SSH)     → RabbitMQ SG                               │
│ Port 5672 (Queue) → RabbitMQ SG                               │
└─────────────────────────────────────────────────────────────────┘
    ↓
┌─────────────────────────────────────────────────────────────────┐
│                        FROM VPN SERVER                          │
├─────────────────────────────────────────────────────────────────┤
│ Port 80 (HTTP)    → Backend ALB SG                             │
│ Port 22 (SSH)     → MongoDB SG                                 │
│ Port 27017 (DB)   → MongoDB SG                                 │
│ Port 22 (SSH)     → MySQL SG                                   │
│ Port 3306 (DB)    → MySQL SG                                   │
│ Port 22 (SSH)     → Redis SG                                   │
│ Port 6379 (Cache) → Redis SG                                   │
│ Port 22 (SSH)     → RabbitMQ SG                               │
│ Port 5672 (Queue) → RabbitMQ SG                               │
└─────────────────────────────────────────────────────────────────┘
```

## 📊 Port Access Table

| **FROM** | **TO** | **PORT** | **PROTOCOL** | **PURPOSE** |
|----------|--------|----------|--------------|-------------|
| **Internet** | Frontend | 22 | TCP | SSH Access |
| **Internet** | Bastion | 22 | TCP | SSH Jump Server |
| **Internet** | VPN | 22 | TCP | SSH Management |
| **Internet** | VPN | 443 | TCP | HTTPS Web Interface |
| **Internet** | VPN | 943 | TCP | Admin Web UI |
| **Internet** | VPN | 953 | TCP | Client Web UI |
| **Internet** | VPN | 1194 | UDP | VPN Tunnel |
| **Bastion** | Backend ALB | 80 | TCP | HTTP Access |
| **Bastion** | MongoDB | 22 | TCP | SSH Access |
| **Bastion** | MongoDB | 27017 | TCP | Database Access |
| **Bastion** | MySQL | 22 | TCP | SSH Access |
| **Bastion** | MySQL | 3306 | TCP | Database Access |
| **Bastion** | Redis | 22 | TCP | SSH Access |
| **Bastion** | Redis | 6379 | TCP | Cache Access |
| **Bastion** | RabbitMQ | 22 | TCP | SSH Access |
| **Bastion** | RabbitMQ | 5672 | TCP | Message Queue |
| **VPN** | Backend ALB | 80 | TCP | HTTP Access |
| **VPN** | MongoDB | 22 | TCP | SSH Access |
| **VPN** | MongoDB | 27017 | TCP | Database Access |
| **VPN** | MySQL | 22 | TCP | SSH Access |
| **VPN** | MySQL | 3306 | TCP | Database Access |
| **VPN** | Redis | 22 | TCP | SSH Access |
| **VPN** | Redis | 6379 | TCP | Cache Access |
| **VPN** | RabbitMQ | 22 | TCP | SSH Access |
| **VPN** | RabbitMQ | 5672 | TCP | Message Queue |

## 🎯 Key Points:

1. **Internet Access**: Only SSH, VPN, and web interfaces are accessible from internet
2. **Bastion & VPN**: Both have identical access to all database services
3. **Database Access**: All databases allow both SSH (22) and their service ports
4. **Security**: No direct database access from internet - only through Bastion or VPN

## 🔒 Security Layers:

```
Internet → [Bastion/VPN] → [Backend ALB] → [Databases]
   ↓           ↓              ↓              ↓
Public      Gateway       Internal       Private
Access      Layer         Load           Storage
           (SSH/VPN)      Balancer       Layer
```
