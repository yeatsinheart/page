import 'package:flutter/material.dart';

class Demo extends StatefulWidget {
  const Demo({super.key, params});

  @override
  _DemoState createState() => _DemoState();
}
// with AutomaticKeepAliveClientMixin
// @override
// bool get wantKeepAlive => true;

class _DemoState extends State<Demo> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
