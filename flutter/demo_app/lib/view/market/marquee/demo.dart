import 'package:flutter/material.dart';
import 'package:flutter3/app-route.dart';
import 'package:flutter3/share/marquee.dart';
import 'package:flutter3/app-style.dart';
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
      TextButton(onPressed: ()=>{AppRoute.to("announce")}, child: Icon(icon, color: color, size: size)),
      if (showBadge)
        Positioned(
          right: count != null ? -6 : -3,
          top: count != null ? -6 : 0,
          child: Container(
            padding: count != null ? EdgeInsets.symmetric(horizontal: 2, vertical: 1) : EdgeInsets.all(4),
            decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(12)),
            constraints: count != null ? null : BoxConstraints(minWidth: 4, minHeight: 4),
            child: count != null
                ? Text(
                    count > 9 ? '9+' : '$count',
                    style: TextStyle().copyWith(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold,height: 1),
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
      height: AppStyle.fontSize*AppStyle.lineHeight+2*AppStyle.gap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppStyle.gap),
        child: Row(
          children: [
            TextButton(onPressed: ()=>AppRoute.to("announce"), child: Icon(Icons.volume_up, size: AppStyle.fontSize*AppStyle.lineHeight),),
            SizedBox(width: AppStyle.byRem(.1)),
            //Expanded(child: MarqueeWithoutTicker(text: messages.join('     ★     '))),
            Expanded(child: Marquee(text: messages.join('     ★     '))),
            SizedBox(width: AppStyle.byRem(.1)),
            iconWithBadge(icon: Icons.mail, size:AppStyle.fontSize*AppStyle.lineHeight,showBadge: true, count: 247),
          ],
        ),
      ),
    ));
  }
}
