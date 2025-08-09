import 'package:flutter/material.dart';
/*
ValueNotifier<bool> loading = ValueNotifier(true);//定义加载中
//方法中回调设置
loading.value=true;
loading.value=false;
Loading(child:Container(),loading);
* */

class RenderByValueNotify<T> extends StatelessWidget {
  final Function(T value) render;
  final ValueNotifier<T> notifier;

  RenderByValueNotify({required this.notifier,required this.render});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<T>(
      valueListenable: notifier,
      builder: (BuildContext context, T value, Widget? _child) {
        return render(value);
      },
    );
  }
}
