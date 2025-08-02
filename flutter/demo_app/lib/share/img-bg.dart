import 'package:flutter/material.dart';
import 'package:flutter3/share/img.dart';

class ImgBg extends StatelessWidget {
  final url;
  final child;
  final double? radiusRem;
  final BoxFit? fit;
  const ImgBg(this.url, this.child, {this.radiusRem,this.fit, super.key});

  @override
  Widget build(BuildContext context) {
    return null == url
        ? child
        : Stack(
            children: [
              Positioned.fill(
                child: AppImg(url!, radiusRem: radiusRem, fit:fit,loadingBg: Colors.transparent, loadingFont: Colors.transparent),
              ),
              child,
            ],
          );
  }
}
