import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:shop_go/app_utils/app_utils.dart';
import 'package:get/get.dart';
import 'package:shop_go/app_utils/color_utils.dart';
import 'package:shop_go/app_utils/common.dart';
import 'package:shop_go/app_utils/text_utils.dart';
import 'package:shop_go/controllers/common_controller.dart';
import 'package:shop_go/screens/home_screen.dart';

class PaymentWebView extends StatefulWidget {
  final String iframeSrc;
  const PaymentWebView({super.key, required this.iframeSrc});

  @override
  State<PaymentWebView> createState() => PpaymentStateWebView();
}

class PpaymentStateWebView extends State<PaymentWebView> {
  CommonController commonController = Get.find<CommonController>();
  final TextUtils _textUtils = TextUtils();
  final AppUtils _appUtils = AppUtils();
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: InAppWebView(
              key: webViewKey,
              initialOptions: options,
              initialUrlRequest: URLRequest(url: Uri.parse(widget.iframeSrc)),
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onLoadStart: (controller, url) async {
                urlChenged(url);
              },
            ),
          ),
        ],
      ),
    );
  }

  urlChenged(newUrl) {
    print(newUrl);
    if (newUrl
        .toString()
        .contains('shopgobravo.com/en/checkout/order-received')) {
      Common.currentIndex.value = 0;
      commonController.isBrandClicked.value = false;
      Get.offAll(const HomeScreen());
      // ?.then((value) {
        // Get.defaultDialog(
        //     title: 'شكرا لشرائك من خلال ShopGo',
        //     middleText: 'شكرا لشرائك من خلال ShopGo',
        //     actions: [
        //       Column(
        //         children: [
        //           InkWell(
        //             onTap: () {
        //               Get.offAll(const HomeScreen());
        //             },
        //             child: Container(
        //               height: 50,
        //               width: Get.size.width,
        //               decoration: _appUtils.boxDecoration(
        //                   ColorUtils.purpleColor, ColorUtils.purpleColor),
        //               margin: const EdgeInsets.symmetric(vertical: 30),
        //               alignment: Alignment.center,
        //               child: _textUtils.medium14(
        //                   'استمرار', ColorUtils.whiteColor, TextAlign.center),
        //             ),
        //           ),
        //         ],
        //       )
        //     ]);
      // });
    }
  }
}
