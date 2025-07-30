import 'package:flutter/material.dart';

import 'package:flutter3/share/safe-state.dart';
class MainDemo extends StatefulWidget {
  const MainDemo({super.key, params});

  @override
  _MainDemoState createState() => _MainDemoState();
}
// with AutomaticKeepAliveClientMixin
// @override
// bool get wantKeepAlive => true;

class _MainDemoState extends SafeState<MainDemo> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
