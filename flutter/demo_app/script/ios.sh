#!/bin/bash

IPA_PATH="build/ios/ipa/app.ipa"
OUT_IPA="output-channel.ipa"
TMP_DIR="tmp_ipa"
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

# 1. 解压 IPA
rm -rf $TMP_DIR
mkdir -p $TMP_DIR
unzip -q $IPA_PATH -d $TMP_DIR

# 2. 替换 config
APP_DIR=$(find $TMP_DIR/Payload -name "*.app")
cp $CONFIG_FILE $APP_DIR/config.json

# 3. 重新打包 IPA（不签名）
cd $TMP_DIR
zip -qr ../$OUT_IPA ./*
cd ..

# 4. 可选：使用 `xcodebuild -exportArchive` 或第三方工具重新签名
