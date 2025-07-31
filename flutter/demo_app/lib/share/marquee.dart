import 'dart:async';

import 'package:flutter/material.dart';

class Marquee extends StatefulWidget {
  final String text;
  final TextStyle? style;//文字样式
  final double velocity;//每秒移动多少
  final Color backgroundColor;//背景颜色
  final Axis scrollDirection;
  final double gap;
  final double startPadding;
  final Duration pauseAfterRound;

  const Marquee({Key? key, required this.text, this.style, this.velocity = 50, this.backgroundColor = Colors.transparent, this.scrollDirection = Axis.horizontal, this.gap = 50, this.startPadding = 20, this.pauseAfterRound = const Duration(seconds: 1)}) : super(key: key);

  @override
  _MarqueeState createState() => _MarqueeState();
}

class _MarqueeState extends State<Marquee> {
  @override
  Widget build(BuildContext context) {
    return _MarqueeView(text: widget.text, style: widget.style, velocity: widget.velocity, backgroundColor: widget.backgroundColor, scrollDirection: widget.scrollDirection, gap: widget.gap, startPadding: widget.startPadding, pauseAfterRound: widget.pauseAfterRound);
  }
}

class _MarqueeView extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final double velocity;
  final Color backgroundColor;
  final Axis scrollDirection;
  final double gap;
  final double startPadding;
  final Duration pauseAfterRound;

  const _MarqueeView({Key? key, required this.text, this.style, this.velocity = 50, this.backgroundColor = Colors.transparent, this.scrollDirection = Axis.horizontal, this.gap = 50, this.startPadding = 20, this.pauseAfterRound = const Duration(seconds: 1)}) : super(key: key);

  @override
  State<_MarqueeView> createState() => _MarqueeViewState();
}

class _MarqueeViewState extends State<_MarqueeView> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late ScrollController _scrollController;

  final GlobalKey _textKey = GlobalKey();
  final GlobalKey _containerKey = GlobalKey();

  double _textExtent = 0;
  double _containerExtent = 0;
  int _repeatCount = 2;
  bool _isDragging = false;

  Timer? _pauseTimer;
  int _retryCount = 0;
  static const int _maxRetry = 5;

  Axis get _axis => widget.scrollDirection;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _controller = AnimationController(vsync: this)..addListener(_onAnimate);

    WidgetsBinding.instance.addPostFrameCallback((_) => _initScroll());
  }

  @override
  void didUpdateWidget(covariant _MarqueeView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.text != oldWidget.text || widget.velocity != oldWidget.velocity || widget.scrollDirection != oldWidget.scrollDirection) {
      _pauseTimer?.cancel();
      _controller
        ..removeListener(_onAnimate)
        ..dispose();

      _scrollController.dispose();
      _scrollController = ScrollController();
      _controller = AnimationController(vsync: this)..addListener(_onAnimate);

      WidgetsBinding.instance.addPostFrameCallback((_) => _initScroll());
    }
  }

  @override
  void dispose() {
    _pauseTimer?.cancel();
    _controller
      ..removeListener(_onAnimate)
      ..dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _initScroll() {
    final textBox = _textKey.currentContext?.findRenderObject() as RenderBox?;
    final containerBox = _containerKey.currentContext?.findRenderObject() as RenderBox?;

    if (textBox == null || containerBox == null) {
      if (_retryCount < _maxRetry) {
        _retryCount++;
        WidgetsBinding.instance.addPostFrameCallback((_) => _initScroll());
      }
      return;
    }

    _retryCount = 0;
    _textExtent = _axis == Axis.horizontal ? textBox.size.width : textBox.size.height;
    _containerExtent = _axis == Axis.horizontal ? containerBox.size.width : containerBox.size.height;

    _repeatCount = ((_containerExtent * 2 + widget.startPadding) / (_textExtent + widget.gap)).ceil();

    final totalDistance = (_textExtent + widget.gap) * _repeatCount + widget.startPadding;
    final duration = Duration(milliseconds: (totalDistance / widget.velocity * 1000).toInt());
    _controller.duration = duration;

    if (mounted) {
      _controller.repeat();
    }

    setState(() {}); // 触发 build
  }

  void _onAnimate() {
    if (!mounted || _isDragging || !_scrollController.hasClients) return;

    final totalDistance = (_textExtent + widget.gap) * _repeatCount + widget.startPadding;
    final offset = _controller.value * totalDistance;

    if (offset >= _scrollController.position.maxScrollExtent) {
      _scrollController.jumpTo(0);
      _controller.stop();

      _pauseTimer?.cancel();
      _pauseTimer = Timer(widget.pauseAfterRound, () {
        if (mounted && !_isDragging) {
          _controller.repeat();
        }
      });
    } else {
      _scrollController.jumpTo(offset.clamp(0, _scrollController.position.maxScrollExtent));
    }
  }

  void _pause() {
    _pauseTimer?.cancel();
    _controller.stop();
  }

  void _resume() {
    if (!_controller.isAnimating) _controller.repeat();
  }

  void _onDragStart() {
    _isDragging = true;
    _pause();
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (!_scrollController.hasClients) return;

    final delta = _axis == Axis.horizontal ? details.delta.dx : details.delta.dy;
    double newOffset = _scrollController.offset - delta;
    newOffset = newOffset.clamp(0.0, _scrollController.position.maxScrollExtent);
    _scrollController.jumpTo(newOffset);
  }

  void _onDragEnd() {
    _isDragging = false;
    _resume();
  }

  List<Widget> _buildRepeatedTexts() {
    return List.generate(_repeatCount * 2 - 1, (index) {
      if (index.isOdd) {
        return SizedBox(width: _axis == Axis.horizontal ? widget.gap : 0, height: _axis == Axis.vertical ? widget.gap : 0);
      } else {
        return Container(
          alignment: Alignment.center,
          child: Text(widget.text, style: widget.style),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _containerKey,
      color: widget.backgroundColor,
      child: GestureDetector(
        onHorizontalDragStart: _axis == Axis.horizontal ? (_) => _onDragStart() : null,
        onHorizontalDragUpdate: _axis == Axis.horizontal ? _onDragUpdate : null,
        onHorizontalDragEnd: _axis == Axis.horizontal ? (_) => _onDragEnd() : null,
        onVerticalDragStart: _axis == Axis.vertical ? (_) => _onDragStart() : null,
        onVerticalDragUpdate: _axis == Axis.vertical ? _onDragUpdate : null,
        onVerticalDragEnd: _axis == Axis.vertical ? (_) => _onDragEnd() : null,
        child: ShaderMask(
          shaderCallback: (Rect rect) {
            return LinearGradient(begin: _axis == Axis.horizontal ? Alignment.centerLeft : Alignment.topCenter, end: _axis == Axis.horizontal ? Alignment.centerRight : Alignment.bottomCenter, colors: const [Colors.transparent, Colors.black, Colors.black, Colors.transparent], stops: const [0.0, 0.1, 0.9, 1.0]).createShader(rect);
          },
          blendMode: BlendMode.dstIn,
          child: ScrollConfiguration(
            behavior: _NoScrollbarBehavior(),
            child: ListView(
              key: _textKey,
              controller: _scrollController,
              scrollDirection: _axis,
              physics: const NeverScrollableScrollPhysics(),
              padding: _axis == Axis.horizontal ? EdgeInsets.only(left: widget.startPadding) : EdgeInsets.only(top: widget.startPadding),
              children: _buildRepeatedTexts(),
            ),
          ),
        ),
      ),
    );
  }
}

class _NoScrollbarBehavior extends ScrollBehavior {
  @override
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) {
    return child; // 不显示滚动条
  }
}
