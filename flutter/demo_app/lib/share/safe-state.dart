import 'package:flutter/material.dart';
import 'package:flutter3/log/logger.dart';

abstract class SafeState<T extends StatefulWidget> extends State<T> {
  bool _isMounted = false;

  @override
  void initState() {
    _isMounted = true;
    super.initState();
  }

  @override
  void dispose() {
    debugPrint('🧹 Disposing: ${this.runtimeType}');
    _isMounted = false;
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    if (!_isMounted) {
      debugPrint('🚨 setState called after dispose: ${this.runtimeType}');
      debugPrint(StackTrace.current.toString());
      Log.e('🚨 setState called after dispose: ${this.runtimeType}');
      return;
    }
    super.setState(fn);
  }
}
