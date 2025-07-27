https://fonts.google.com/icons?icon.query=close
icon

flutter 说明
https://docs.flutter.cn/get-started/codelab/
网页方式运行 指定端口 --web-renderer html
flutter run -d chrome  --web-hostname 0.0.0.0 --web-port 9123

组件=需要后端控制显示的才有必要拆出来。
因为你拆出来的组件，只有你自己觉得当时要用，做多几个界面，可能就乱七八遭了

✅ 一、系统要求
平台	需求
macOS	macOS 10.14+
Xcode	iOS 开发必备（推荐最新版）
Android Studio	Android SDK + 模拟器
Chrome（可选）	Web 支持用
VS Code（可选）	推荐编辑器
Rosetta	M1/M2 架构如需运行 Intel App（如模拟器）

✅ 二、安装 Flutter SDK
1. 下载 Flutter SDK
   从官网下载 Flutter SDK（macOS）：

官网：https://flutter.dev/docs/get-started/install/macos

推荐国内镜像加速：

git clone https://mirrors.tuna.tsinghua.edu.cn/git/flutter-sdk.git -b stable flutter

2. 配置环境变量
# 加入到 .zshrc 或 .bash_profile
export PATH="$PATH:/path/to/flutter/bin"

# 例如
export PATH="$PATH:$HOME/flutter/bin"
source ~/.zshrc  # 或 source ~/.bash_profile
3. 使用国内镜像（推荐，避免卡住）
   export PUB_HOSTED_URL=https://pub.flutter-io.cn
   export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
4. 初始化
   flutter doctor
   ✅ 三、安装依赖工具
   ✅ iOS 环境
   xcode-select --install        # 安装 Xcode 命令行工具
   sudo xcodebuild -license      # 同意许可
   open -a Xcode                 # 第一次打开，安装组件
   安装 CocoaPods（如未安装）：
sudo gem install cocoapods
✅ Android 环境
安装 Android Studio
打开 Android Studio：
安装 Android SDK、AVD Manager、Platform Tools、NDK（可选）
设置 SDK 路径并添加模拟器
环境变量配置（可选）：
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools
✅ Web 支持
安装 Chrome 浏览器。
5. 
✅ 四、创建 Flutter 项目
flutter create my_app
cd my_app
可选择 --platforms=android,ios,web（Flutter 3.0+ 默认支持）：
flutter create --platforms=android,ios,web demo_app

✅ 五、运行 Flutter 项目
启动模拟器（iOS/Android）
open -a Simulator  # iOS 模拟器
flutter emulators  # 查看 Android 模拟器
flutter emulators --launch emulator-id
运行应用
flutter devices      # 查看所有设备（含 web）
flutter run          # 默认运行
flutter run -d chrome  # 运行在 Web（Chrome）
flutter run -d ios     # iOS
flutter run -d android # Android
✅ 六、常用调试命令
flutter doctor -v          # 检查环境
flutter upgrade            # 升级 Flutter
flutter clean              # 清理构建缓存
flutter build ios/android/web  # 构建打包

✅ 七、常见问题
问题	解决方案
卡在 flutter doctor	设置镜像环境变量，检查网络代理
iOS 模拟器不可用	确保 Xcode 打开一次并同意协议
Web 没有设备	安装 Chrome，确认 PATH
安卓模拟器没设备	安装 Android Studio 并添加模拟器
iOS 真机运行失败	需 Apple 开发者账号签名（Xcode 设置）


brew install flutter
brew install dart

flutter --version
brew upgrade flutter

更新依赖

flutter clean
flutter pub cache repair
rm pubspec.lock

flutter pub get
flutter pub upgrade --major-versions

flutter create --platforms=android,ios,web demo_app
cd demo_app
flutter run


flutter run -d chrome  --web-hostname 0.0.0.0 --web-port 9123