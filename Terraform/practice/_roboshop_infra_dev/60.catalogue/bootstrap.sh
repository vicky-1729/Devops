#!/bin/bash

# Set hostname
hostnamectl set-hostname catalogue

# Update system packages
yum update -y

# Install Node.js 18.x
curl -fsSL https://rpm.nodesource.com/setup_18.x | bash -
yum install -y nodejs

# Create application user
useradd -m -d /app roboshop

# Create application directory
mkdir -p /app
chown roboshop:roboshop /app

# Download and setup catalogue service
cd /app
curl -o /tmp/catalogue.zip https://roboshop-builds.s3.amazonaws.com/catalogue.zip
unzip /tmp/catalogue.zip
rm -rf /tmp/catalogue.zip

# Install dependencies
npm install

# Set ownership
chown -R roboshop:roboshop /app

# Create systemd service file
cat > /etc/systemd/system/catalogue.service << 'EOF'
[Unit]
Description=Catalogue Service
After=network.target

[Service]
Type=simple
User=roboshop
WorkingDirectory=/app
ExecStart=/usr/bin/node server.js
Restart=always
RestartSec=10
StandardOutput=journal
StandardError=journal
SyslogIdentifier=catalogue
KillMode=mixed
Environment=MONGO_URL=mongodb://mongodb.roboshop.internal:27017/catalogue

[Install]
WantedBy=multi-user.target
EOF

# Enable and start service
systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue

# Install CloudWatch agent for monitoring
yum install -y amazon-cloudwatch-agent

# Create CloudWatch config
cat > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json << 'EOF'
{
  "metrics": {
    "namespace": "RoboShop/Catalogue",
    "metrics_collected": {
      "cpu": {
        "measurement": [
          "cpu_usage_idle",
          "cpu_usage_iowait",
          "cpu_usage_system",
          "cpu_usage_user"
        ],
        "metrics_collection_interval": 60
      },
      "disk": {
        "measurement": [
          "used_percent"
        ],
        "metrics_collection_interval": 60,
        "resources": [
          "*"
        ]
      },
      "mem": {
        "measurement": [
          "mem_used_percent"
        ],
        "metrics_collection_interval": 60
      }
    }
  },
  "logs": {
    "logs_collected": {
      "files": {
        "collect_list": [
          {
            "file_path": "/var/log/messages",
            "log_group_name": "/roboshop/catalogue/system",
            "log_stream_name": "{instance_id}"
          }
        ]
      }
    }
  }
}
EOF

# Start CloudWatch agent
systemctl start amazon-cloudwatch-agent
systemctl enable amazon-cloudwatch-agent
