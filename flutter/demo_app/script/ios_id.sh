# 描述文件里包含对应的 Bundle ID
  #这才是关键点！
  #描述文件（Provisioning Profile）绑定了你的 App ID（Bundle ID）或通配符 ID（Wildcard App ID）。
  #你要签名的包的 Bundle ID 必须在这个描述文件的允许范围内。
  #如果描述文件绑定的是具体的 Bundle ID（比如 com.example.myapp），那么只能签这个包名。
  #如果是通配符描述文件（如 com.example.*），则包名必须匹配这个模式，com.example.anything 都可以。
  #重签名时必须用匹配包名的描述文件，否则安装会失败。
  #基于通配符描述文件，快速替换 iOS IPA 包内 Bundle ID 并递归重签名的 Bash 脚本示例。



#!/bin/bash

set -e

IPA_PATH="old.ipa"
NEW_BUNDLE_ID="com.test.newid" # 必须符合mobileprovision中的id通配符
PROVISION_PATH="path/to/wildcard.mobileprovision"
CERT_NAME="iPhone Developer: Your Name (XXXXXXXXXX)"
OUT_IPA="new_signed.ipa"
TMP_DIR="tmp_ipa"

# 清理
rm -rf "$TMP_DIR"
mkdir "$TMP_DIR"

# 1. 解压 IPA
unzip -q "$IPA_PATH" -d "$TMP_DIR"

# 2. 找到 .app 目录
APP_PATH=$(find "$TMP_DIR/Payload" -name "*.app" | head -n 1)
if [ -z "$APP_PATH" ]; then
  echo "❌ 找不到 .app 文件"
  exit 1
fi
echo "找到App路径: $APP_PATH"

# 3. 替换 Bundle ID
/usr/libexec/PlistBuddy -c "Set :CFBundleIdentifier $NEW_BUNDLE_ID" "$APP_PATH/Info.plist"
echo "✔ 修改 Bundle ID 为 $NEW_BUNDLE_ID"

# 4. 替换描述文件
cp "$PROVISION_PATH" "$APP_PATH/embedded.mobileprovision"
echo "✔ 替换描述文件"

# 5. 提取 Entitlements.plist
security cms -D -i "$APP_PATH/embedded.mobileprovision" > temp.plist
/usr/libexec/PlistBuddy -x -c 'Print:Entitlements' temp.plist > entitlements.plist
rm temp.plist

# 6. 递归重签名函数
codesign_recurse() {
  local target="$1"
  if [ -d "$target" ]; then
    for f in "$target"/*; do
      codesign_recurse "$f"
    done
  fi

  # 对可执行文件或 dylib 等签名
  if [[ -f "$target" ]]; then
    filetype=$(file "$target")
    if [[ "$filetype" == *"Mach-O"* ]] || [[ "$target" == *.framework/* ]]; then
      echo "签名: $target"
      codesign -f -s "$CERT_NAME" --entitlements entitlements.plist "$target"
    fi
  fi
}

# 7. 重签主程序和所有子文件
codesign_recurse "$APP_PATH"

# 8. 重新打包 IPA
cd "$TMP_DIR"
zip -qr "../$OUT_IPA" Payload
cd -

echo "✔ 新IPA已生成: $OUT_IPA"

# 清理
rm entitlements.plist
rm -rf "$TMP_DIR"


