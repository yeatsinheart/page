import 'package:flutter/material.dart';

import 'marquee-view.dart';

class ExtendedMarquee extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final double velocity;
  final Color backgroundColor;
  final Axis scrollDirection;
  final double gap;
  final double startPadding;
  final Duration pauseAfterRound;

  const ExtendedMarquee({
    Key? key,
    required this.text,
    this.style,
    this.velocity = 50,
    this.backgroundColor = Colors.transparent,
    this.scrollDirection = Axis.horizontal,
    this.gap = 50,
    this.startPadding = 20,
    this.pauseAfterRound = const Duration(seconds: 1),
  }) : super(key: key);

  @override
  _ExtendedMarqueeState createState() => _ExtendedMarqueeState();
}

class _ExtendedMarqueeState extends State<ExtendedMarquee> {
  bool test = true;
  @override
  Widget build(BuildContext context) {
    return
      MarqueeView(
      text: widget.text,
      style: widget.style,
      velocity: widget.velocity,
      backgroundColor: widget.backgroundColor,
      scrollDirection: widget.scrollDirection,
      gap: widget.gap,
      startPadding: widget.startPadding,
      pauseAfterRound: widget.pauseAfterRound,
    )
    ;
  }
}
