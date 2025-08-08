import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter3/app-route.dart'; // 你自己的路由管理器

enum SnapEdge { left, right, top, bottom }

class GameHelper extends StatefulWidget {
  const GameHelper({super.key});

  @override
  State<GameHelper> createState() => _GameHelperState();
}

class _GameHelperState extends State<GameHelper> {
  double top = 100;
  double left = 300;

  SnapEdge _edge = SnapEdge.left;

  bool expanded = true;
  Timer? _autoCollapseTimer;

  final double buttonSize = 56;
  final Duration autoCollapseDuration = Duration(seconds: 3);

  @override
  void initState() {
    super.initState();
    _startAutoCollapseTimer();
  }
  @override
  void dispose() {
    _autoCollapseTimer?.cancel();
    super.dispose();
  }

  void _startAutoCollapseTimer() {
    _autoCollapseTimer?.cancel();
    _autoCollapseTimer = Timer(autoCollapseDuration, () {
      setState(() {
        expanded = false;
        _snapToEdge();
      });
    });
  }

  void _snapToEdge() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final double distanceLeft = left;
    final double distanceRight = screenWidth - left - buttonSize;
    final double distanceTop = top;
    final double distanceBottom = screenHeight - top - buttonSize;

    final double minHorizontal = distanceLeft < distanceRight ? distanceLeft : distanceRight;
    final double minVertical = distanceTop < distanceBottom ? distanceTop : distanceBottom;

    if (minHorizontal < minVertical) {
      if (distanceLeft < distanceRight) {
        _edge = SnapEdge.left;
        left = 0;
      } else {
        _edge = SnapEdge.right;
        left = screenWidth-20;
      }
    } else {
      if (distanceTop < distanceBottom) {
        _edge = SnapEdge.top;
        top = 0;
      } else {
        _edge = SnapEdge.bottom;
        top = screenHeight-buttonSize;
      }
    }

    setState(() {});
  }

  double get containerWidth => expanded ? buttonSize : (_edge == SnapEdge.left || _edge == SnapEdge.right ? 20 : buttonSize);

  double get containerHeight => expanded ? buttonSize : (_edge == SnapEdge.top || _edge == SnapEdge.bottom ? 20 : buttonSize);

  Widget _buildHiddenIndicator() {
    switch (_edge) {
      case SnapEdge.left:
        return Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: 6,
            height: 30,
            margin: const EdgeInsets.only(left: 2),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(3)),
          ),
        );
      case SnapEdge.right:
        return Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: 6,
            height: 30,
            margin: const EdgeInsets.only(right: 2),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(3)),
          ),
        );
      case SnapEdge.top:
        return Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: 30,
            height: 6,
            margin: const EdgeInsets.only(top: 2),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(3)),
          ),
        );
      case SnapEdge.bottom:
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: 30,
            height: 6,
            margin: const EdgeInsets.only(bottom: 2),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(3)),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    double translateX = 0;
    double translateY = 0;
    if (_edge == SnapEdge.bottom && expanded) {
      translateY = -buttonSize ; // 向上偏移半个按钮高度
    }
    if (_edge == SnapEdge.right && expanded) {
      translateX = -buttonSize ; // 向左偏移按钮高度
    }
    return Positioned(
      top: top,
      left: left,
      child: Transform.translate(
        offset: Offset(translateX, translateY),
        child: GestureDetector(
          onTap: () {
            setState(() {
              expanded = true;
            });
            _startAutoCollapseTimer();
          },
          onPanUpdate: (details) {
            setState(() {
              top += details.delta.dy;
              left += details.delta.dx;
            });
            _startAutoCollapseTimer();
          },
          onPanEnd: (_) {
            _startAutoCollapseTimer();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: containerWidth,
            height: containerHeight,
            decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(100)),
            child: expanded
                ? TextButton(
                    onPressed: () {
                      showModalBottomSheet(context: context, builder: (_) => _action());
                    },
                    child: const Icon(Icons.home, color: Colors.white, size: 30),
                  )
                : _buildHiddenIndicator(),
          ),
        ),
      ),
    );
  }

  Widget _action() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        children: [
          ListTile(leading: const Icon(Icons.wallet), title: const Text('充值'), onTap: () {}),
          ListTile(leading: const Icon(Icons.list_alt), title: const Text('帐变记录'), onTap: () {}),
          ListTile(leading: const Icon(Icons.list), title: const Text('游戏记录'), onTap: () {}),
          ListTile(leading: const Icon(Icons.currency_exchange), title: const Text('余额操作'), onTap: () {}),
          ListTile(leading: const Icon(Icons.info), title: const Text('关于'), onTap: () {}),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('退出游戏'),
            onTap: () {
              Navigator.pop(context); // 关闭 BottomSheet
              AppRoute.back();
            },
          ),
          const SizedBox(height: 24),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.block),
            title: const Text('不操作'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
