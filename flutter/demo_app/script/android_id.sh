#!/bin/bash

set -e

APK_PATH="app-release.apk"
TMP_DIR="tmp_apk"
OUT_APK="app-release-modified.apk"

# 新包名，比如 com.new.package
NEW_PACKAGE="com.new.package"

# keystore配置
KEYSTORE="your.keystore"
KEY_ALIAS="your_alias"
KEYSTORE_PASS="yourpass"
KEY_PASS="yourpass"

# 1. 清理旧目录
rm -rf $TMP_DIR
mkdir -p $TMP_DIR

# 2. 反编译 APK（使用 apktool）
echo "🔧 解包 APK..."
apktool d -f "$APK_PATH" -o "$TMP_DIR"

# 3. 修改 AndroidManifest.xml 中的包名
echo "✏️ 修改 AndroidManifest.xml 包名..."
sed -i.bak "s/package=\"[^\"]*\"/package=\"$NEW_PACKAGE\"/" "$TMP_DIR/AndroidManifest.xml"

# 4. 修改 smali 目录的包名路径和文件内容
OLD_PACKAGE=$(grep -oP 'package="\K[^"]+' "$TMP_DIR/AndroidManifest.xml.bak" | head -1)
echo "原包名: $OLD_PACKAGE"
echo "新包名: $NEW_PACKAGE"

# 将包名转成路径形式
OLD_PATH=$(echo $OLD_PACKAGE | tr '.' '/')
NEW_PATH=$(echo $NEW_PACKAGE | tr '.' '/')

echo "旧路径: $OLD_PATH"
echo "新路径: $NEW_PATH"

SMALI_DIR="$TMP_DIR/smali"
SMALI_CLASSES2_DIR="$TMP_DIR/smali_classes2"

# 4.1 重命名smali文件夹路径
if [ -d "$SMALI_DIR/$OLD_PATH" ]; then
  mkdir -p "$(dirname "$SMALI_DIR/$NEW_PATH")"
  mv "$SMALI_DIR/$OLD_PATH" "$SMALI_DIR/$NEW_PATH"
fi

if [ -d "$SMALI_CLASSES2_DIR/$OLD_PATH" ]; then
  mkdir -p "$(dirname "$SMALI_CLASSES2_DIR/$NEW_PATH")"
  mv "$SMALI_CLASSES2_DIR/$OLD_PATH" "$SMALI_CLASSES2_DIR/$NEW_PATH"
fi

# 4.2 替换 smali 文件中的包名引用
echo "🔄 替换 smali 文件中的包名..."

find "$SMALI_DIR" -type f -name "*.smali" -exec sed -i.bak "s/${OLD_PACKAGE//./\\.}/${NEW_PACKAGE//./\\.}/g" {} +

if [ -d "$SMALI_CLASSES2_DIR" ]; then
  find "$SMALI_CLASSES2_DIR" -type f -name "*.smali" -exec sed -i.bak "s/${OLD_PACKAGE//./\\.}/${NEW_PACKAGE//./\\.}/g" {} +
fi

# 5. 清理备份文件
find "$TMP_DIR" -type f -name "*.bak" -delete

# 6. 重新打包 APK
echo "📦 重新打包 APK..."
apktool b "$TMP_DIR" -o "$OUT_APK"

# 7. 签名 APK
echo "🔐 签名 APK..."
apksigner sign --ks "$KEYSTORE" --ks-key-alias "$KEY_ALIAS" --ks-pass pass:"$KEYSTORE_PASS" --key-pass pass:"$KEY_PASS" --out "signed-$OUT_APK" "$OUT_APK"

echo "🎉 完成！生成文件: signed-$OUT_APK"
