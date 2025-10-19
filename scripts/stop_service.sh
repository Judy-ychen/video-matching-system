#!/usr/bin/env bash
set -e
if systemctl is-active --quiet fastapi-app; then
  sudo systemctl stop fastapi-app
fi