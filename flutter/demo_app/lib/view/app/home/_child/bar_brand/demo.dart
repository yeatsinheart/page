import 'package:flutter/material.dart';
import 'package:flutter3/view/app/home/_child/bar_brand_left/demo.dart';
import 'package:flutter3/view/app/home/_child/bar_brand_right/demo.dart';

class BarBrandDemo extends StatelessWidget {
  final dynamic params;

  const BarBrandDemo({this.params, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: Colors.white,
      child: Row(children: [BarBrandLeftDemo(), Spacer(), BarBrandRightDemo()]),
    );
  }
}
