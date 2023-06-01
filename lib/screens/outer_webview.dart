import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:shop_go/app_utils/app_utils.dart';

class OuterWebView extends StatefulWidget {
  final String url;
  const OuterWebView({required this.url, Key? key}) : super(key: key);

  @override
  State<OuterWebView> createState() => _OuterWebViewState();
}

class _OuterWebViewState extends State<OuterWebView> {
  InAppWebViewController? webViewController;
  final AppUtils _appUtils = AppUtils();
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appUtils.simpleAppBarWidget(),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
            onProgressChanged: (controller, progress) {
              setState(() {
                this.progress = progress / 100;
              });
            },
          ),
          progress < 1.0
              ? LinearProgressIndicator(value: progress)
              : Container(),
        ],
      ),
    );
  }
}
