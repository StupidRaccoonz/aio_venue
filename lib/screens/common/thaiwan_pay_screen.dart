import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ThaiwanPayScreen extends StatefulWidget {
  final String url;
  final String targetUrl;
  final String failedUrl;

  const ThaiwanPayScreen(
      {Key? key,
      required this.url,
      required this.targetUrl,
      required this.failedUrl})
      : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<ThaiwanPayScreen> {
  late WebViewController _webViewController;

  bool _hasNavigated = false; // Guard to prevent multiple Get.back calls

  @override
  void initState() {
    super.initState();
    // Initialize the WebViewController
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onUrlChange: (UrlChange change) {
            if (!_hasNavigated && change.url == widget.targetUrl) {
              _hasNavigated = true; // Mark as navigated
              Get.back(result: "success");
            } else if (!_hasNavigated && change.url == widget.failedUrl) {
              _hasNavigated = true; // Mark as navigated
              Get.back(result: "failed");
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(
        controller: _webViewController,
      ),
    );
  }
}
