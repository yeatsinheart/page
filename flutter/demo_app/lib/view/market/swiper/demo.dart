import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter3/share/img.dart';
import 'package:flutter3/share/safe-state.dart';
import 'package:flutter3/style/app-style.dart';

class MarketSwiperDemo extends StatefulWidget {
  const MarketSwiperDemo({super.key, required params});

  @override
  _MarketSwiperDemoState createState() => _MarketSwiperDemoState();
}

class _MarketSwiperDemoState extends SafeState<MarketSwiperDemo> {
  int _currentIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  final List<String> imageList = [
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppStyle.byRem(.1), horizontal: AppStyle.byRem(.2)),
      child: Stack(
        alignment: Alignment.bottomCenter, // 控制指示器位置
        children: [
          CarouselSlider(
            items: imageList.map((url) {
              return AppImg(url, width: AppStyle.byRem(7), height: AppStyle.byRem(3.5), radius: AppStyle.byRem(.25));
            }).toList(),
            carouselController: _controller,
            options: CarouselOptions(
              height: AppStyle.byRem(3.5),
              autoPlay: true,
              enlargeCenterPage: false,
              //关闭放大
              aspectRatio: 2 / 1,
              initialPage: 0,
              //初始化显示第 1 张图。
              viewportFraction: 1,
              autoPlayInterval: Duration(seconds: 5),
              autoPlayAnimationDuration: Duration(milliseconds: 400),
              onPageChanged: (index, reason) => setState(() {
                _currentIndex = index;
              }),
            ),
          ),
          Positioned(
            bottom: AppStyle.byRem(.2), // 距离底部位置
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imageList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: _currentIndex == entry.key ? 16 : 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0), // 圆角一半，即可变成 pill 形状或小圆点
                      shape: BoxShape.rectangle,
                      color: _currentIndex == entry.key ? Colors.white : Colors.white.withValues(alpha: 0.4),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
