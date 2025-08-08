package com.example.demo_app

import android.os.Bundle
import android.webkit.WebView
import android.webkit.WebViewClient
import androidx.appcompat.app.AppCompatActivity

class WebViewActivity : AppCompatActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)

    val webView = WebView(this)
    setContentView(webView)

    val url = intent.getStringExtra("url")
    val html = intent.getStringExtra("html")
    val title = intent.getStringExtra("title")

    supportActionBar?.title = title

    webView.settings.javaScriptEnabled = true
    webView.webViewClient = WebViewClient()

    if (!html.isNullOrEmpty()) {
      webView.loadDataWithBaseURL(null, html, "text/html", "utf-8", null)
    } else if (!url.isNullOrEmpty()) {
      webView.loadUrl(url)
    } else {
      webView.loadData("<h1>没有内容</h1>", "text/html", "utf-8")
    }
  }
}
