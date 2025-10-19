#!/usr/bin/env bash
set -e
sudo systemctl restart fastapi-app
sudo systemctl status fastapi-app --no-pager