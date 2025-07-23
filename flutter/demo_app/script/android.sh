#!/bin/bash

APK_PATH="build/app/outputs/flutter-apk/app-release.apk"
OUT_APK="output-channel.apk"
TMP_DIR="tmp_apk"
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

# 1. 解压 APK
rm -rf $TMP_DIR
mkdir -p $TMP_DIR
unzip -q $APK_PATH -d $TMP_DIR

# 2. 替换配置文件
mkdir -p $TMP_DIR/assets/config/
cp $CONFIG_FILE $TMP_DIR/assets/config/default_config.json

# 3. 重新打包 APK（不签名）
cd $TMP_DIR
zip -qr ../$OUT_APK ./*
cd ..

# 4. 签名（需要 keystore）
jarsigner -verbose -keystore your_keystore.jks -storepass yourpass $OUT_APK your_alias
