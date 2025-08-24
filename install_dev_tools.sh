#!/usr/bin/env bash
set -e

sudo apt-get update -y

# Docker
if ! command -v docker >/dev/null 2>&1; then
  sudo apt-get install -y docker.io
  sudo systemctl enable --now docker
fi

# Docker Compose
if ! (docker compose version >/dev/null 2>&1 || command -v docker-compose >/dev/null 2>&1); then
  sudo apt-get install -y docker-compose-plugin
fi

# Python
if ! command -v python3 >/dev/null 2>&1; then
  sudo apt-get install -y python3
fi

# pip
if ! command -v pip3 >/dev/null 2>&1; then
  sudo apt-get install -y python3-pip
fi

# Django
if ! python3 -m django --version >/dev/null 2>&1; then
  pip3 install --user Django
fi