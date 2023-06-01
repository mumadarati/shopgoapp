import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shop_go/api/api_service.dart';
import 'package:shop_go/app_utils/app_utils.dart';
import 'package:shop_go/app_utils/color_utils.dart';
import 'package:shop_go/app_utils/common.dart';
import 'package:shop_go/app_utils/text_utils.dart';
import 'package:shop_go/controllers/common_controller.dart';
import 'package:shop_go/model/all_brands_model.dart';
import 'package:shop_go/model/testing.dart';
import 'package:shop_go/screens/home_tabs/profile_tab.dart';
import 'package:shop_go/screens/login_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class BrandDetailWebView extends StatefulWidget {
  final BrandModel brand;
  const BrandDetailWebView({required this.brand, Key? key}) : super(key: key);

  @override
  State<BrandDetailWebView> createState() => _BrandDetailWebViewState();
}

class _BrandDetailWebViewState extends State<BrandDetailWebView> {
  final GlobalKey webViewKey = GlobalKey();
  late BrandModel brand;
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

  late PullToRefreshController pullToRefreshController;
  String url = "";
  double progress = 0;
  double trPrice = 0.0;
  RxDouble finalPrice = 0.0.obs;
  final urlController = TextEditingController();
  RxInt tabIndex = 1.obs;
  RxString tabValue = "we_go".obs;

  final AppUtils _appUtils = AppUtils();
  final ApiService _apiService = ApiService();
  final TextUtils _textUtils = TextUtils();
  CommonController commonController = Get.find<CommonController>();

  RxBool showWishlistBtn = false.obs;
  RxDouble updatedPrice = 0.0.obs;
  Testing testing = Testing();

  @override
  void initState() {
    super.initState();
    brand = widget.brand;
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: ColorUtils.purpleColor,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (commonController.isBrandClicked.value) {
      commonController.brandClickedUrl.value = urlController.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorUtils.purpleColor,
          elevation: 0,
          leading: InkWell(
            onTap: () {
              if (Common.accessToken.value != "") {
                // Common.currentIndex.value=2;
                Get.to(() => const ProfileTab());
              } else {
                Get.to(() => const LoginScreen(
                      origin: "home",
                    ));
              }
            },
            child: Container(
              padding: const EdgeInsets.only(top: 10),
              width: 50,
              child: Icon(CupertinoIcons.person_solid,
                  color: ColorUtils.yellowColor, size: 30),
            ),
          ),
          automaticallyImplyLeading: false,
          actions: [
            appBarButtons("YU", "G", 0),
            appBarButtons("WE", "G", 1),
          ],
        ),
        backgroundColor: ColorUtils.whiteColor,
        body: WillPopScope(
          onWillPop: () => _goBack(context),
          child: SafeArea(
              child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 6),
                  InkWell(
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: ColorUtils.purpleColor,
                      size: 25,
                    ),
                    onTap: () {
                      _goBack(context);
                    },
                  ),
                  const SizedBox(width: 1),
                  InkWell(
                    child: Icon(
                      Icons.refresh,
                      color: ColorUtils.purpleColor,
                      size: 30,
                    ),
                    onTap: () {
                      webViewController?.reload();
                    },
                  ),
                  const SizedBox(width: 5),
                  InkWell(
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: ColorUtils.purpleColor,
                      size: 25,
                    ),
                    onTap: () {
                      webViewController?.goForward();
                    },
                  ),
                  const SizedBox(width: 3),
                  Obx(
                    () => finalPrice.value != 0.0
                        ? Row(
                            children: [
                              InkWell(
                                  onTap: () async {
                                    debugPrint(urlController.text);
                                    if (Common.accessToken.value != "") {
                                      _appUtils.showLoadingDialog();
                                      await _apiService
                                          .addToWishlistApi(urlController.text);
                                    } else {
                                      _appUtils.addToCartDialogue(
                                          onConfirm: () {
                                        Get.back();
                                        Get.to(() => const LoginScreen(
                                              origin: "brand_web_view",
                                            ));
                                      });
                                    }
                                  },
                                  child: iconWidget(Icons.favorite)),
                              InkWell(
                                  onTap: () {
                                    FlutterShare.share(
                                      linkUrl: urlController.text,
                                      title: 'Share link',
                                    );
                                  },
                                  child: iconWidget(Icons.share)),
                            ],
                          )
                        : Container(),
                  ),
                  Obx(
                    () => (finalPrice.value != 0.0)
                        ? buttonWidget(
                            "\$ ${finalPrice.toStringAsFixed(2)}",
                            ColorUtils.whiteColor,
                            ColorUtils.yellowColor,
                            ColorUtils.yellowColor)
                        : Container(),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Obx(() => (finalPrice.value != 0.0)
                        ? InkWell(
                            onTap: () async {
                              debugPrint(urlController.text);
                              if (Common.accessToken.value != "") {
                                Get.dialog(
                                  Center(
                                      child: Image.asset(
                                    "assets/images/brand get.png",
                                    scale: 2,
                                  )),
                                  barrierDismissible: false,
                                  useSafeArea: true,
                                );
                                await _apiService.addToCartApi(
                                    urlController.text, tabValue.value);
                                await _apiService.getUserCart();
                              } else {
                                _appUtils.addToCartDialogue(onConfirm: () {
                                  Get.back();
                                  Get.to(() => const LoginScreen(
                                        origin: "brand_web_view",
                                      ));
                                });
                              }
                            },
                            child: buttonWidget(
                                "add_to_cart".tr,
                                ColorUtils.yellowColor,
                                ColorUtils.yellowColor,
                                ColorUtils.whiteColor),
                          )
                        : const SizedBox()),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  InAppWebView(
                    key: webViewKey,
                    initialUrlRequest: (commonController.isBrandClicked.value &&
                            commonController.brandClickedUrl.value != '')
                        ? URLRequest(
                            url: Uri.parse(
                                commonController.brandClickedUrl.value))
                        : URLRequest(url: Uri.parse(brand.brandName ?? '')),
                    initialOptions: options,
                    pullToRefreshController: pullToRefreshController,
                    onWebViewCreated: (controller) {
                      webViewController = controller;
                      // controller.evaluateJavascript(
                      //     source: "document.getElementsByClassName('${widget.addToCartDiv![0].split('.').last}')[0].style.visibility = 'hidden'");
                    },
                    onLoadStart: (controller, url) async {
                      urlChenged(url, urlController.text);
                      hideQuery(controller, url);
                      customQuery(controller, url);
                      checkProductPrice();
                      setState(() {
                        debugPrint(urlController.text);
                        this.url = url.toString();
                        urlController.text = this.url;
                      });
                    },
                    androidOnPermissionRequest:
                        (controller, origin, resources) async {
                      return PermissionRequestResponse(
                          resources: resources,
                          action: PermissionRequestResponseAction.GRANT);
                    },
                    shouldOverrideUrlLoading:
                        (controller, navigationAction) async {
                      var uri = navigationAction.request.url!;

                      if (![
                        "http",
                        "https",
                        "file",
                        "chrome",
                        "data",
                        "javascript",
                        "about"
                      ].contains(uri.scheme)) {
                        if (await canLaunch(url)) {
                          // Launch the App
                          await launch(
                            url,
                          );
                          // and cancel the request
                          return NavigationActionPolicy.CANCEL;
                        }
                      }
                      return NavigationActionPolicy.ALLOW;
                    },
                    onLoadStop: (controller, url) async {
                      hideQuery(controller, url);
                      customQuery(controller, url);
                      checkProductPrice();
                      pullToRefreshController.endRefreshing();
                      setState(() {
                        this.url = url.toString();
                        urlController.text = this.url;
                      });
                    },
                    onLoadError: (controller, url, code, message) {
                      pullToRefreshController.endRefreshing();
                    },
                    onProgressChanged: (controller, progress) {
                      hideQuery(controller, url);
                      customQuery(controller, url);
                      checkProductPrice();
                      if (progress == 100) {
                        pullToRefreshController.endRefreshing();
                      }
                      setState(() {
                        this.progress = progress / 100;
                        urlController.text = url;
                      });
                    },
                    onUpdateVisitedHistory: (controller, url, androidIsReload) {
                      setState(() {
                        this.url = url.toString();
                        urlController.text = this.url;
                      });
                    },
                    onScrollChanged: (controller, x, y) {
                      hideQuery(controller, url);
                      customQuery(controller, url);
                      checkProductPrice();
                      urlChenged(url, urlController.text);
                    },
                    onConsoleMessage: (controller, consoleMessage) {
                      hideQuery(controller, url);
                      customQuery(controller, url);
                      checkProductPrice();
                      debugPrint(consoleMessage.message);
                    },
                  ),
                  progress < 1.0
                      ? LinearProgressIndicator(value: progress)
                      : Container(),
                ],
              ),
            ),
          ])),
        ));
  }

  hideQuery(controller, url) async {
    await injecter(brand.hide ?? '');
  }

  bool canRunCustomQuery = true;
  customQuery(controller, url) async {
    if (canRunCustomQuery) {
      await injecter(brand.costume ?? '');
      canRunCustomQuery = false;
    }
  }

  urlChenged(newUrl, oldUrl) {
    if (oldUrl != newUrl) {
      finalPrice = 0.0.obs;
    }
  }

  bool isRunPrice = false;
  String resultFromJS = '';
  Future checkProductPrice() async {
    if (isRunPrice) return;
    isRunPrice = true;

    resultFromJS = await injecter(brand.price ?? '');
    if (jsValuesNotNull(resultFromJS)) {
      trPrice = double.tryParse(resultFromJS)!;
      if (resultFromJS != "NaN") {
        setState(() {
          finalPrice = (trPrice / Common.usdRate).obs;
        });
      }
    }

    isRunPrice = false;
  }

  injecter(String js) async {
    String result = "";
    try {
      result = await webViewController?.evaluateJavascript(source: js) ?? "";
    } catch (e) {
      result = "";
    }
    return cleanTags(result);
  }

  bool jsValuesNotNull(String? value) =>
      value != "<null>" &&
      value != null &&
      value != "(null)" &&
      value != "null" &&
      value != "\"\"" &&
      value != "";

  Future<bool> _goBack(BuildContext context) async {
    if (await webViewController!.canGoBack()) {
      webViewController!.goBack();
      return Future.value(false);
    } else {
      commonController.isBrandClicked.value = false;
      Get.back();
      return Future.value(true);
    }
  }

  Widget iconWidget(icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: CircleAvatar(
          radius: 18,
          backgroundColor: ColorUtils.yellowColor,
          child: Icon(
            icon,
            color: ColorUtils.whiteColor,
            size: 26,
          )),
    );
  }

  Widget appBarButtons(text1, text2, value) {
    return Obx(
      () => InkWell(
        onTap: () {
          tabIndex.value = value;
          tabIndex.value == 0
              ? tabValue.value = "yu_go"
              : tabValue.value = "we_go";
          debugPrint(tabValue.value);
        },
        child: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: tabIndex.value == value
                    ? ColorUtils.yellowColor
                    : ColorUtils.purpleColor),
            child: Row(
              children: [
                _textUtils.bold28(
                    text1,
                    tabIndex.value == value
                        ? ColorUtils.whiteColor
                        : ColorUtils.yellowColor,
                    TextAlign.start),
                _textUtils.bold28(
                    text2,
                    tabIndex.value == value
                        ? ColorUtils.purpleColor
                        : ColorUtils.whiteColor,
                    TextAlign.start),
                SvgPicture.asset(
                  "assets/images/shop_go.svg",
                  height: 30,
                  width: 30,
                  color:
                      tabIndex.value == value ? ColorUtils.purpleColor : null,
                ),
              ],
            )),
      ),
    );
  }

  Widget buttonWidget(text, buttonColor, borderColor, textColor) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: borderColor)),
        height: 35,
        child: Center(
          child: _textUtils.bold15(text, textColor, TextAlign.center),
        ));
  }

  String? cleanTags(String? value) => value == null
      ? value
      : value
          .replaceAll('\\n', ' ')
          .replaceAll('\n', ' ')
          .replaceAll('<br>', ' ')
          .replaceAll('\\', ' ')
          .replaceAll('"', '')
          .replaceAll("'", '')
          .replaceAll('"', '')
          .replaceAll("'", '')
          .replaceAll('&nbsp;', ' ')
          .replaceAll(RegExp(r"[^\x00-\x7F]"), "")
          .replaceAll(RegExp(r"\u2122"), "");
}
