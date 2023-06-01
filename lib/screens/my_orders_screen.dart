import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_go/app_utils/app_utils.dart';
import 'package:shop_go/app_utils/color_utils.dart';
import 'package:shop_go/app_utils/text_utils.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  final AppUtils _appUtils = AppUtils();
  final TextUtils _textUtils = TextUtils();
  TextEditingController linkController = TextEditingController();
  final String _text = 'track_order_description'.tr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.whiteColor,
      appBar: _appUtils.homeAppBarWidget(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: ()=> Get.back(),
                      child: Icon(Icons.arrow_back_ios,color: ColorUtils.purpleColor,)),
                  Expanded(child: Center(child: _textUtils.bold22("track_order".tr, ColorUtils.purpleColor, TextAlign.center))),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                child: _textUtils.normal14(_text, ColorUtils.lightBlackColor, TextAlign.center),
              ),
              const SizedBox(height: 30),
              _textUtils.bold12("order_id_uppercase".tr, ColorUtils.blackColor, TextAlign.start),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: TextFormField(
                  controller: linkController,
                  keyboardType: TextInputType.text,
                  decoration: _appUtils.inputDecorationWithLabel('order_confirmation_email'.tr, '', ColorUtils.whiteColor),
                ),
              ),
              const SizedBox(height: 10),
              _textUtils.bold12("billing_email".tr, ColorUtils.blackColor, TextAlign.start),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: TextFormField(
                  controller: linkController,
                  keyboardType: TextInputType.text,
                  decoration: _appUtils.inputDecorationWithLabel('email_checkout'.tr, '', ColorUtils.whiteColor),
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
                  child: _textUtils.medium14('track'.tr, ColorUtils.whiteColor, TextAlign.center),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
