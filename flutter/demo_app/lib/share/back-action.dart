import 'package:flutter/material.dart';
import 'package:flutter3/app-route.dart';

class BackAction extends StatelessWidget {
  final Widget child;
  final Function? action;

  /// 能回退则 AppRoute.back();
  BackAction({required this.child, this.action});

  _action(bool didPop, Object? result) {
    /*
    * didPop：bool，表示是否真的完成了 pop
        true → pop 已经发生（栈顶页面被移除）
        false → pop 被取消（例如 canPop: false）
    * result：T?，表示 Navigator.pop(context, result) 传回去的结果
        如果调用 Navigator.pop(context, 'Hello') → result 会是 "Hello"
        如果调用 Navigator.pop(context) → result 会是 null
    * */
    if (didPop) {
      // 已经pop了，什么都不用做
      return;
    }
    if (null != action) {
      action!();
    }
    /// 没有回调方法，啥也不干
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // 嵌套 只有所有层都返回 true 才会真正 pop
      canPop: false, // <- 这行是拦截回退的关键！
      onPopInvokedWithResult: _action,
      child: child,
    );
  }
}
