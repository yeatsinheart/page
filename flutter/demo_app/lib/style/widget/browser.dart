import 'package:flutter/material.dart';
import 'package:flutter3/style/app-style.dart';
import 'package:flutter3/style/format/container.dart';
import 'package:flutter3/style/theme/all-theme.dart';

class Browser extends StatelessWidget {
  final child;

  const Browser(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    Widget page = ContainerFormat("page", child);
    return ContainerFormat(
      "browser",
      Theme(
        data: getFlutterTheme(),
        child: AppStyle.maxWidth == null
            ? page
            : Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: AppStyle.maxWidth!),
                  child: page,
                ),
              ),
      ),
    );
  }
}
