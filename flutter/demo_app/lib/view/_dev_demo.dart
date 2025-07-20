import 'package:flutter/material.dart';
import 'package:flutter3/util/context.dart';
class DevDemo extends StatefulWidget {
  @override
  _DevDemoState createState() => _DevDemoState();
}
// with AutomaticKeepAliveClientMixin
// @override
// bool get wantKeepAlive => true;

class _DevDemoState extends State<DevDemo>  {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    //_scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}