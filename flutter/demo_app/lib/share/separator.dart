import 'dart:math';

import 'package:flutter/material.dart';

class Separator extends StatefulWidget {
  final double radius; // 不能超过容器高度-间隔半径
  final double radius_separator;
  final List<Widget> children;
  final Color? bg;
  final Gradient? bgGradient;
  final Color dashColor;

  Separator({this.radius = 10, this.radius_separator = 10, this.children = const <Widget>[], this.bgGradient, this.bg , this.dashColor = Colors.grey});

  @override
  _SeparatorState createState() => _SeparatorState();
}

class _SeparatorState extends State<Separator> {
  final List<GlobalKey> _childKeys = [];
  final List<Widget> itemsWithKey = [];
  final List<double> clipPaths = [];

  @override
  void initState() {
    super.initState();
    _childKeys.addAll(List.generate(widget.children.length, (_) => GlobalKey()));
    for (int i = 0; i < widget.children.length; i++) {
      itemsWithKey.add(
        KeyedSubtree(
          key: _childKeys[i],
          child: Container(padding: EdgeInsetsGeometry.all(max(widget.radius, widget.radius_separator)), child: widget.children[i]),
        ),
      );
    }
    _record_clip_path();
  }

  _record_clip_path() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      double startY = 0;
      for (int i = 0; i < widget.children.length; i++) {
        if (i < (widget.children.length - 1)) {
          var key = _childKeys[i];
          final context = key.currentContext;
          if (context != null) {
            final box = context.findRenderObject() as RenderBox;
            final size = box.size;
            startY = (startY + size.height);
            clipPaths.add(startY);
          }
        }
      }

      if (clipPaths.length > 1) {
        setState(() {});
      }
    });
  }

  /*
  CustomPaint(painter: _DashedLinePainter(radius_separator: widget.radius_separator, clipPaths: clipPaths,dashColor: Colors.grey),
      child: )
  * */

  /*
1. painter (背景绘制)
2. child (正常布局的 widget)
3. foregroundPainter (前景绘制) 给child上画
  * */

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _ColumnClipper(radius_parent: widget.radius, radius_separator: widget.radius_separator, clipPaths: clipPaths), //将child 裁剪出圈出的模样
      child: CustomPaint(
        foregroundPainter: _DashedLinePainter(radius_separator: widget.radius_separator, clipPaths: clipPaths, dashColor: widget.dashColor),
        child: Container(
          decoration: BoxDecoration(color: widget.bg, gradient: widget.bgGradient),
          child: Column(children: itemsWithKey),
        ),
      ),
    );
  }
}

//圈出一块形状 横向裁剪
class _ColumnClipper extends CustomClipper<Path> {
  final double radius_parent;
  final double radius_separator;
  List<double> clipPaths;

  _ColumnClipper({this.radius_parent = 0, this.radius_separator = 10, this.clipPaths = const []});

  @override
  Path getClip(Size size) {
    final path = Path();
    // 左上角半圆
    path.moveTo(radius_parent, 0);
    path.arcToPoint(
      Offset(0, radius_parent),
      radius: Radius.circular(radius_parent),
      clockwise: false, //逆时针
    );

    // 左侧间隔半圆
    for (int i = 0; i < clipPaths.length; i++) {
      var position = clipPaths[i];
      path.lineTo(0, position - radius_separator);
      path.arcToPoint(
        Offset(0, position + radius_separator),
        radius: Radius.circular(radius_separator),
        clockwise: true, //顺时针
      );
    }
    // 左下角半圆
    path.lineTo(0, size.height - radius_parent);
    path.arcToPoint(
      Offset(radius_parent, size.height),
      radius: Radius.circular(radius_parent),
      clockwise: false, //逆时针
    );
    // 右下角半圆
    path.lineTo(size.width - radius_parent, size.height);
    path.arcToPoint(
      Offset(size.width, size.height - radius_parent),
      radius: Radius.circular(radius_parent),
      clockwise: false, //逆时针
    );
    // 右侧间隔半圆
    for (int i = 0; i < clipPaths.length; i++) {
      var position = clipPaths[i];
      path.lineTo(size.width, position + radius_separator);
      path.arcToPoint(
        Offset(size.width, position - radius_separator),
        radius: Radius.circular(radius_separator),
        clockwise: true, //顺时针
      );
    }
    // 右上角半圆
    path.lineTo(size.width, radius_parent);
    path.arcToPoint(
      Offset(size.width - radius_parent, 0),
      radius: Radius.circular(radius_parent),
      clockwise: false, //逆时针
    );
    path.lineTo(radius_parent, 0);
    // 闭合路径
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class _DashedLinePainter extends CustomPainter {
  final double radius_separator;
  final List<double> clipPaths;
  final Color dashColor;

  const _DashedLinePainter({this.radius_separator = 10, this.clipPaths = const [], this.dashColor = Colors.grey});

  @override
  void paint(Canvas canvas, Size size) {
    for (var positionY in clipPaths) {
      _drawLine(canvas, size, radius_separator, positionY, dashColor);
    }
  }

  _drawLine(Canvas canvas, Size size, double radius, double positionY, Color dashColor) {
    final Paint linePaint = Paint()
      ..color = dashColor
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    double dashWidth = 5;
    double dashSpace = 3;
    double startX = radius + 10;
    while (startX < size.width - (radius + 10)) {
      canvas.drawLine(Offset(startX, positionY), Offset(startX + dashWidth, positionY), linePaint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
