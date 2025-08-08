package com.example.demo_app

import io.flutter.embedding.android.FlutterActivity

import android.content.Intent
import android.os.Bundle
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : : FlutterActivity() {
  private val CHANNEL = "com.example/native_webview"

  override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)

    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
      .setMethodCallHandler { call, result ->
        if (call.method == "openWebView") {
          val url = call.argument<String>("url")
          val intent = Intent(this, WebViewActivity::class.java)
          intent.putExtra("url", url)
          startActivity(intent)
          result.success(null)
        } else {
          result.notImplemented()
        }
      }
  }
}