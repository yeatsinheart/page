import 'package:flutter/material.dart';
import 'package:flutter3/app-style.dart';
import 'package:flutter3/i18n.dart';
import 'package:flutter3/share/img.dart';
import 'package:flutter3/store/host-status.dart';
import 'package:flutter3/util/MyEasyRefresh.dart';
import 'package:get/get.dart';

class GameHistory extends StatelessWidget {
  final dynamic params;

  GameHistory({this.params, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyEasyRefresh(
        listView: ListView.separated(
          padding: EdgeInsets.all(AppStyle.gap),
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {},
              leading: Img("url"),
              title: Text("line.name", style: TextStyle().copyWith(fontWeight: FontWeight.bold)),
              subtitle: Text("time"),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: []),
            );
            ;
          },
          separatorBuilder: (_, __) => const SizedBox(height: 3),
          itemCount: 22,
        ),
      ),
    );
  }
}
