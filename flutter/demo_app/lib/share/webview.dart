import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter3/share/webview-html-template.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter3/app-style.dart';

class NativeWebView {
  static const _channel = MethodChannel('com.example/native_webview');

  static Future<void> open(String url) async {
    await _channel.invokeMethod('openWebView', {'url': url});
  }

  static Future<void> openContent({String? url, String? html, String? title}) async {
    await _channel.invokeMethod('openWebView', {'url': url, 'html': html, 'title': title});
  }
}

class WebView extends StatefulWidget {
  final String? url;

  // get post-form post-json
  final String? type;
  final Map<String, dynamic>? body;
  final Map<String, String>? header;

  final String? html;
  final double initHeight;
  final bool dynamicHeight;

  final String? fontSize;
  final String? fontColor;
  final String? bgColor;

  WebView({
    this.url,
    this.type = "get",
    this.header = const {},
    this.body,

    this.html,
    this.fontSize = "16",
    this.bgColor = "transparent",
    this.fontColor,
    double? initHeight,
    this.dynamicHeight = false,
    Key? key,
  }) : initHeight = initHeight ?? AppStyle.screenHeight,
       super(key: key);

  @override
  State<WebView> createState() => _HtmlContentState();
}

class _HtmlContentState extends State<WebView> with AutomaticKeepAliveClientMixin {
  late final WebViewController _controller;
  double contentHeight = AppStyle.screenHeight;
  final Completer<WebViewController> _controllerCompleter = Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    contentHeight = widget.initHeight;
    if (kIsWeb) {return;}
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..addJavaScriptChannel(
        'HeightHandler',
        onMessageReceived: (message) {
          if (widget.dynamicHeight) {
            final height = double.tryParse(message.message);
            if (height != null && height > 0) {
              setState(() {
                contentHeight = height;
              });
            }
          }
        },
      );
    if (null != widget.html) {
      _controller.loadHtmlString(html_template_wrap(widget.html!, fontSize: widget.fontSize, fontColor: widget.fontColor, bgColor: widget.bgColor));
    } else if (null != widget.url) {
      LoadRequestMethod requestMethod = LoadRequestMethod.get;
      Uint8List? body;
      Map<String, String> headers = Map.from(widget.header??{});
      switch (widget.type?.toLowerCase()) {
        case "get":
          body = null;
          break;
        case "post-json":
          requestMethod = LoadRequestMethod.post;
          body = _body_post_json_format(widget.body);
          headers.putIfAbsent('Content-Type', () => 'application/json');
          break;
        case "post-form":
          requestMethod = LoadRequestMethod.post;
          body = _body_post_form_formate(widget.body);
          headers.putIfAbsent('Content-Type', () => 'application/x-www-form-urlencoded');
          break;
        default://就是get
          body = null;
          break;
      }
      _controller.loadRequest(Uri.parse(widget.url!), method: requestMethod, headers: headers, body: body);
    }
    // 在 WebView 加载完成回调里更新状态
    _controller.setNavigationDelegate(
      NavigationDelegate(
        onPageFinished: (_) async {
          final canGoBack = await _controller.canGoBack();
          setState(() {
            _canGoBack = canGoBack;
          });
          await _controller.runJavaScript(all_loaded());
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool _canGoBack = false;

  void _handlePop(bool didPop, Object? result) {
    // didPop: 系统尝试pop时为true
    if (didPop) {
      // 已经pop了，什么都不用做
      return;
    }
    if (_canGoBack) {
      // 如果WebView可以后退，就让WebView后退，不退出页面
      _controller.goBack();
    } else {
      // WebView不能后退，允许页面退出
      //Navigator.of(context).pop(result);
    }
    _controller.goBack();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (kIsWeb) {
      return Center(child: Text("网页版暂不支持"));
    }
    return SizedBox(
      width: double.infinity,
      height: contentHeight,
      child: PopScope(
        canPop: false, // <- 这行是关键！
        onPopInvokedWithResult: _handlePop,
        child: WebViewWidget(controller: _controller),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

// 把 Map<String, dynamic> 编成 application/x-www-form-urlencoded 格式的 Uint8List
Uint8List? _body_post_form_formate(Map<String, dynamic>? body) {
  if (null == body) return null;
  final encoded = body.entries
      .map((e) {
        String valueStr;
        if (e.value == null) {
          valueStr = '';
        } else if (e.value is String || e.value is num || e.value is bool) {
          valueStr = e.value.toString();
        } else {
          // 复杂对象转成JSON字符串
          valueStr = json.encode(e.value);
        }
        return '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(valueStr)}';
      })
      .join('&');
  return Uint8List.fromList(utf8.encode(encoded));
}

Uint8List? _body_post_json_format(Map<String, dynamic>? body) {
  if (body == null) return null;
  final jsonString = json.encode(body);
  return Uint8List.fromList(utf8.encode(jsonString));
}
