import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter3/share/overlay.dart';
import 'package:get/get.dart';
//
class LoadingStore extends GetxService {
  final _loading = false.obs;
  bool get isLoading => _loading.value;

  void show() => _loading.value = true;
  void hide() => _loading.value = false;

  Future<LoadingStore> init() async {
    return this;
  }
  Future<T> run<T>(Future<T> Function() task) async {
    show();
    try {
      return await task();
    } finally {
      hide();
    }
  }
  _build(){
    var i = GlobalOverlayContext.item(Obx(
          () => isLoading
          ? SizedBox.expand(
        child: Container(child: const Center(child: CircularProgressIndicator())),
      )
          : SizedBox.shrink(),
    ));
    GlobalOverlayContext.showOverlay(i);
  }
}