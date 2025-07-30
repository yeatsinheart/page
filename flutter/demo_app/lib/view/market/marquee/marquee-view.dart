import 'dart:async';
import 'package:flutter/material.dart';

class MarqueeView extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final double velocity;
  final Color backgroundColor;
  final Axis scrollDirection;
  final double gap;
  final double startPadding;
  final Duration pauseAfterRound;

  const MarqueeView({
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
  _MarqueeViewState createState() => _MarqueeViewState();
}


class _MarqueeViewState extends State<MarqueeView> with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _controller;

  final GlobalKey _textKey = GlobalKey();
  final GlobalKey _containerKey = GlobalKey();

  double _textExtent = 0;
  double _containerExtent = 0;

  bool _isDragging = false;
  int _repeatCount = 2;
  Timer? _pauseTimer;

  int _initScrollRetryCount = 0;
  static const int _maxRetryCount = 5;

  Axis get _axis => widget.scrollDirection;

  double get _maxScrollExtent => _scrollController.hasClients ? _scrollController.position.maxScrollExtent : 0;



  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _controller = AnimationController(vsync: this);
    _controller.addListener(_onAnimate);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // hot reload 触发了新的“下一帧”流程，导致回调被调用。
      _initScroll();
    });
  }


  void _onAnimate() {
    if ( !mounted || _isDragging || !_scrollController.hasClients) return;

    final double distance = (_textExtent + widget.gap) * _repeatCount + widget.startPadding;
    final double offset = _controller.value * distance;

    if (offset >= _maxScrollExtent) {
      _scrollController.jumpTo(0);
      _controller.value = 0;
      _controller.stop();

      _pauseTimer?.cancel();
      _pauseTimer = Timer(widget.pauseAfterRound, () {
        if (mounted && !_isDragging) {
          repeat();
        }
      });
    } else {
      _scrollController.jumpTo(offset.clamp(0, _maxScrollExtent));
    }
  }

  void _initScroll() {

    final RenderBox? textBox = _textKey.currentContext?.findRenderObject() as RenderBox?;
    final RenderBox? containerBox = _containerKey.currentContext?.findRenderObject() as RenderBox?;

    if (textBox == null || containerBox == null) {
      if (_initScrollRetryCount < _maxRetryCount) {
        _initScrollRetryCount++;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _initScroll();
        });
      }
      return;
    }
    _initScrollRetryCount = 0;

    _textExtent = _axis == Axis.horizontal ? textBox.size.width : textBox.size.height;
    _containerExtent = _axis == Axis.horizontal ? containerBox.size.width : containerBox.size.height;

    _repeatCount = ((_containerExtent * 2 + widget.startPadding) / (_textExtent + widget.gap)).ceil();

    final double distance = (_textExtent + widget.gap) * _repeatCount + widget.startPadding;
    final int durationMillis = (distance / widget.velocity * 1000).toInt();

    _controller.duration = Duration(milliseconds: durationMillis);

    if (mounted) {
      repeat();
    }
    setState(() {}); // 重新build
  }

  void repeat(){
      // flutter web 热重载时容易导致元素已经销毁，它还继续
      _controller.repeat();
  }
  void _pause() {
    _pauseTimer?.cancel();
    _controller.stop();
  }


  void _resume() {
    if (!_controller.isAnimating)  repeat();;
  }

  @override
  void didUpdateWidget(covariant MarqueeView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text ||
        oldWidget.velocity != widget.velocity ||
        oldWidget.scrollDirection != widget.scrollDirection) {
      _pauseTimer?.cancel();
      _controller.removeListener(_onAnimate);
      _controller.dispose();
      _scrollController.dispose();

      _scrollController = ScrollController();
      _controller = AnimationController(vsync: this);
      _controller.addListener(_onAnimate);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _initScroll();
      });
    }
  }

  @override
  void dispose() {
    _pauseTimer?.cancel();
    _controller.removeListener(_onAnimate);
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  List<Widget> _buildRepeatedTexts() {
    List<Widget> widgets = [];
    for (int i = 0; i < _repeatCount; i++) {
      widgets.add(Container(
        alignment: Alignment.center,
        child: Text(widget.text, style: widget.style),
      ));
      if (i != _repeatCount - 1) {
        widgets.add(SizedBox(
          width: _axis == Axis.horizontal ? widget.gap : 0,
          height: _axis == Axis.vertical ? widget.gap : 0,
        ));
      }
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _containerKey,
      color: widget.backgroundColor,
      child: GestureDetector(
        onHorizontalDragStart: widget.scrollDirection == Axis.horizontal
            ? (_) {
          _isDragging = true;
          _pause();
        }
            : null,
        onHorizontalDragUpdate: widget.scrollDirection == Axis.horizontal
            ? (details) {
          if (_scrollController.hasClients) {
            double newOffset = _scrollController.offset - details.delta.dx;
            newOffset = newOffset.clamp(0.0, _maxScrollExtent);
            _scrollController.jumpTo(newOffset);
          }
        }
            : null,
        onHorizontalDragEnd: widget.scrollDirection == Axis.horizontal
            ? (_) {
          _isDragging = false;
          _resume();
        }
            : null,
        onVerticalDragStart: widget.scrollDirection == Axis.vertical
            ? (_) {
          _isDragging = true;
          _pause();
        }
            : null,
        onVerticalDragUpdate: widget.scrollDirection == Axis.vertical
            ? (details) {
          if (_scrollController.hasClients) {
            double newOffset = _scrollController.offset - details.delta.dy;
            newOffset = newOffset.clamp(0.0, _maxScrollExtent);
            _scrollController.jumpTo(newOffset);
          }
        }
            : null,
        onVerticalDragEnd: widget.scrollDirection == Axis.vertical
            ? (_) {
          _isDragging = false;
          _resume();
        }
            : null,
        child: ShaderMask(
          shaderCallback: (Rect rect) {
            return LinearGradient(
              begin: _axis == Axis.horizontal ? Alignment.centerLeft : Alignment.topCenter,
              end: _axis == Axis.horizontal ? Alignment.centerRight : Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black, Colors.black, Colors.transparent],
              stops: [0.0, 0.1, 0.9, 1.0],
            ).createShader(rect);
          },
          blendMode: BlendMode.dstIn,
          child: ScrollConfiguration(
            behavior: NoScrollbarBehavior(),
            child: ListView(
              key: _textKey,
              controller: _scrollController,
              scrollDirection: widget.scrollDirection,
              physics: const NeverScrollableScrollPhysics(),
              padding: widget.scrollDirection == Axis.horizontal
                  ? EdgeInsets.only(left: widget.startPadding)
                  : EdgeInsets.only(top: widget.startPadding),
              children: _buildRepeatedTexts(),
            ),
          ),
        ),
      ),
    );
  }
}

class NoScrollbarBehavior extends ScrollBehavior {
  @override
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) {
    return child; // 直接返回，不显示滚动条
  }
}