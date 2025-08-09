import 'package:flutter/material.dart';


import 'custom_scroll_demo.dart';

class Demo extends StatefulWidget {
  final params;
  const Demo({super.key, this.params});

  @override
  _State createState() => _State();
}
// with AutomaticKeepAliveClientMixin
// @override
// bool get wantKeepAlive => true;

class _State extends State<Demo> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return CustomScrollDemo();
  }
}
