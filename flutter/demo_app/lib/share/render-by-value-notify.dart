import 'package:flutter/material.dart';
/*
final xxx = ValueNotifier<int>(1);//定义加载中
//方法中回调设置
xxx.value=2;
xxx.value=0;
RenderByValueNotify<int>(notifier:xxx,render:(value){return Container()});
* */

class RenderByValueNotify<T> extends StatelessWidget {
  final Widget Function(T value) render;
  final ValueNotifier<T> notifier;

  RenderByValueNotify({required this.notifier,required this.render,super.key});

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
