import 'package:flutter/material.dart';
import 'package:flutter3/app-style.dart';
import 'package:flutter3/share/html-content.dart';

class MarketAnnounceDemo extends StatelessWidget {
  final params;

  MarketAnnounceDemo({this.params, super.key});

  final List<Map<String, String>> data = List.generate(22, (index) => {"title": "标题 $index", "content": "这是内容 $index"});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: AppStyle.gap),
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data[index]['title']!,
                    style: TextStyle().copyWith(fontSize: AppStyle.fontSize + 2, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  HtmlContent(html: "<div>${data[index]['content']}</div"),
                  Divider(), // 分隔线
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
