import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:shop_go/app_utils/app_utils.dart';
import 'package:shop_go/app_utils/color_utils.dart';
import 'package:shop_go/app_utils/text_utils.dart';
import 'package:shop_go/screens/yugo_screen.dart';

class YuGoTermsScreen extends StatefulWidget {
  final String fromPage;
  const YuGoTermsScreen({required this.fromPage, Key? key}) : super(key: key);

  @override
  State<YuGoTermsScreen> createState() => _YuGoTermsScreenState();
}

class _YuGoTermsScreenState extends State<YuGoTermsScreen> {
  final AppUtils _appUtils = AppUtils();
  final TextUtils _textUtils = TextUtils();
  TextEditingController linkController = TextEditingController();
  final String _text = "yugo_terms_heading".tr;
  var box = Hive.box('credentials');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.whiteColor,
      appBar: _appUtils.homeAppBarWidget(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
                onTap: () => Get.back(),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: ColorUtils.purpleColor,
                )),
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
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: _appUtils.boxDecoration(
                  ColorUtils.lightPurpleColor.withOpacity(0.5),
                  ColorUtils.lightPurpleColor),
              child: _textUtils.normal14(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.\n"
                  "\nLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
                  "\nLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                  ColorUtils.blackColor,
                  TextAlign.start),
            ),
            const SizedBox(
              height: 20,
            ),
            if (widget.fromPage != 'register')
              InkWell(
                onTap: () {
                  Get.offAll(() => const YuGoScreen(
                        origin: "terms",
                      ));
                },
                child: Container(
                  height: 50,
                  width: Get.size.width,
                  decoration: _appUtils.boxDecoration(
                      ColorUtils.purpleColor, ColorUtils.purpleColor),
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  alignment: Alignment.center,
                  child: _textUtils.medium14('accept_terms'.tr,
                      ColorUtils.whiteColor, TextAlign.center),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
