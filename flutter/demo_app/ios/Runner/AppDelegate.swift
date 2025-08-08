import Flutter
import UIKit
import WebKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
 let controller = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: "com.example/native_webview",
                                           binaryMessenger: controller.binaryMessenger)

        channel.setMethodCallHandler { call, result in
            if call.method == "openWebView" {
                if let args = call.arguments as? [String: Any] {
                    let urlString = args["url"] as? String
                    let html = args["html"] as? String
                    let title = args["title"] as? String

                    let url = urlString != nil ? URL(string: urlString!) : nil
                    let vc = WebViewController(url: url, html: html, title: title)

                    if let nav = controller.navigationController {
                        nav.pushViewController(vc, animated: true)
                    } else {
                        controller.present(vc, animated: true)
                    }
                    result(nil)
                } else {
                    result(FlutterError(code: "INVALID_ARGS", message: "Missing arguments", details: nil))
                }
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
