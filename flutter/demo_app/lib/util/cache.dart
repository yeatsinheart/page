import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Obtain shared preferences.
// Android	SharedPreferences	DataStore Preferences or SharedPreferences
// iOS	NSUserDefaults	NSUserDefaults
// Linux	In the XDG_DATA_HOME directory	In the XDG_DATA_HOME directory
// macOS	NSUserDefaults	NSUserDefaults
// Web	LocalStorage	LocalStorage
// Windows	In the roaming AppData directory	In the roaming AppData directory
// 不存在将返回null
// final SharedPreferences prefs = await SharedPreferences.getInstance();
// final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
// prefs.containsKey("counter");
// // Save an integer value to 'counter' key.
// await prefs.setInt('counter', 10);
// // Save an boolean value to 'repeat' key.
// await prefs.setBool('repeat', true);
// // Save an double value to 'decimal' key.
// await prefs.setDouble('decimal', 1.5);
// // Save an String value to 'action' key.
// await prefs.setString('action', 'Start');
// // Save an list of strings to 'items' key.
// await prefs.setStringList('items', <String>['Earth', 'Moon', 'Sun']);
//
// // Try reading data from the 'counter' key. If it doesn't exist, returns null.
// final int? counter = prefs.getInt('counter');
// // Try reading data from the 'repeat' key. If it doesn't exist, returns null.
// final bool? repeat = prefs.getBool('repeat');
// // Try reading data from the 'decimal' key. If it doesn't exist, returns null.
// final double? decimal = prefs.getDouble('decimal');
// // Try reading data from the 'action' key. If it doesn't exist, returns null.
// final String? action = prefs.getString('action');
// // Try reading data from the 'items' key. If it doesn't exist, returns null.
// final List<String>? items = prefs.getStringList('items');
//
// // Remove data for the 'counter' key.
// await prefs.remove('counter');

// Any time a filter option is included as a method parameter, strongly consider
// using it to avoid potentially unwanted side effects.
// await prefs.clear(allowList: <String>{'action', 'repeat'});

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