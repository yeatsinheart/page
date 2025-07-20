/*
Image.network(
  'https://99designs-blog.imgix.net/blog/wp-content/uploads/2022/06/Starbucks_Corporation_Logo_2011.svg-e1657703028844.png?auto=format&q=60&fit=max&w=930',
  width: 50,height: 50,fit: BoxFit.cover,
  loadingBuilder: (context, child, loadingProgress) {
    if (loadingProgress == null) return child;
    return CircularProgressIndicator();
  },
  errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image),
)
*/

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

// 自定义缓存策略，比如缓存大小100张、过期时间7天 等：
// web不支持 plugins.flutter.io/path_provider
final customCacheManager = kIsWeb
    ? null
    : CacheManager(
        Config(
          'customCacheKey',
          stalePeriod: const Duration(days: 7),
          maxNrOfCacheObjects: 100,
          repo: JsonCacheInfoRepository(databaseName: 'myCache'),
          fileService: HttpFileService(),
        ),
      );

CachedNetworkImage img(String url, err) {
  return CachedNetworkImage(
    imageUrl: url,
    httpHeaders: {
      "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36", // 伪装请求头，某些 CDN 要求
    },
    cacheManager: customCacheManager,
    fit: BoxFit.cover,
    placeholder: (context, url) => Center(
      // 圆形 且自定义颜色
      child: SizedBox(width: 30, height: 30, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white))),
    ),
    errorWidget: (context, url, error) => err ?? Icon(Icons.broken_image),
  );
}

SizedBox getUrlImg(String url, double? width, double? height, double? radius) {
  // ClipOval = ClipRRect[radius为半径时] = 圆形⭕️
  var err = SizedBox.expand(
    child: Container(
      color: Colors.grey.shade200,
      child: Icon(
        Icons.broken_image,
        color: Colors.grey,
        size: 48, // 可自适应
      ),
    ),
  );
  var item = img(url, err);
  return SizedBox(
    width: width,
    height: width,
    child: null == radius ? item : ClipRRect(borderRadius: BorderRadius.circular(radius), child: item),
  );
}

Future<void> clearMyCache() async {
  if (!kIsWeb) {
    await customCacheManager?.emptyCache();
  }
}
