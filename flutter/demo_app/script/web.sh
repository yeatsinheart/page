#!/bin/bash

WEB_BUILD="build/web"
CONFIG_FILE="custom_config.json"

# 请求地址
URL="https://api.example.com/data"
# 请求参数（JSON 格式）
JSON_DATA='{
  "username": "zane",
  "password": "123456"
}'
# 发送请求并写入文件  GET: curl -s -G "$URL" \
curl -s -X POST "$URL" \
  -H "Content-Type: application/json" \
  -d "$JSON_DATA" \
  -o "CONFIG_FILE"

# 覆盖配置文件
cp $CONFIG_FILE $WEB_BUILD/assets/config/default_config.json

# 可选：注入 JS 变量（适配 index.html）
# sed -i '' "s|__CONFIG__|$(cat $CONFIG_FILE)|g" $WEB_BUILD/index.html
