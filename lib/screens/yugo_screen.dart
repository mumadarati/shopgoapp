import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shop_go/app_utils/app_utils.dart';
import 'package:shop_go/app_utils/color_utils.dart';
import 'package:shop_go/app_utils/text_utils.dart';
import 'package:shop_go/screens/home_tabs/profile_tab.dart';
import 'package:shop_go/screens/outer_webview.dart';

class YuGoScreen extends StatefulWidget {
  final String? origin;
  const YuGoScreen({this.origin, Key? key}) : super(key: key);

  @override
  State<YuGoScreen> createState() => _YuGoScreenState();
}

class _YuGoScreenState extends State<YuGoScreen> {
  final AppUtils _appUtils = AppUtils();
  final TextUtils _textUtils = TextUtils();
  TextEditingController linkController = TextEditingController();
  final String _text = "yugo_terms_heading".tr;

  @override
  void initState() {
    super.initState();
  }

  onBackFun() {
    if (widget.origin == "profile") {
      Get.back();
    } else {
      Get.to(() => const ProfileTab());
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final onBack = onBackFun();
        return onBack;
      },
      child: Scaffold(
        backgroundColor: ColorUtils.whiteColor,
        appBar: _appUtils.homeAppBarWidget(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Wrap(
                  children: [
                    _textUtils.bold18(
                        "Yu", ColorUtils.purpleColor, TextAlign.center),
                    _textUtils.bold18(
                        "Go", ColorUtils.yellowColor, TextAlign.center),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                child: _textUtils.normal14(
                    _text, ColorUtils.lightBlackColor, TextAlign.center),
              ),
              const SizedBox(height: 30),
              _textUtils.bold16("turkish_address".tr, ColorUtils.purpleColor,
                  TextAlign.start),
              const SizedBox(height: 10),
              infoItem("email".tr, "info@bravobazaar.com"),
              infoItem("province_ilce".tr, "Bahçelievler"),
              infoItem("state".tr, "Istanbul"),
              infoItem("neighbourhood".tr, "Yenibosna Merkez Mahallesi."),
              infoItem("postal_address".tr,
                  "Yenibosna Merkez mahallesi, 1. Asena sk. No: 23d, E-Blok, Ofis: 17, Posta Kodu: 34197, Karat34, Bahçelievler/Istanbul"),
              infoItem("address_title_uppercase".tr, "Ofis"),
              infoItem("phone".tr, "+90 555 100 28 88"),
              const SizedBox(
                height: 20,
              ),
              _textUtils.bold16("banned_products".tr, ColorUtils.purpleColor,
                  TextAlign.start),
              const SizedBox(
                height: 10,
              ),
              _textUtils.normal12("banned_products_description".tr,
                  ColorUtils.blackColor, TextAlign.start),
              const SizedBox(
                height: 20,
              ),
              GridView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                  ),
                  children: [
                    for (var item in items) bannedProductItem(item),
                  ]),
              const SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () async {
                  String url = "https://shopgobravo.com/en/";
                  Get.to(() => OuterWebView(url: url));
                },
                child: Container(
                  height: 50,
                  width: Get.size.width,
                  decoration: _appUtils.boxDecoration(
                      ColorUtils.purpleColor, ColorUtils.purpleColor),
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  alignment: Alignment.center,
                  child: _textUtils.medium14(
                      'view_more'.tr, ColorUtils.whiteColor, TextAlign.center),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  var items = [
    {"title": "Aerosols_L", "isLimited": true, "image": "aerosols.svg"},
    {
      "title": "Flammable & Combustible",
      "isLimited": false,
      "image": "flammable.svg"
    },
    {"title": "Explosives", "isLimited": false, "image": "bomb.svg"},
    {
      "title": "Hazardous Material & Dangerous Goods",
      "isLimited": false,
      "image": "skull.svg"
    },
    {"title": "Cell Phone", "isLimited": true, "image": "skull.svg"},
    {"title": "Liquids", "isLimited": true, "image": "liquids.svg"},
  ];

  bannedProductItem(item) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: _appUtils.boxDecoration(
          ColorUtils.whiteColor, ColorUtils.lightPurpleColor),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/images/${item["image"]}",
                width: 100,
                height: 100,
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: _textUtils.bold12(
                    item["title"], ColorUtils.purpleColor, TextAlign.center,
                    maxLines: 2),
              )
            ],
          ),
          if (item["isLimited"])
            Positioned(
              child: Container(
                decoration: BoxDecoration(
                    color: ColorUtils.yellowColor,
                    borderRadius: BorderRadius.circular(5)),
                padding: const EdgeInsets.symmetric(
                  horizontal: 7,
                  vertical: 3,
                ),
                child: _textUtils.normal10(
                    "Limited", ColorUtils.whiteColor, TextAlign.center,
                    maxLines: 2),
              ),
            )
        ],
      ),
    );
  }

  infoItem(title, value) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  debugPrint(value);
                  FlutterClipboard.copy(value).then((result) {
                    const snackBar = SnackBar(
                      content: Text('Copied to Clipboard'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                },
                child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: ColorUtils.yellowColor),
                    child: Icon(
                      CupertinoIcons.doc_on_clipboard_fill,
                      color: ColorUtils.whiteColor,
                      size: 15,
                    )),
              ),
              Column(
                children: [
                  _textUtils.bold13(
                      " $title", ColorUtils.yellowColor, TextAlign.start),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: _textUtils.normal12(
                "$value", ColorUtils.blackColor, TextAlign.start),
          )
        ],
      ),
    );
  }
}
