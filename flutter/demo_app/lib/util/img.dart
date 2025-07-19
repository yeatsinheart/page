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
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// 自定义缓存策略，比如缓存大小100张、过期时间7天 等：
// web不支持 plugins.flutter.io/path_provider
final customCacheManager = kIsWeb?null:CacheManager(
  Config(
    'customCacheKey',
    stalePeriod: const Duration(days: 7),
    maxNrOfCacheObjects: 100,
    repo: JsonCacheInfoRepository(databaseName: 'myCache'),
    fileService: HttpFileService(),
  ),
);

getUrlImg(String url,double width,double height){
  return Container(width: width, height: width, child:CachedNetworkImage(
    imageUrl: url,
    cacheManager: customCacheManager,
    fit: BoxFit.cover,
    placeholder: (context, url) => CircularProgressIndicator(),
    errorWidget: (context, url, error) => Icon(Icons.broken_image),
  ));
}

Future<void> clearMyCache() async {
  if (!kIsWeb) {
    await customCacheManager?.emptyCache();
  }
}
