import 'dart:convert';
import 'dart:io';

var setting = {
  "browser": container(
    bgGradient: gradient_linear(colors: ["#81FFEF", "#F067B4"], stops: [0.1, 1], begin: top_right, end: bottom_left),
  ),
  "page": container(
    padding: Padding(top: 0),
    bgGradient: gradient_linear(colors: ["#7ec1f7", "#FFF"], stops: [0, .8], begin: top_right, end: bottom_left),
  ),
  "color1": container(bg: "#2196F3", font: "#fff"),
  "color1-reverse": container(
    bg: "#2196F3",
    border: Border(color: "#2196F3"),
  ),
  "img-loading": container(bg: "#e0e0e0", font: "#fff"),
  "marquee": container(padding: Padding(left: 0.2, right: 0.2), bg: "transparent", font: "#000"),
  "game-category-tab": container(bg: "#fff", font: "#000"),
  "txt-cover": container(
    bgGradient: gradient_linear(colors: ["#0000004d", "transparent"], stops: [0, .8], begin: bottom_center, end: top_center),
    font: "#fff",
  ),

  "bar": container(bg: "#3f15d1", font: "#000"),
  "bar-brand": container(bg: "#FF403A", font: "#FFF"),
  "bar-bottom": container(
    bgGradient: gradient_linear(colors: ["#7ec1f7", "FFF"], stops: [0, .8], begin: bottom_center, end: top_center),
    font: "#fff",
  ),
};

main() async {
  print(jsonEncode(setting));
  // 同步到配置文件中 方便调试
  String path = 'assets/config/bootstrap.json';
  final json = await readJsonFile(path);
  json["style"]["container-setting"] = setting;
  final file = File(path);
  await file.writeAsString(JsonEncoder.withIndent('  ').convert(json));
  print('✅ $path updated successfully');
}

container({String? img, Padding? padding, String? bg, bgGradient, String? font, Border? border, double? radius, Shadow? shadow}) {
  if (radius != null && radius > 7.5) radius = 0;
  final result = <String, dynamic>{};
  if (img != null) result["img"] = img;
  if (padding != null) result["padding"] = padding.toJson();
  if (bg != null) result["bg"] = bg;
  if (bgGradient != null) result["bgGradient"] = bgGradient;
  if (font != null) result["font"] = font;
  if (border != null) result["border"] = border.toJson();
  if (radius != null) result["radius"] = radius;
  if (shadow != null) result["shadow"] = shadow.toJson();
  return result;
}

class Shadow {
  String? color;
  double? blurRadius = 6;
  double? spreadRadius = 2;
  List<double>? offset = [0, 3];
  String? blurStyle = "normal";// normal solid outer inner

  Shadow({String? color, double blurRadius = 2, double spreadRadius = 6, List<double> offset = const [0, 3], String blurStyle = "normal"}) {
    if (offset.length != 2) return;
    this.color = color;
    this.blurRadius = blurRadius;
    this.spreadRadius = spreadRadius;
    this.offset = offset;
    this.blurStyle = blurStyle;
  }

  Map<String, dynamic> toJson() => {'color': color, 'blurRadius': blurRadius, 'spreadRadius': spreadRadius, 'offset': offset, 'blurStyle': blurStyle};
}

class Padding {
  double? top = 0;
  double? left = 0;
  double? bottom = 0;
  double? right = 0;

  // 以 rem为准 7.5rem=100%；
  Padding({double top = 0, double left = 0, double bottom = 0, double right = 0}) {
    if (top > 7.5) this.top = 0;
    if (left > 7.5) this.left = 0;
    if (bottom > 7.5) this.bottom = 0;
    if (right > 7.5) this.right = 0;
  }

  Map<String, dynamic> toJson() => {'top': top, 'left': left, 'bottom': bottom, 'right': right};
}

class Border {
  // 默认边框在容器内部 这样容器的大小可预估。
  String? color;
  double? width = 1;

  // 以 rem为准 7.5rem=100%；
  Border({String? color, double width = 1}) {
    if (width > 0) this.width = width;
    if (color != null) this.color = color;
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};
    if (color != null) result["color"] = color;
    if (width != null) result["width"] = width;
    return result;
  }
}

// begin end :屏幕中心为[0,0] 屏幕左上角为[-1,-1] 屏幕右下角为[1,1] 在-1到1之间确定一个值
List<double> top_left = [-1, -1];
List<double> top_center = [0, -1];
List<double> top_right = [1, -1];
List<double> center = [0, 0];
List<double> bottom_left = [-1, 1];
List<double> bottom_center = [0, 1];
List<double> bottom_right = [1, 1];

gradient_linear({List<String>? colors, List<double>? stops = const [0, 1], List<double> begin = const [-1, -1], List<double> end = const [1, 1]}) {
  if (null == colors || colors.length < 2) return null;
  if (begin.length != 2 || end.length != 2) return null;
  return {"type":"linear","colors": colors, "stops": stops, "begin": begin, "end": end};
}

gradient_radial({List<String>? colors, List<double>? stops = const [0, 1], List<double> center = const [-1, -1], double radius = 0.5}) {
  if (null == colors || colors.length < 2) return null;
  if (center.length != 2) return null;
  return {"type":"radial","colors": colors, "stops": stops, "center": center, "radius": radius};
}

gradient_sweep({List<String>? colors, List<double>? stops = const [0, 1], List<double> center = const [-1, -1],double begin = 0, double end = 0}) {
  if (null == colors || colors.length < 2) return null;
  if (center.length != 2) return null;
  return {"type":"sweep","colors": colors, "stops": stops,"center":center, "startAngle": begin, "endAngle": end};
}

Future<Map<String, dynamic>> readJsonFile(String path) async {
  final file = File(path);
  final contents = await file.readAsString();
  return jsonDecode(contents);
}
