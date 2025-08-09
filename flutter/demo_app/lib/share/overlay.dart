import 'dart:math';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter3/app-context.dart';
import 'package:flutter3/log/logger.dart';
import 'package:flutter3/app-style.dart';
import 'package:flutter3/style/theme/all-theme.dart';
import 'package:flutter3/view/app-view.dart';

class GlobalOverlayContext {
  GlobalOverlayContext._internal();

  factory GlobalOverlayContext() => _instance;

  static final GlobalOverlayContext _instance = GlobalOverlayContext._internal();

  //https://juejin.cn/post/7026150456673959943 弹窗效果说明
  // overlay + dissmiss

  static OverlayState? get overlay => AppContext.navigatorKey.currentState!.overlay;

  static OverlayEntry item(
    Widget widget, {
    bool opaque = false,
    bool maintainState = true,
    bool blockTouch = true, // ⬅️ 是否阻止事件穿透
    Color? barrierColor, // ⬅️ 可自定义遮罩颜色
  }) {
    return OverlayEntry(
      opaque: opaque,
      maintainState: maintainState,
      builder: (context) => Material(
        type: MaterialType.transparency,
        child: Stack(
          children: [
            if (blockTouch) ModalBarrier(color: barrierColor ?? Colors.transparent, dismissible: false),
            Theme(
              data: getFlutterTheme(),
              child: AppStyle.viewWidth >= AppStyle.screenWidth
                  ? widget
                  : Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: AppStyle.maxWidth!),
                        child: widget,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  static final Map<String, OverlayEntry> _entries = {};

  static void show(String key, {params, int autoRemoveTime = 0, bool sysCanRemove = false, String? backName}) {
    pop(
      AppView.ofKey(key, params: params),
      autoRemoveTime: autoRemoveTime,
      sysCanRemove: sysCanRemove,
      backName: backName,
    );
  }

  static void popBy(String containerPath, String childKey, {params, int autoRemoveTime = 0, bool sysCanRemove = false, String? backName}) {
    Widget? childWidget = AppView.ofKey(childKey, params: params);
    pop(
      AppView.ofPath(containerPath, params: childWidget),
      autoRemoveTime: autoRemoveTime,
      sysCanRemove: sysCanRemove,
      backName: backName,
    );
  }

  static void removeByWidgetSelf(String key) {
    final entry = _entries[key];
    if (entry != null && entry.mounted) {
      entry.remove();
      _entries.remove(key);
    }
  }

  static OverlayEntry? pop(Widget? widget, {int autoRemoveTime = 0, bool sysCanRemove = false, String? backName}) {
    try {
      if (null == widget) return null;
      var view = item(widget);
      _entries[widget.key.toString()] = view;
      overlay!.insert(view);
      if (autoRemoveTime > 0) {
        Future.delayed(Duration(milliseconds: autoRemoveTime), () {
          removeOverlay(view);
        });
      }
      // 物理返回键 ： 使用最新的back_button_interceptor(7.0.0) WillPopScope 其实也无法拦截 Overlay 的返回事件 因为所处层级不同。
      if (sysCanRemove) {
        backName = backName ?? Random().nextDouble().toString();
        BackButtonInterceptor.add(name: backName, (bool stopDefaultButtonEvent, RouteInfo info) {
          removeOverlay(view);
          BackButtonInterceptor.removeByName(backName!);
          return true;
        });
      }
      return view;
    } catch (err, stack) {
      Log.e("插入Overlay 异常", error: err, stackTrace: stack);
      return null;
    }
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
    } catch (err) {
      print("插入Overlay 异常${err}");
    }
  }

  static void removeOverlay(OverlayEntry widget) {
    if (widget.mounted) widget.remove();
    _entries.removeWhere((_, v) => v == widget);
  }
}
