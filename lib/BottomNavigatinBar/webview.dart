import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({
    super.key,
    this.title,
    required this.url,
  });

  final String? title;
  final String url;

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebViewPage> {
  late final WebViewController _controller; // lateを使って遅延初期化
  var _isLoading = false;
  var _downloadProgress = 0.0;
  String _title = '';
  String _url = '';

  @override
  void initState() {
    super.initState();
    _title = widget.title ?? '';
    _url = widget.url;

    // WebViewControllerを初期化
    const params = PlatformWebViewControllerCreationParams();
    _controller = WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              _downloadProgress = progress / 100;
              _isLoading = progress < 100;
            });
          },
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) async {
            setState(() {
              _isLoading = false;
            });
            final title = await _controller.getTitle();
            setState(() {
              if (title != null) {
                _title = title;
              }
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(_url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Column(
        children: [
          _isLoading
              ? LinearProgressIndicator(value: _downloadProgress)
              : const SizedBox.shrink(),
          Expanded(
            child: WebViewWidget(controller: _controller),
          ),
        ],
      ),
    );
  }
}
