import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter3/style/color-plan.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';

class AppImg extends StatelessWidget {
  final String url;
  final double? square;
  final double? width;
  final double? height;
  final double? radius;
  final BoxFit? fit;
  final Color? loadingBg;
  final Color? loadingColor;

  AppImg(this.url, {this.square, this.width, this.height, this.radius, this.fit = BoxFit.cover, Color? loadingBg, Color? loadingColor, super.key}) : this.loadingColor = ColorPlan.get("img-loading").font, this.loadingBg = ColorPlan.get("img-loading").bg;

  @override
  Widget build(BuildContext context) {
    // ClipOval = ClipRRect[radius为半径时] = 圆形⭕️
    final image = img(url, fit: fit!, loadingBg: loadingBg, loadingColor: loadingColor!);
    var item = null != radius ? ClipRRect(borderRadius: BorderRadius.circular(radius!), child: image) : image;

    final effectiveWidth = square ?? width;
    final effectiveHeight = square ?? height;
    if (effectiveWidth == null && effectiveHeight == null) return item;
    return SizedBox(width: effectiveWidth, height: effectiveHeight, child: item);
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
      child: Icon(Icons.broken_image, color: loadingColor),
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

Widget img(String url, {BoxFit? fit, Color? loadingBg, Color? loadingColor}) {
  String resource = url.tr;
  // web方式会自动加前缀/assets 所以浏览器运行，需要移除
  if (kIsWeb && resource.startsWith("assets/")) {
    resource = resource.substring(7);
  }
  return SizedBox.expand(
    child: url.startsWith('http')
        ? CachedNetworkImage(
            imageUrl: url.tr,
            httpHeaders: {
              "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36", // 伪装请求头，某些 CDN 要求
            },
            cacheManager: customCacheManager,
            useOldImageOnUrlChange: true,
            fit: fit,
            alignment: Alignment.center,
            placeholder: (context, url) => Container(color: loadingBg, alignment: Alignment.center, child: _loadingWidget(loadingColor)),
            errorWidget: (context, url, error) => Container(color: loadingBg, alignment: Alignment.center, child: _errWidget(loadingColor)),
          )
        : FutureBuilder(
            future: rootBundle.load(resource),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                return Image.asset(resource, fit: fit);
              } else if (snapshot.hasError) {
                return Container(color: loadingBg, alignment: Alignment.center, child: _errWidget(loadingColor));
              } else {
                return Container(color: loadingBg, alignment: Alignment.center, child: _loadingWidget(loadingColor));
              }
            },
          ),
  );
}

Future<void> clearMyCache() async {
  if (!kIsWeb) {
    await customCacheManager?.emptyCache();
  }
}
