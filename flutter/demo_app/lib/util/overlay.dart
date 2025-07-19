import 'dart:math';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';

import 'context.dart';

class GlobalOverlayContext {
  GlobalOverlayContext._internal();

  factory GlobalOverlayContext() => _instance;

  static final GlobalOverlayContext _instance = GlobalOverlayContext._internal();

//https://juejin.cn/post/7026150456673959943 弹窗效果说明
// overlay + dissmiss

  static OverlayState? get overlay => GlobalContext.navigatorKey.currentState!.overlay;

  /// 获取元素，方便自定义行为控制，与是否取消
  static OverlayEntry item(
    Widget widget, {
    bool opaque = false,
    bool maintainState = true,
  }) {
    return OverlayEntry(
        opaque: opaque,
        maintainState: maintainState,
        builder: (context) => Material(
          type: MaterialType.transparency, // 或 canvas
          child: Theme(
            data: Theme.of(context), // 复用当前主题
            child: SafeArea(
              child: widget,
            ),
          ),
        ),
        );
  }

  static void showOverlay(OverlayEntry widget, {int autoRemoveTime = 0, bool sysCanRemove = false, String? backName}) {
    try {
      overlay!.insert(widget);
      if (autoRemoveTime > 0) {
        Future.delayed(Duration(milliseconds: autoRemoveTime), () {
          removeOverlay(widget);
        });
      }
      // 物理返回键 ： 使用最新的back_button_interceptor(7.0.0) WillPopScope 其实也无法拦截 Overlay 的返回事件 因为所处层级不同。
      if (sysCanRemove) {
        backName = backName ?? Random().nextDouble().toString();
        BackButtonInterceptor.add(name: backName, (bool stopDefaultButtonEvent, RouteInfo info) {
          removeOverlay(widget);
          BackButtonInterceptor.removeByName(backName!);
          return true;
        });
      }
    } catch (err, stack) {
      print("插入Overlay 异常${err}");
    }
  }

  static void removeOverlay(OverlayEntry widget) {
    if (widget.mounted) widget.remove();
  }
}
