import 'package:flutter/material.dart';
import 'package:flutter3/style/app-style.dart';
import 'package:marquee/marquee.dart';

class MarqueeDemo extends StatefulWidget {
  const MarqueeDemo({super.key, required params});

  @override
  _MarqueeDemoState createState() => _MarqueeDemoState();
}

class _MarqueeDemoState extends State<MarqueeDemo> {
  Widget iconWithBadge({
    required IconData icon,
    required bool showBadge,
    int? count,
    double size = 24,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(icon, color: Colors.white, size: size),
        if (showBadge)
          Positioned(
            right: count != null ? -6 : -3,
            top: count != null ? -6 : 0,
            child: Container(
              padding: count != null
                  ? EdgeInsets.symmetric(horizontal: 4, vertical: 1)
                  : EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              constraints: count != null
                  ? BoxConstraints(minWidth: 16, minHeight: 16)
                  : BoxConstraints(minWidth: 4, minHeight: 4),
              child: count != null
                  ? Text(
                      count > 99 ? '99+' : '$count',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    )
                  : SizedBox.shrink(), // 只有红点不显示数字
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> messages = [
      '🎉 欢迎来到我们的应用！',
      '🔥 今日特价商品限时抢购！',
      '📢 重要通知：系统维护时间为今晚10点。',
      '🎉 欢迎来到我们的应用！',
      '🔥 今日特价商品限时抢购！',
      '📢 重要通知：系统维护时间为今晚10点。',
      '🎉 欢迎来到我们的应用！',
      '🔥 今日特价商品限时抢购！',
      '📢 重要通知：系统维护时间为今晚10点。',
      '🎉 欢迎来到我们的应用！',
      '🔥 今日特价商品限时抢购！',
      '📢 重要通知：系统维护时间为今晚10点。',
      '🎉 欢迎来到我们的应用！',
      '🔥 今日特价商品限时抢购！',
      '📢 重要通知：系统维护时间为今晚10点。',
      '🎉 欢迎来到我们的应用！',
      '🔥 今日特价商品限时抢购！',
      '📢 重要通知：系统维护时间为今晚10点。',
      '🎉 欢迎来到我们的应用！',
      '🔥 今日特价商品限时抢购！',
      '📢 重要通知：系统维护时间为今晚10点。',
      '🎉 欢迎来到我们的应用！',
      '🔥 今日特价商品限时抢购！',
      '📢 重要通知：系统维护时间为今晚10点。',
    ];
    // font-size: .24rem
    // 16.032px
    // ;
    return Container(
      height: AppStyle.byRem(.5),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppStyle.byRem(.2)),
        child: Row(
          children: [
            Icon(
              Icons.volume_up,
              color: Colors.white,
              size: AppStyle.byRem(.36),
            ), // 📢 图标
            SizedBox(width: 8),
            Expanded(
              child: Marquee(
                text: messages.join('     ★     '),
                // 用特殊字符分隔,
                style: TextStyle(fontSize: AppStyle.byRem(.24), height: 2),
                // 2倍line-height:这样才居中
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
            iconWithBadge(icon: Icons.mail, showBadge: false, count: null),
          ],
        ),
      ),
    );
  }
}
