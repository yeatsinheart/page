import 'package:flutter/material.dart';

container_demo({height,txt='占位',color=Colors.white}){
  return Container(height: height, color: color, alignment: Alignment.center, child: Text(txt, style: TextStyle(color: Colors.white)));
}

list_demo(count) {
  return List.generate(count, (index) {
    return Text('Item SliverList $index');
  });
  //ListTile(title: Text('Item SliverList $index')), childCount: 20)
}

Widget tab_bar_demo({tabs, currentIndex, onTap}) {
  return Container(
    color: Colors.white,
    child: Row(
      children: List.generate(tabs.length, (index) {
        final selected = index == currentIndex;
        return Expanded(
          child: GestureDetector(
            onTap: () => onTap(index),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: selected ? Colors.blue : Colors.transparent, width: 2)),
              ),
              child: Text(
                tabs[index],
                style: TextStyle(fontSize: 14, fontWeight: selected ? FontWeight.bold : FontWeight.normal, color: selected ? Colors.blue : Colors.black87),
              ),
            ),
          ),
        );
      }),
    ),
  );
}

Widget sliver_grid_demo(String title, int count) {
  return SliverGrid(
    delegate: SliverChildBuilderDelegate((context, index) {
      return card_demo("${title}-$index");
    }, childCount: count),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 3 / 4, crossAxisSpacing: 8, mainAxisSpacing: 8),
  );
}

Widget card_demo(String title) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Stack(
      children: [
        Container(
          color: Colors.grey[300],
          child: Center(child: Icon(Icons.image, size: 50, color: Colors.white)),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.black.withOpacity(0.3), Colors.transparent], begin: Alignment.bottomCenter, end: Alignment.topCenter),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
      ],
    ),
  );
}
