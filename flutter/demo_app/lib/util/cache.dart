import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

// 自定义缓存策略，比如缓存大小、过期时间等：
final customCacheManager = CacheManager(
  Config(
    'customCacheKey',
    stalePeriod: const Duration(days: 7),
    maxNrOfCacheObjects: 100,
    repo: JsonCacheInfoRepository(databaseName: 'myCache'),
    fileService: HttpFileService(),
  ),
);
/// 缓存管理
Future _deleteImageFromCache() async {

  // await DefaultCacheManager().emptyCache();
}
// 清除某个 URL 的缓存 await DefaultCacheManager().removeFile('https://example.com/image.jpg');
// String url = "your url";
// await CachedNetworkImage.evictFromCache(url);
// DefaultCacheManager manager = new DefaultCacheManager();
// manager.emptyCache(); //clears all data in cache.
// ImageCache().clear();