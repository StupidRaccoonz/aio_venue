import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ThaiwanPayScreen extends StatefulWidget {
  final String url;
  final String targetUrl;

  const ThaiwanPayScreen({
    Key? key,
    required this.url,
    required this.targetUrl,
  }) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<ThaiwanPayScreen> {
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    // Initialize the WebViewController
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onUrlChange: (UrlChange change) {
            if (change.url == widget.targetUrl) {
              Get.back(result: "success");
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
