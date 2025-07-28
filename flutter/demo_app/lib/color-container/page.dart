import 'package:flutter/material.dart';
import 'package:flutter3/color-container/app-style.dart';
import 'package:flutter3/color-container/color-util.dart';
import 'package:flutter3/color-container/container.dart';
import 'package:flutter3/share/context.dart';

class AppPage extends StatelessWidget {
  final child;

  const AppPage(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold 会有自带颜色 遮盖了页面
    return AppContainer("page", child);
  }
}
