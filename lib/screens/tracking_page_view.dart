import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class TrackingOrderPage extends StatefulWidget {
  const TrackingOrderPage({super.key});

  @override
  State<TrackingOrderPage> createState() => _TrackingOrderPageState();
}

class _TrackingOrderPageState extends State<TrackingOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("track_order".tr),
      ),
      body: InAppWebView(
          initialUrlRequest: URLRequest(
              url: Uri.parse("https://public.exelot.com/tracking/?lang=en/"))),
    );
  }
}
