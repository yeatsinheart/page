import 'package:flutter/material.dart';
import 'package:flutter3/share/img.dart';
import 'package:flutter3/store/app.dart';
import 'package:flutter3/style/format/container.dart';

container_demo({height, txt = '占位', color = Colors.white}) {
  return Container(
    height: height,
    color: color,
    alignment: Alignment.center,
    child: Text(txt, style: TextStyle(color: Colors.white)),
  );
}

list_demo(count) {
  return List.generate(count, (index) {
    return Text('Item SliverList $index');
  });
  //ListTile(title: Text('Item SliverList $index')), childCount: 20)
}

Widget tab_bar_demo({tabs, currentIndex, onTap}) {
  return ContainerFormat("tab",
     Row(
      children: List.generate(tabs.length, (index) {
        final selected = index == currentIndex;
        return Expanded(
          child: GestureDetector(
            onTap: () => onTap(index),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: selected ? AppStore.getMainColor() : Colors.transparent, width: 2)),
              ),
              child: Text(
                tabs[index],
                style: TextStyle(fontSize: 14, fontWeight: selected ? FontWeight.bold : FontWeight.normal, color: selected ?AppStore.getMainColor() :null),
              ),
            ),
          ),
        );
      }),
    ),
  );
}
