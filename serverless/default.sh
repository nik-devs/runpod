#!/bin/bash
# This file will be sourced in init.sh
# Namespace functions with provisioning_

# https://raw.githubusercontent.com/ai-dock/stable-diffusion-webui/main/config/provisioning/default.sh

# Установка пакета runpod
pip install runpod

# Загрузка файла serverless-api.py с GitHub
curl -o serverless-api.py https://raw.githubusercontent.com/dscapes/runpod/refs/heads/main/serverless/serverless-api.py

# Запуск serverless-api.py
python serverless-api.py
