import 'dart:async';

import 'package:flutter/material.dart';
class MarqueeWithoutTicker extends StatefulWidget {
  final String text;
  final double speed; // 像素每秒

  const MarqueeWithoutTicker({
    Key? key,
    required this.text,
    this.speed = 50,
  }) : super(key: key);

  @override
  _MarqueeWithoutTickerState createState() => _MarqueeWithoutTickerState();
}

class _MarqueeWithoutTickerState extends State<MarqueeWithoutTicker> {
  late double _position;
  late double _textWidth;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _position = 0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final painter = TextPainter(
        text: TextSpan(text: widget.text, style: TextStyle(fontSize: 20)),
        maxLines: 1,
        textDirection: TextDirection.ltr,
      )..layout();

      _textWidth = painter.width;

      final frameDuration = Duration(milliseconds: 16); // ~60fps
      final step = widget.speed * frameDuration.inMilliseconds / 1000;

      _timer = Timer.periodic(frameDuration, (x) {
        if (!mounted) return;

        setState(() {
          _position += step;
          if (_position > _textWidth) _position = 0;
        });
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
        children: [
          Positioned(
            left: -_position,
            child: Row(
              children: [
                Text(widget.text, style: TextStyle(fontSize: 20)),
                SizedBox(width: 50),
                Text(widget.text, style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
