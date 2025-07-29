import 'package:flutter/material.dart';

class AppContext {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>(debugLabel: 'Rex');

  static BuildContext get context {
    final ctx = navigatorKey.currentState?.context;
    if (ctx == null) throw Exception('GlobalContext.context is null');
    return ctx;
  }
}
