import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter3/store/app.dart';
import 'package:flutter3/util/color-util.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';

class AppImg extends StatelessWidget {
  final String url;

  final double? square;
  final double? width;
  final double? height;
  final double? borderRadius;

  final BoxFit? fit;
  final Color? loadingBg;
  final Color? loadingFont;

  AppImg(this.url, {this.square, this.width, this.height, this.borderRadius, this.fit = BoxFit.cover, Color? this.loadingBg, Color? this.loadingFont, super.key});

  @override
  Widget build(BuildContext context) {
    // ClipOval = ClipRRect[radius为半径时] = 圆形⭕️
    Map<String, dynamic>? data = AppStore.data["color-plan"]?["img-loading"] ?? {};
    Color? bgColor = ColorUtil.getColor(data?["bg"]?[AppStore.Brightness]);
    Color? fontColor = ColorUtil.getColor(data?["font"]?[AppStore.Brightness]);

    final raw_image = img(url, fit: fit!, loadingBg: loadingBg ?? bgColor, loadingFont: loadingFont ?? fontColor);
    //Log.i(radiusRem);
    var clipped_image = (null != borderRadius ? ClipRRect(borderRadius: BorderRadius.circular(borderRadius!), child: raw_image) : raw_image);

    final effectiveWidth = square ?? width;
    final effectiveHeight = square ?? height;
    // 没有宽高限制
    if (effectiveWidth == null && effectiveHeight == null) return clipped_image;

    return SizedBox(width: effectiveWidth, height: effectiveHeight, child: clipped_image);
  }
}

final customCacheManager = kIsWeb
    ? null
    : CacheManager(
        Config(
          'AppImg',
          stalePeriod: const Duration(days: 7),
          maxNrOfCacheObjects: 5000,
          repo: JsonCacheInfoRepository(databaseName: 'myCache'),
          fileService: HttpFileService(),
        ),
      );

_errWidget(loadingColor) => AspectRatio(
  aspectRatio: 1,
  child: FractionallySizedBox(
    widthFactor: 0.36, // 占正方体宽度的 25%
    heightFactor: 0.36,
    child: FittedBox(
      fit: BoxFit.contain,
      child: Icon(Icons.image, color: loadingColor),
      // child: Icon(Icons.broken_image, color: loadingColor),
    ),
  ),
);

_loadingWidget(loadingColor) => AspectRatio(
  aspectRatio: 1,
  child: FractionallySizedBox(
    widthFactor: 0.36, // 占正方体宽度的 25%
    heightFactor: 0.36,
    child: LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        // 动态计算 + 限制最小最大
        double strokeWidth = width * 0.03;
        double minStrokeWidth = 2.0;
        double maxStrokeWidth = 8.0;
        strokeWidth = strokeWidth.clamp(minStrokeWidth, maxStrokeWidth);
        return CircularProgressIndicator(strokeWidth: strokeWidth, valueColor: AlwaysStoppedAnimation<Color>(loadingColor));
      },
    ),
  ),
);

Widget img(String url, {BoxFit? fit, Color? loadingBg, Color? loadingFont}) {
  String resource = url.tr;
  // web方式会自动加前缀/assets 所以浏览器运行，需要移除
  if (kIsWeb && resource.startsWith("assets/")) {
    resource = resource.substring(7);
  }
  return _darkFilter(SizedBox.expand(
    child: url.startsWith('http')
        ? CachedNetworkImage(
            fadeOutDuration: const Duration(milliseconds: 200),
            fadeInDuration: const Duration(milliseconds: 200),
            imageUrl: url.tr,
            httpHeaders: {
              "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36", // 伪装请求头，某些 CDN 要求
            },
            cacheManager: customCacheManager,
            useOldImageOnUrlChange: true,
            fit: fit,
            alignment: Alignment.center,
            placeholder: (context, url) => Container(color: loadingBg, alignment: Alignment.center, child: _loadingWidget(loadingFont)),
            errorWidget: (context, url, error) => Container(color: loadingBg, alignment: Alignment.center, child: _errWidget(loadingFont)),
          )
        : Image.asset(
            resource,
            fit: fit,
            errorBuilder: (context, error, stackTrace) => Container(color: loadingBg, alignment: Alignment.center, child: _errWidget(loadingFont)),
          ),)
    // FutureBuilder(
    //   future: rootBundle.load(resource),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
    //       return Image.asset(resource, fit: fit);
    //     } else if (snapshot.hasError) {
    //       return Container(color: loadingBg, alignment: Alignment.center, child: _errWidget(loadingFont));
    //     } else {
    //       return Container(color: loadingBg, alignment: Alignment.center, child: _loadingWidget(loadingFont));
    //     }
    //   },
    // ),
  );
}

// ✅ 方法二：统一滤镜（ColorFiltered）使用颜色矩阵（ColorMatrix）或自定义 ColorFilter 实现亮度压暗
_darkFilter(img){
  if(AppStore.Brightness=="light")return img;
  return ColorFiltered(
    // 所有 RGB 通道都被乘以 0.6（压暗约 40%）
    colorFilter: const ColorFilter.matrix(<double>[
      0.6, 0,   0,   0, 0,  // R channel
      0,   0.6, 0,   0, 0,  // G channel
      0,   0,   0.6, 0, 0,  // B channel
      0,   0,   0,   1, 0,  // A channel stays the same
    ]),
    // 这种方式透明会变白
    // ColorFilter.mode(Colors.grey.shade700, BlendMode.multiply),//将灰色与图像颜色通过 multiply 模式叠加 色彩会“变脏”，有点 desaturate（去饱和）
    child: img,
  );
}
//✅ 方法三：使用 BackdropFilter + ImageFiltered（更复杂的模糊/叠加风格） 模糊背景内容的一个组件，常用于实现「毛玻璃」或「背景虚化」效果。
//🔍 适用于做毛玻璃/柔和效果，但性能稍重。
//💡 小技巧（适配多图）
_blurFilter(img){
  if(AppStore.Brightness=="light")return img;
  return
    Stack(
      children: [
        img,
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
            child: Container(color: Colors.black.withValues(alpha: 0.2)),
          ),
        ),
      ],
    );
}

Future<void> clearMyCache() async {
  if (!kIsWeb) {
    await customCacheManager?.emptyCache();
  }
}