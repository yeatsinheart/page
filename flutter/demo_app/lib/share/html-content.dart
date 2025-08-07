import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter3/app-style.dart';
import 'package:flutter3/log/logger.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class HtmlContent extends StatefulWidget {
  final String html;
  final String? fontSize;
  final String? fontColor;
  final String? bgColor;
  // 网页背景 默认字体大小 默认字颜色
  HtmlContent({required this.html,this.fontSize="16",this.bgColor="transparent",this.fontColor});

  @override
  State<StatefulWidget> createState() => _State();
}
// 加载后就一直存活，防止滚动后被销毁，再次加载高度出错
class _State extends State<HtmlContent> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;

  late InAppWebViewController webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings(
    // isInspectable: kDebugMode,
    iframeAllow: "camera; microphone",
    iframeAllowFullscreen: true,
    javaScriptEnabled: true, // 启用 JavaScript
    transparentBackground: true, // 背景透明（适用于某些自定义 UI）
    supportZoom: true, // 禁止双指缩放
    useShouldOverrideUrlLoading: true, // 允许拦截请求
    mediaPlaybackRequiresUserGesture: false, // 自动播放媒体（视频/音频）
    allowsInlineMediaPlayback: true, // 允许内联媒体播放
    verticalScrollBarEnabled: false, // 禁止垂直滚动条
    horizontalScrollBarEnabled: false, // 禁止水平滚动条
    disableContextMenu: true, // 禁用长按菜单（防止用户选中文字或弹出原生菜单）
    useOnLoadResource: true, // 允许使用 onLoadResource 事件
    useShouldInterceptAjaxRequest: true, // 拦截 AJAX 请求（调试或修改数据）
    useShouldInterceptFetchRequest: true, // 拦截 fetch 请求
    allowFileAccessFromFileURLs: true, // 允许本地文件访问（用于本地 HTML）
    allowUniversalAccessFromFileURLs: true, // 允许本地文件访问网络
    allowsBackForwardNavigationGestures: true, // 启用 iOS 手势返回
  );
  double contentHeight = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(kIsWeb)return Container(child: Center(child: Text("web端暂不支持"),));
    //Log.e(" color:${AppStyle.data["font"]["txt"][AppStyle.Brightness]};font-size: ${AppStyle.fontSize}px;");
    var data = wrapHtml(widget.html);
    return SizedBox(
      height: contentHeight,
        child: InAppWebView(

          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{}.toSet(), // 空集合，不响应任何手势
          initialSettings: settings,
          // initialUrlRequest:URLRequest(url: WebUri("https://inappwebview.dev/")),
          //baseUrl: WebUri("https://localhost/"),
          initialData: InAppWebViewInitialData(data: data),// ,baseUrl:WebUri("file://localhost/")
          onReceivedError: (InAppWebViewController controller, WebResourceRequest request, WebResourceError error) {
            Log.e(error);
          },
          onWebViewCreated: (controller) {
            webViewController = controller;

            // controller.loadData(
            //   data: data,
            //   baseUrl: WebUri("file://localhost/"), // 或 file:///
            //   mimeType: "text/html",
            //   encoding: "utf-8",
            // );
            // webViewController.loadData(data: data);
            // 简单轮询检测页面加载完成
            /*Future.doWhile(() async {
              var readyState = await webViewController.evaluateJavascript(source: "document.readyState");
              print("Page load $readyState");
              if (readyState == "complete") {
                print("Page loaded");
                return false; // 停止轮询
              }
              await Future.delayed(Duration(milliseconds: 100));
              return true; // 继续轮询
            });*/
            /* web运行时报错
            */
            /*webViewController.addJavaScriptHandler(
              handlerName: 'contentReady',
              callback: (args) {
                  // contentHeight = height;
                  // Log.i(contentHeight);
              },
            );*/
            webViewController.addJavaScriptHandler(
              handlerName: 'heightReady',
              callback: (args) {
                final height = double.tryParse(args.first.toString()) ?? 100;
                setState(() {
                  contentHeight = height;
                });
              },
            );
          },
          onLoadStop: (controller, url) async {

            // Web 平台不支持 addJavaScriptHandler，但可以直接用 evaluateJavascript
            //controller.evaluateJavascript(source: "console.log('Hello from Flutter Web');");
            await controller.evaluateJavascript(source: "const el = document.getElementById('server-html-content');const height = el ? el.offsetHeight : 20;console.log('window.innerWidth', window.innerWidth);console.log(document.body.clientWidth);console.log(height);");
            //var heightStr = await controller.evaluateJavascript(source: "document.body.scrollHeight.toString()");
            //Log.i(heightStr);
            //setState(() {
            //  contentHeight = double.tryParse(heightStr ?? "0")!;
            //});
            await controller.evaluateJavascript(source: """
            waitForImagesToLoad(function() {
              //window.flutter_inappwebview.callHandler('contentReady', document.documentElement.scrollHeight);
              const el = document.getElementById("server-html-content");
              const height = el ? el.offsetHeight : 20;
              console.log(height);
              window.flutter_inappwebview.callHandler('heightReady', height);
            });
          """);
          },
        ),
    );
  }

  // 否则补全
  String wrapHtml(String content) {
    final lower = content.toLowerCase();
    final hasHtmlTag = lower.contains('<html');
    final hasBodyTag = lower.contains('<body');
    if (hasHtmlTag && hasBodyTag) {
      // 已经是完整 HTML
      return content;
    }

    return '''
  <!DOCTYPE html>
  <html>
    <head>
  <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
      <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no">
      <style>
        html, body {
    width: 100%;
    max-width: 100%;
    box-sizing: border-box;margin: 0;padding: 0;
     pointer-events: none;
    user-select: none;
    -webkit-user-select: none;
    
    background-color: transparent; /* 背景色 */
    color:${AppStyle.data["font"]["txt"][AppStyle.BrightMode]};
    font-size: ${AppStyle.fontSize}px;
  }
      </style>
      
      <style>
    :root{
--ck-color-mention-background:hsla(341, 100%, 30%, 0.1);
--ck-color-mention-text:hsl(341, 100%, 30%);
}
.ck-content .mention{
background:var(--ck-color-mention-background);
color:var(--ck-color-mention-text);
}

.ck-content code{
background-color:hsla(0, 0%, 78%, 0.3);
padding:.15em;
border-radius:2px;
}

.ck-content blockquote{
overflow:hidden;
padding-right:1.5em;
padding-left:1.5em;

margin-left:0;
margin-right:0;
font-style:italic;
border-left:solid 5px hsl(0, 0%, 80%);
}

.ck-content[dir="rtl"] blockquote{
border-left:0;
border-right:solid 5px hsl(0, 0%, 80%);
}

.ck-content pre{
padding:1em;
color:hsl(0, 0%, 20.8%);
background:hsla(0, 0%, 78%, 0.3);
border:1px solid hsl(0, 0%, 77%);
border-radius:2px;
text-align:left;
direction:ltr;

tab-size:4;
white-space:pre-wrap;
font-style:normal;
min-width:200px;
}

.ck-content pre code{
background:unset;
padding:0;
border-radius:0;
}
.ck-content .text-tiny{
font-size:.7em;
}
.ck-content .text-small{
font-size:.85em;
}
.ck-content .text-big{
font-size:1.4em;
}
.ck-content .text-huge{
font-size:1.8em;
}

:root{
--ck-highlight-marker-yellow:hsl(60, 97%, 73%);
--ck-highlight-marker-green:hsl(120, 93%, 68%);
--ck-highlight-marker-pink:hsl(345, 96%, 73%);
--ck-highlight-marker-blue:hsl(201, 97%, 72%);
--ck-highlight-pen-red:hsl(0, 85%, 49%);
--ck-highlight-pen-green:hsl(112, 100%, 27%);
}

.ck-content .marker-yellow{
background-color:var(--ck-highlight-marker-yellow);
}
.ck-content .marker-green{
background-color:var(--ck-highlight-marker-green);
}
.ck-content .marker-pink{
background-color:var(--ck-highlight-marker-pink);
}
.ck-content .marker-blue{
background-color:var(--ck-highlight-marker-blue);
}

.ck-content .pen-red{
color:var(--ck-highlight-pen-red);
background-color:transparent;
}
.ck-content .pen-green{
color:var(--ck-highlight-pen-green);
background-color:transparent;
}

.ck-content hr{
margin:15px 0;
height:4px;
background:hsl(0, 0%, 87%);
border:0;
}

:root{
--ck-color-image-caption-background:hsl(0, 0%, 97%);
--ck-color-image-caption-text:hsl(0, 0%, 20%);
}
.ck-content .image > figcaption{
display:table-caption;
caption-side:bottom;
word-break:break-word;
color:var(--ck-color-image-caption-text);
background-color:var(--ck-color-image-caption-background);
padding:.6em;
font-size:.75em;
outline-offset:-1px;
}
@media (forced-colors: active){
.ck-content .image > figcaption{
background-color:unset;
color:unset;
}
}
.ck-content img.image_resized{
height:auto;
}

.ck-content .image.image_resized{
max-width:100%;
display:block;
box-sizing:border-box;
}

.ck-content .image.image_resized img{
width:100%;
}

.ck-content .image.image_resized > figcaption{
display:block;
}

:root{
--ck-image-style-spacing:1.5em;
--ck-inline-image-style-spacing:calc(var(--ck-image-style-spacing) / 2);
}

.ck-content .image.image-style-block-align-left,
.ck-content .image.image-style-block-align-right{
  max-width:calc(100% - var(--ck-image-style-spacing));
}

.ck-content .image.image-style-align-left,
.ck-content .image.image-style-align-right{
  clear:none;
}

.ck-content .image.image-style-side{
  float:right;
  margin-left:var(--ck-image-style-spacing);
  max-width:50%;
}

.ck-content .image.image-style-align-left{
  float:left;
  margin-right:var(--ck-image-style-spacing);
}

.ck-content .image.image-style-align-right{
  float:right;
  margin-left:var(--ck-image-style-spacing);
}

.ck-content .image.image-style-block-align-right{
  margin-right:0;
  margin-left:auto;
}

.ck-content .image.image-style-block-align-left{
  margin-left:0;
  margin-right:auto;
}

.ck-content .image-style-align-center{
margin-left:auto;
margin-right:auto;
}

.ck-content .image-style-align-left{
float:left;
margin-right:var(--ck-image-style-spacing);
}

.ck-content .image-style-align-right{
float:right;
margin-left:var(--ck-image-style-spacing);
}

.ck-content p + .image.image-style-align-left,
.ck-content p + .image.image-style-align-right,
.ck-content p + .image.image-style-side{
margin-top:0;
}

.ck-content .image-inline.image-style-align-left,
.ck-content .image-inline.image-style-align-right{
  margin-top:var(--ck-inline-image-style-spacing);
  margin-bottom:var(--ck-inline-image-style-spacing);
}

.ck-content .image-inline.image-style-align-left{
  margin-right:var(--ck-inline-image-style-spacing);
}

.ck-content .image-inline.image-style-align-right{
  margin-left:var(--ck-inline-image-style-spacing);
}

.ck-content .image{
display:table;
clear:both;
text-align:center;
margin:0.9em auto;
min-width:50px;
}

.ck-content .image img{
  display:block;
  margin:0 auto;
  max-width:100%;
  min-width:100%;
  height:auto;
}

.ck-content .image-inline{
display:inline-flex;
max-width:100%;
align-items:flex-start;
}

.ck-content .image-inline picture{
  display:flex;
}

.ck-content .image-inline picture,
.ck-content .image-inline img{
  flex-grow:1;
  flex-shrink:1;
  max-width:100%;
}

.ck-content ol{
list-style-type:decimal;
}

.ck-content ol ol{
list-style-type:lower-latin;
}

.ck-content ol ol ol{
  list-style-type:lower-roman;
}

.ck-content ol ol ol ol{
    list-style-type:upper-latin;
  }

.ck-content ol ol ol ol ol{
      list-style-type:upper-roman;
    }

.ck-content ul{
list-style-type:disc;
}

.ck-content ul ul{
list-style-type:circle;
}

.ck-content ul ul ul{
  list-style-type:square;
}

.ck-content ul ul ul ul{
    list-style-type:square;
  }

:root{
--ck-todo-list-checkmark-size:16px;
}
.ck-content .todo-list{
list-style:none;
}
.ck-content .todo-list li{
position:relative;
margin-bottom:5px;
}
.ck-content .todo-list li .todo-list{
  margin-top:5px;
}
.ck-content .todo-list .todo-list__label > input{
  -webkit-appearance:none;
  display:inline-block;
  position:relative;
  width:var(--ck-todo-list-checkmark-size);
  height:var(--ck-todo-list-checkmark-size);
  vertical-align:middle;
  border:0;
  left:-25px;
  margin-right:-15px;
  right:0;
  margin-left:0;
}
.ck-content[dir=rtl] .todo-list .todo-list__label > input{
left:0;
margin-right:0;
right:-25px;
margin-left:-15px;
}
.ck-content .todo-list .todo-list__label > input::before{
display:block;
position:absolute;
box-sizing:border-box;
content:'';
width:100%;
height:100%;
border:1px solid hsl(0, 0%, 20%);
border-radius:2px;
transition:250ms ease-in-out box-shadow;
}
@media (prefers-reduced-motion: reduce){
.ck-content .todo-list .todo-list__label > input::before{
  transition:none;
}
}
.ck-content .todo-list .todo-list__label > input::after{
display:block;
position:absolute;
box-sizing:content-box;
pointer-events:none;
content:'';
left:calc( var(--ck-todo-list-checkmark-size) / 3);
top:calc( var(--ck-todo-list-checkmark-size) / 5.3);
width:calc( var(--ck-todo-list-checkmark-size) / 5.3);
height:calc( var(--ck-todo-list-checkmark-size) / 2.6);
border-style:solid;
border-color:transparent;
border-width:0 calc( var(--ck-todo-list-checkmark-size) / 8) calc( var(--ck-todo-list-checkmark-size) / 8) 0;
transform:rotate(45deg);
}
.ck-content .todo-list .todo-list__label > input[checked]::before{
  background:hsl(126, 64%, 41%);
  border-color:hsl(126, 64%, 41%);
}
.ck-content .todo-list .todo-list__label > input[checked]::after{
  border-color:hsl(0, 0%, 100%);
}
.ck-content .todo-list .todo-list__label .todo-list__label__description{
  vertical-align:middle;
}
.ck-content .todo-list .todo-list__label.todo-list__label_without-description input[type=checkbox]{
  position:absolute;
}

.ck-content .media{
clear:both;
margin:0.9em 0;
display:block;
min-width:15em;
}

.ck-content .page-break{
position:relative;
clear:both;
padding:5px 0;
display:flex;
align-items:center;
justify-content:center;
}

.ck-content .page-break::after{
content:'';
position:absolute;
border-bottom:2px dashed hsl(0, 0%, 77%);
width:100%;
}

.ck-content .page-break__label{
position:relative;
z-index:1;
padding:.3em .6em;
display:block;
text-transform:uppercase;
border:1px solid hsl(0, 0%, 77%);
border-radius:2px;
font-family:Helvetica, Arial, Tahoma, Verdana, Sans-Serif;
font-size:0.75em;
font-weight:bold;
color:hsl(0, 0%, 20%);
background:hsl(0, 0%, 100%);
box-shadow:2px 2px 1px hsla(0, 0%, 0%, 0.15);
-webkit-user-select:none;
-moz-user-select:none;
-ms-user-select:none;
user-select:none;
}
@media print{
.ck-content .page-break{
padding:0;
}

.ck-content .page-break::after{
  display:none;
}
.ck-content *:has(+ .page-break){
margin-bottom:0;
}
}

.ck-content .table{
margin:0.9em auto;
display:table;
}

.ck-content .table table{
border-collapse:collapse;
border-spacing:0;
width:100%;
height:100%;
border:1px double hsl(0, 0%, 70%);
}

.ck-content .table table td,
.ck-content .table table th{
  min-width:2em;
  padding:.4em;
  border:1px solid hsl(0, 0%, 75%);
}

.ck-content .table table th{
  font-weight:bold;
  background:hsla(0, 0%, 0%, 5%);
}
@media print{
.ck-content .table table{
height:initial;
}
}
.ck-content[dir="rtl"] .table th{
text-align:right;
}

.ck-content[dir="ltr"] .table th{
text-align:left;
}

:root{
--ck-color-selector-caption-background:hsl(0, 0%, 97%);
--ck-color-selector-caption-text:hsl(0, 0%, 20%);
}
.ck-content .table > figcaption{
display:table-caption;
caption-side:top;
word-break:break-word;
text-align:center;
color:var(--ck-color-selector-caption-text);
background-color:var(--ck-color-selector-caption-background);
padding:.6em;
font-size:.75em;
outline-offset:-1px;
}
@media (forced-colors: active){
.ck-content .table > figcaption{
background-color:unset;
color:unset;
}
}

.ck-content .table .ck-table-resized{
table-layout:fixed;
}

.ck-content .table table{
overflow:hidden;
}

.ck-content .table td,
.ck-content .table th{
overflow-wrap:break-word;
position:relative;
}

.ck-content{
line-height: 1.43;
}
.ck-content p{

margin: 0;
padding: 0;
border: 0;
display: block;
/*margin-block-start: 1em;
margin-block-end: 1em;
margin-inline-start: 0px;
margin-inline-end: 0px;*/
unicode-bidi: isolate;
}

.ck-content ol,
.ck-content ul{
display: block;
margin-block-start: 1em;
margin-block-end: 1em;
margin-inline-start: 0;
margin-inline-end: 0;
padding-inline-start: .5rem;
unicode-bidi: isolate;
}

.ck-content ol,.ck-content ol>li {
list-style-type: decimal;
}
.ck-content ul,.ck-content ul>li {
list-style-type: disc;
}
  </style>
      
    </head>
    <script>
    function waitForImagesToLoad(callback) {
              const images = Array.from(document.images);
              if (images.length === 0) {
                callback();
                return;
              }
              let loaded = 0;
              images.forEach((img) => {
                if (img.complete) {
                  loaded++;
                } else {
                  img.addEventListener('load', () => {
                    loaded++;
                    if (loaded === images.length) callback();
                  });
                  img.addEventListener('error', () => {
                    loaded++;
                    if (loaded === images.length) callback();
                  });
                }
              });
              if (loaded === images.length) callback();
            }
            
            window.onload = function () {
    waitForImagesToLoad(function() {
              //window.flutter_inappwebview.callHandler('contentReady', document.documentElement.scrollHeight);
              // const el = document.getElementById("server-html-content");
              // const height = el ? el.offsetHeight : 20;
              // console.log(height);
              window.flutter_inappwebview.callHandler('contentReady', '');
            });
            };
            </script>
            
    <body><div id="server-html-content" class="ck-content">
      $content
    </div></body>
    
  </html>
  ''';
  }
}
