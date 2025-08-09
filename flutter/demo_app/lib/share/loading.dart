import 'package:flutter/material.dart';
import 'package:flutter3/share/render-by-value-notify.dart';
/*
ValueNotifier<bool> loading = ValueNotifier(true);//定义加载中
//方法中回调设置
loading.value=true;
loading.value=false;

Loading(child:Container(),loading);
* */

class Loading<bool> extends StatelessWidget {
  final Widget child;
  final ValueNotifier<bool> notifier;

  Loading({required this.child, required this.notifier,super.key});

  @override
  Widget build(BuildContext context) {
    return RenderByValueNotify<bool>(
      notifier: notifier,
      render: (value) {
        if (value == true) {
          return child;
        }
        return SizedBox.expand(
          child: Container(child: Center(child: CircularProgressIndicator())),
        );
      },
    );
  }
}
