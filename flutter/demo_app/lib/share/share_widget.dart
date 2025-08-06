import 'package:flutter/material.dart';
import 'package:flutter3/app-style.dart';

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
  return Row(
    children: List.generate(tabs.length, (index) {
      final selected = index == currentIndex;
      return Expanded(
        child: Container(
          height: AppStyle.byRem(.6),
          decoration: BoxDecoration(
            border: selected ? Border(bottom: BorderSide(color: AppStyle.getMainColor(), width: 2)) : null,
          ),
          child: TextButton(
            onPressed: () => onTap(index),
            child: Text(
              tabs[index],
              style: TextStyle(fontSize:AppStyle.byRem(.22),fontWeight: selected ? FontWeight.bold : FontWeight.normal, color: selected ? AppStyle.getMainColor() : null),
            ),
          ),
        ),
      );
    }),
  );
}
