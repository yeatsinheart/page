import 'package:flutter/material.dart';
import 'package:flutter3/share/img.dart';
import 'package:flutter3/style/rem.dart';

class ImgBg extends StatelessWidget {
  final url;
  final child;
  final double? borderRadius;
  final BoxFit? fit;
  const ImgBg(this.url, this.child, {this.borderRadius,this.fit, super.key});

  @override
  Widget build(BuildContext context) {
    return null == url
        ? child
        : Stack(
            children: [
              Positioned.fill(
                child: AppImg(url!, borderRadius: borderRadius, fit:fit,loadingBg: Colors.transparent, loadingFont: Colors.transparent),
              ),
              child,
            ],
          );
  }
}
