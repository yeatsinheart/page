flutter pub get
flutter clean
dart --enable-asserts lib/util/widget_of_path.dart
#--web-renderer html
flutter run -d chrome  --web-hostname 0.0.0.0 --web-port 9123