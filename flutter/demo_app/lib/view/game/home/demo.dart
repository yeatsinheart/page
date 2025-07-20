import 'package:flutter/material.dart';

class GameHomeDemo extends StatefulWidget {
  final List<String> tabs;
  final Function(int index)? onTap;
  final int initialIndex;

  const GameHomeDemo({required this.tabs, this.onTap, this.initialIndex = 0});

  @override
  _GameHomeDemoState createState() => _GameHomeDemoState();
}

class _GameHomeDemoState extends State<GameHomeDemo> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SizedBox(
        height: 44, // 控制 tab 高度
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.tabs.length,
          padding: EdgeInsets.symmetric(horizontal: 12),
          itemBuilder: (context, index) {
            final selected = index == selectedIndex;
            return GestureDetector(
              onTap: () {
                setState(() => selectedIndex = index);
                widget.onTap?.call(index);
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 16),
                margin: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: selected ? Colors.blue : Colors.transparent, width: 2)),
                ),
                child: Text(
                  widget.tabs[index],
                  style: TextStyle(fontSize: 14, color: selected ? Colors.blue : Colors.black54, fontWeight: selected ? FontWeight.bold : FontWeight.normal),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
