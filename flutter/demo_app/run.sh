cd /Users/apple/IdeaProjects/page/flutter/demo_app

flutter clean
flutter pub upgrade --major-versions
flutter pub get

#dart --enable-asserts lib/util/widget_of_path.dart
dart  lib/util/widget_of_path.dart
#--web-renderer html
#flutter run -d chrome  --web-hostname 0.0.0.0 --web-port 9123