import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

import '../../../util/context.dart';

class MarketMarqueeDemo extends StatefulWidget {
  @override
  _MarketMarqueeDemoState createState() => _MarketMarqueeDemoState();
}

class _MarketMarqueeDemoState extends State<MarketMarqueeDemo> {
  @override
  Widget build(BuildContext context) {
    final List<String> messages = ['🎉 欢迎来到我们的应用！', '🔥 今日特价商品限时抢购！', '📢 重要通知：系统维护时间为今晚10点。'
    ,'🎉 欢迎来到我们的应用！', '🔥 今日特价商品限时抢购！', '📢 重要通知：系统维护时间为今晚10点。','🎉 欢迎来到我们的应用！', '🔥 今日特价商品限时抢购！', '📢 重要通知：系统维护时间为今晚10点。','🎉 欢迎来到我们的应用！', '🔥 今日特价商品限时抢购！', '📢 重要通知：系统维护时间为今晚10点。','🎉 欢迎来到我们的应用！', '🔥 今日特价商品限时抢购！', '📢 重要通知：系统维护时间为今晚10点。','🎉 欢迎来到我们的应用！', '🔥 今日特价商品限时抢购！', '📢 重要通知：系统维护时间为今晚10点。','🎉 欢迎来到我们的应用！', '🔥 今日特价商品限时抢购！', '📢 重要通知：系统维护时间为今晚10点。','🎉 欢迎来到我们的应用！', '🔥 今日特价商品限时抢购！', '📢 重要通知：系统维护时间为今晚10点。'];
    // font-size: .24rem
    // 16.032px
    // ;
    return Container(
      height: GlobalContext.getRem(.5),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: GlobalContext.getRem(.2)),
        child: Row(
          children: [
            Icon(Icons.volume_up, color: Colors.white, size: GlobalContext.getRem(.36)), // 📢 图标
            SizedBox(width: 8),
            Expanded(
              child:  Marquee(
                  text: messages.join('     ★     '),
                  // 用特殊字符分隔,
                  style: TextStyle(fontSize: GlobalContext.getRem(.24),height: 2,),// 2倍line-height:这样才居中
                  scrollAxis: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  blankSpace: 20.0,
                  velocity: 40.0,
                  // 👈 速度越小越慢，默认是 100.0
                  pauseAfterRound: Duration(seconds: 1),
                  // 可选：每轮滚动后暂停 1 秒
                  startPadding: 10.0,
                  accelerationDuration: Duration(seconds: 1),
                  accelerationCurve: Curves.linear,
                  decelerationDuration: Duration(milliseconds: 500),
                  decelerationCurve: Curves.easeOut,
                ),
            ),
            SizedBox(width: 8),
            Icon(Icons.mail, color: Colors.white, size: GlobalContext.getRem(.36)), // 📢 图标
          ],
        ),
      ),
    );
  }
}
