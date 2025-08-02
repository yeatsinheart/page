import 'package:flutter/material.dart';
import 'package:flutter3/share/marquee.dart';
import 'package:flutter3/style/app-style.dart';
import 'package:flutter3/style/format/container.dart';


class MarketMarqueeDemo extends StatefulWidget {
  const MarketMarqueeDemo({super.key, required params});

  @override
  _MarketMarqueeDemoState createState() => _MarketMarqueeDemoState();
}

Widget iconWithBadge({required IconData icon, required bool showBadge, color, int? count, double size = 24}) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Icon(icon, color: color, size: size),
      if (showBadge)
        Positioned(
          right: count != null ? -6 : -3,
          top: count != null ? -6 : 0,
          child: Container(
            padding: count != null ? EdgeInsets.symmetric(horizontal: 4, vertical: 1) : EdgeInsets.all(4),
            decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(12)),
            constraints: count != null ? BoxConstraints(minWidth: 16, minHeight: 16) : BoxConstraints(minWidth: 4, minHeight: 4),
            child: count != null
                ? Text(
                    count > 99 ? '99+' : '$count',
                    style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )
                : SizedBox.shrink(), // 只有红点不显示数字
          ),
        ),
    ],
  );
}

class _MarketMarqueeDemoState extends State<MarketMarqueeDemo> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  final List<String> messages = ['🎉 欢迎来到我们的应用！', '🔥 今日特价商品限时抢购！', '📢 重要通知：系统维护时间为今晚10点。'];

  @override
  Widget build(BuildContext context) {
    return ContainerFormat("marquee",Container(
      height: AppStyle.byRem(.5),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppStyle.byRem(.2)),
        child: Row(
          children: [
            Icon(Icons.volume_up, size: AppStyle.byRem(.36)), // 📢 图标
            SizedBox(width: 8),

            //Expanded(child: MarqueeWithoutTicker(text: messages.join('     ★     '))),

            Expanded(child: Marquee(text: messages.join('     ★     '))),
            SizedBox(width: 8),
            iconWithBadge(icon: Icons.mail, showBadge: false, count: null),
          ],
        ),
      ),
    ));
  }
}
