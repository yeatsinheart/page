import 'package:flutter/material.dart';
import 'package:flutter3/share/img.dart';

class ImgBg extends StatelessWidget {
  final url;
  final child;

  const ImgBg(this.url, this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return null == url
        ? child
        : Stack(
            children: [
              Positioned.fill(
                child: AppImg(url!, loadingBg: Colors.transparent, loadingColor: Colors.transparent),
              ),
              child,
            ],
          );
  }
}
