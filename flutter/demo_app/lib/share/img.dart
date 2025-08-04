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
  return SizedBox.expand(
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
          ),
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

Future<void> clearMyCache() async {
  if (!kIsWeb) {
    await customCacheManager?.emptyCache();
  }
}
/*
在 Flutter 中实现“背景过渡遮罩”或“统一滤镜风格”的方式有几种，以下是常用实现方式，适合亮暗模式下对图片进行视觉适配：
🎯 目标
背景图片在 Dark Mode 下不要太刺眼
给图片加一层 半透明遮罩
或者统一加个 色调滤镜 让风格一致
✅ 方法一：加遮罩（适合背景图）
Stack(
  children: [
    Image.asset(
      'assets/bg.jpg',
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    ),
    Container(
      color: Theme.of(context).brightness == Brightness.dark
        ? Colors.black.withOpacity(0.4)
        : Colors.transparent,
    ),
    // 其他子组件在上层...
  ],
)
✅ 说明：
在暗色模式下，给背景图加 黑色半透明 遮罩；
Stack 实现遮罩覆盖。
✅ 方法二：统一滤镜（ColorFiltered）
ColorFiltered(
  colorFilter: Theme.of(context).brightness == Brightness.dark
      ? ColorFilter.mode(Colors.grey.shade700, BlendMode.multiply)
      : ColorFilter.mode(Colors.transparent, BlendMode.multiply),
  child: Image.asset('assets/bg.jpg'),
)
✅ 效果：
在 dark 模式下让图变暗/变冷色调；
可结合 BlendMode 实现不同视觉效果（如柔和、变暗、偏冷）；
滤镜适合照片、插图等统一风格处理。

✅ 方法三：使用 BackdropFilter + ImageFiltered（更复杂的模糊/叠加风格）
Stack(
  children: [
    Image.asset('assets/bg.jpg'),
    Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
        child: Container(color: Colors.black.withOpacity(0.2)),
      ),
    ),
  ],
)
🔍 适用于做毛玻璃/柔和效果，但性能稍重。
💡 小技巧（适配多图）
🧪 推荐遮罩透明度对比参考
场景	遮罩颜色	透明度建议
暗色模式背景图	Colors.black	0.2 - 0.4
强光图片过渡	Colors.black54	0.3 - 0.5
冷色调风格统一	Colors.blueGrey	0.1 - 0.3 + 滤镜

如果你有具体图片类型或想做具体滤镜风格（比如暗调蓝冷风、漫画风等），我可以帮你细化滤镜调配。你想尝试哪一种？
* */