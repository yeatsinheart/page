import 'package:flutter/material.dart';
import 'package:flutter3/demo/tab_demo.dart';

import 'custom_scroll_demo.dart';
import 'nest_scroll_demo.dart';

class MainDemo extends StatefulWidget {
  const MainDemo({super.key, params});

  @override
  _MainDemoState createState() => _MainDemoState();
}
// with AutomaticKeepAliveClientMixin
// @override
// bool get wantKeepAlive => true;

class _MainDemoState extends State<MainDemo> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return NestScrollDemo();
  }
}
