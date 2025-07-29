main() {
  /// 量产替换配置 + 重新签名
  /// 解决方案总览
  // 平台	实现方式
  // iOS（IPA）	解压 .ipa → 修改 Payload/YourApp.app/config.json 或资源文件 → 重新签名（codesign） → 打包成新 .ipa
  // Android（APK）	解压 .apk → 修改 assets/config.json 或 res/raw/xxx → 重新签名（apksigner） → 重新 zipalign → 新 APK
  // Flutter Web	修改 build/web/assets/config.json → 每个环境生成不同的 ZIP / 部署目录
  ///
  ///
  ///
  /// 安卓
  /// 打包完后直接修改 APK 内容（无需重新编译）
  // APK 本质是一个 zip 文件。
  //
  // 你可以直接用工具（如 unzip, apktool, 脚本）替换 assets/config/default_config.json：
  //
  // unzip app-release.apk -d temp
  // cp new_config.json temp/assets/config/default_config.json
  // cd temp && zip -r ../new_app.apk .
  // ⚠️ 重新打包后 APK 签名会失效，需要重新签名：
  //
  // jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore my-release-key.jks new_app.apk alias_name

  /// web
  /// Web：最灵活，可在打包后随时替换配置
  // ✅ 方式 1：放在 assets/config/config.json
  // 只要不加 hash，可直接替换打包产物：
  //
  // flutter build web 后会产出：build/web/assets/config/config.json
  //
  // 在部署服务器时直接替换这个文件即可

  /// iOS IPA 渠道包生成流程详解
  // 以 iOS 为例，核心流程如下：
  //
  // ✅ 1. 解压 .ipa（其实是个 ZIP 文件）
  // bash
  // 复制
  // 编辑
  // unzip MyApp.ipa -d temp_ipa
  // 你会得到结构如下：
  //
  // arduino
  // 复制
  // 编辑
  // temp_ipa/
  // └── Payload/
  //     └── MyApp.app/
  //         ├── Frameworks/
  //         ├── Assets.car
  //         ├── config.json  ← ✅我们要替换的配置
  //         └── ...
  // ✅ 2. 替换配置文件
  // 假设你要注入环境配置，比如：
  //
  // json
  // 复制
  // 编辑
  // {
  //   "gateway": "https://gw1.example.com",
  //   "env": "release"
  // }
  // 你可以批量写入：
  //
  // bash
  // 复制
  // 编辑
  // cp my_config_env1.json temp_ipa/Payload/MyApp.app/config.json
  // 或者用脚本动态写入。
  //
  // ✅ 3. 重新签名 App（必须）
  // iOS 的 App 每次修改都必须重签名，否则无法安装。
  //
  // bash
  // 复制
  // 编辑
  // codesign -f -s "iPhone Distribution: XXX" --entitlements entitlements.plist temp_ipa/Payload/MyApp.app
  // 确保你有：
  //
  // 有效的 .p12 证书
  //
  // .mobileprovision 文件
  //
  // entitlements.plist（可以从原始包提取）
  //
  // ✅ 4. 重新打包为 .ipa
  // bash
  // 复制
  // 编辑
  // cd temp_ipa
  // zip -r ../MyApp-gw1.ipa .
  // 就得到了新的 .ipa 文件（带你的 config.json）。

  /// ✅ Android（APK）类似操作
  // 用 apktool 解包 APK：
  //
  // bash
  // 复制
  // 编辑
  // apktool d MyApp.apk -o MyApp_decoded
  // 替换 assets/config.json 或 res/raw/...
  //
  // 回编：
  //
  // bash
  // 复制
  // 编辑
  // apktool b MyApp_decoded -o MyApp-gw1-unsigned.apk
  // 签名并 zipalign：
  //
  // bash
  // 复制
  // 编辑
  // apksigner sign --ks my-release-key.jks --out MyApp-gw1.apk MyApp-gw1-unsigned.apk
}
