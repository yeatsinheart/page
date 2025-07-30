import 'package:flutter/material.dart';

import 'package:flutter3/share/safe-state.dart';
class GridDemo extends StatefulWidget {
  const GridDemo({super.key, params});

  @override
  _GridDemoState createState() => _GridDemoState();
}
// with AutomaticKeepAliveClientMixin
// @override
// bool get wantKeepAlive => true;

class _GridDemoState extends SafeState<GridDemo> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
