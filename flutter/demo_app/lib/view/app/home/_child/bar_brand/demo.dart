import 'package:flutter/material.dart';
import 'package:flutter3/style/app-style.dart';
import 'package:flutter3/style/format/container.dart';
import 'package:flutter3/view/app/home/_child/bar_brand_left/demo.dart';
import 'package:flutter3/view/app/home/_child/bar_brand_right/demo.dart';

class BarBrandDemo extends StatelessWidget {
  final dynamic params;

  const BarBrandDemo({this.params, super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerFormat(
      "bar-brand",Row(children: [BarBrandLeftDemo(), Spacer(), BarBrandRightDemo()]),
    );
  }
}
