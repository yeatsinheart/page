
import 'dart:async';

import 'package:flutter3/app-context.dart';

class AutoBrightness{
  static Timer? _themeTimer;
  static void check() {
    final duration = _checkTheme(); // 执行并获取下次执行时间
    _themeTimer?.cancel();
    _themeTimer = Timer(duration, check);
  }
}
Duration _checkTheme() {
  final now = DateTime.now();
  final hour = now.hour;

  if (hour >= 18 || hour < 6) {
    // 18:00 到 第二天 06:00 使用深色
    if (!AppContext.isDark) {
      AppContext.setStyleDark();
    }
  } else {
    // 06:00 到 18:00 使用浅色
    if (AppContext.isDark) {
      AppContext.setStyleLight();
    }
  }
  // 计算下次切换时间
  final nextChange = _getNextChangeTime(now);
  return nextChange.difference(now);
}
/// 获取下一个切换时间（06:00 或 18:00）
DateTime _getNextChangeTime(DateTime now) {
  final today6 = DateTime(now.year, now.month, now.day, 6);
  final today18 = DateTime(now.year, now.month, now.day, 18);

  if (now.isBefore(today6)) {
    return today6;
  } else if (now.isBefore(today18)) {
    return today18;
  } else {
    // 超过 18 点，下一次切换是明天的 06:00
    return today6.add(Duration(days: 1));
  }
}