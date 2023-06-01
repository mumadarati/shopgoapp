import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_go/app_utils/app_utils.dart';
import 'package:shop_go/app_utils/color_utils.dart';
import 'package:shop_go/app_utils/common.dart';
import 'package:shop_go/app_utils/text_utils.dart';

class WeGoScreen extends StatefulWidget {
  const WeGoScreen({Key? key}) : super(key: key);

  @override
  State<WeGoScreen> createState() => _WeGoScreenState();
}

class _WeGoScreenState extends State<WeGoScreen> {
  final AppUtils _appUtils = AppUtils();
  final TextUtils _textUtils = TextUtils();
  TextEditingController linkController = TextEditingController();
  final String _text = "You choose your products and we will buy it and ship it to you";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.whiteColor,
      appBar: AppBar(
        backgroundColor: ColorUtils.whiteColor,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios), color: ColorUtils.blackColor, onPressed: () => Get.back()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Wrap(
                children: [
                  _textUtils.bold18("We", ColorUtils.purpleColor, TextAlign.center),
                  _textUtils.bold18("Go", ColorUtils.yellowColor, TextAlign.center),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              child: _textUtils.normal14(_text, ColorUtils.lightBlackColor, TextAlign.center),
            ),
            const SizedBox(height: 30),
            _textUtils.bold16("Add your product link", ColorUtils.blackColor, TextAlign.start),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: TextFormField(
                controller: linkController,
                keyboardType: TextInputType.text,
                decoration: _appUtils.inputDecorationWithLabel('Link', 'Link', ColorUtils.whiteColor),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                height: 50,
                width: Get.size.width,
                decoration: _appUtils.boxDecoration(ColorUtils.purpleColor, ColorUtils.purpleColor),
                margin: const EdgeInsets.symmetric(vertical: 30),
                alignment: Alignment.center,
                child: _textUtils.medium14('Show Product Details', ColorUtils.whiteColor, TextAlign.center),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: Get.size.width,
              decoration: _appUtils.boxDecoration(ColorUtils.whiteColor, ColorUtils.whiteColor, giveShadow: true),
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: _textUtils.semiBold14('More products, less shipping cost', ColorUtils.yellowColor, TextAlign.center),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: _textUtils.normal12('To get low shipping cost, add more products to your order.', ColorUtils.lightBlackColor, TextAlign.center),
                  ),
                  const SizedBox(height: 15),
                  _textUtils.semiBold14('Example', ColorUtils.blackColor, TextAlign.start),
                  const SizedBox(height: 10),
                  _textUtils.normal12('1 product => shipping cost 19.00 ${Common.currency}', ColorUtils.lightBlackColor, TextAlign.center),
                  _textUtils.normal12('2 products => shipping cost 22.00 ${Common.currency}', ColorUtils.lightBlackColor, TextAlign.center),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
