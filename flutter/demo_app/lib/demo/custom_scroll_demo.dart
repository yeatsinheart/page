import 'package:flutter/material.dart';

class CustomScrollDemo extends StatefulWidget {
  const CustomScrollDemo({super.key, params});

  @override
  _CustomScrollDemoState createState() => _CustomScrollDemoState();
}
// with AutomaticKeepAliveClientMixin
// @override
// bool get wantKeepAlive => true;

class _CustomScrollDemoState extends State<CustomScrollDemo> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
