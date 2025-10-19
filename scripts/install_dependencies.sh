#!/usr/bin/env bash
set -e

APP_DIR="/opt/video-matching-system"
VENV_DIR="${APP_DIR}/venv"
SERVICE_FILE="/etc/systemd/system/fastapi-app.service"

# install dependencies
sudo yum update -y
sudo yum install -y python3
python3 -m venv /opt/video-matching-system/venv

# 创建虚拟环境
python3 -m venv ${VENV_DIR}
source ${VENV_DIR}/bin/activate
pip install --upgrade pip
pip install -r ${APP_DIR}/requirements.txt
deactivate

# 创建 systemd 服务文件
cat > ${SERVICE_FILE} <<EOF
[Unit]
Description=FastAPI Hello World Service
After=network.target

[Service]
User=ec2-user
WorkingDirectory=${APP_DIR}
Environment="PATH=${VENV_DIR}/bin"
ExecStart=${VENV_DIR}/bin/uvicorn src.main:app --host 0.0.0.0 --port 8000
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# 启用服务
sudo systemctl daemon-reload
sudo systemctl enable fastapi-app
