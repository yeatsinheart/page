import UIKit
import WebKit
class WebView: UIViewController {
    private var webView: WKWebView!
    private var url: URL?
    private var html: String?
    private var pageTitle: String?

    init(url: URL?, html: String?, title: String?) {
        self.url = url
        self.html = html
        self.pageTitle = title
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = pageTitle

        if let htmlContent = html {
            webView.loadHTMLString(htmlContent, baseURL: nil)
        } else if let url = url {
            webView.load(URLRequest(url: url))
        } else {
            webView.loadHTMLString("<h1>No content provided</h1>", baseURL: nil)
        }
    }
}
