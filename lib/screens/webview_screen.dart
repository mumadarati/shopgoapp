// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class WebViewScreen extends StatefulWidget {
//   const WebViewScreen({Key? key}) : super(key: key);
//
//   @override
//   State<WebViewScreen> createState() => _WebViewScreenState();
// }
//
// class _WebViewScreenState extends State<WebViewScreen> {
//   final Completer<WebViewController> _controller = Completer<WebViewController>();
//
//   String hideButton = "document.getElementsByClassName('add-to-basket__content')[0].style.visibility = 'hidden'";
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("WebView"),
//       ),
//       body: Stack(
//         children: [
//           WebView(
//             initialUrl:
//                 "https://www.trendyol.com/en/trendyol-collection/sweater-brown-oversize-p-248936350?merchantId=968&boutiqueId=615150",
//             javascriptMode: JavascriptMode.unrestricted,
//             onWebViewCreated: (WebViewController controller) {
//               _controller.complete(controller);
//             },
//             onPageFinished: (src) {
//               _controller.future.then((value) => value.runJavascript(hideButton));
//             },
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//                 margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
//                 width: MediaQuery.of(context).size.width,
//                 child: ElevatedButton(onPressed: () {}, child: const Text("Proglabs Custom Button"))),
//           ),
//         ],
//       ),
//     );
//   }
// }
