import 'package:flutter/material.dart';
import 'package:flutter3/style/app-style.dart';
import 'package:flutter3/style/container.dart';

class Browser extends StatelessWidget {
  final child;

  const Browser(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    Widget page = AppContainer("page", child);
    return AppContainer(
      "browser",
      AppStyle.maxWidth == null
          ? page
          : Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: AppStyle.maxWidth!),
                child: page,
              ),
            ),
    );
  }
}
