import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_go/api/api_service.dart';
import 'package:shop_go/app_utils/app_utils.dart';
import 'package:shop_go/app_utils/color_utils.dart';
import 'package:shop_go/app_utils/text_utils.dart';
import 'package:shop_go/controllers/common_controller.dart';
import 'package:shop_go/model/payment_methods.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({Key? key}) : super(key: key);

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  final AppUtils _appUtils = AppUtils();
  final TextUtils _textUtils = TextUtils();
  TextEditingController linkController = TextEditingController();
  CommonController commonController = Get.find<CommonController>();

  RxString defaultAddress = "".obs;

  @override
  void initState() {
    super.initState();
    ApiService().getPaymentMethods();
  }

  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorUtils.whiteColor,
      appBar: AppBar(
        backgroundColor: ColorUtils.whiteColor,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: ColorUtils.blackColor,
            onPressed: () => Get.back()),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Obx(
          () {
            List<PaymentMethods>? paymentMethods = commonController.paymentMethods.value.paymentMethods;
           return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: _textUtils.bold18("payments_methods".tr,
                      ColorUtils.purpleColor, TextAlign.center),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child:
                  paymentMethods!=null?
                  paymentMethods.isNotEmpty?
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        for(var item in paymentMethods )
                          paymentOptionItem("master_card.png",
                              item.title, item.description!,
                              isDefault: "master card" == defaultAddress.value,
                              onTap: () {
                                defaultAddress.value = item.title!;
                              }),
                      ],
                    ),
                  ):
                  _appUtils.placeholderText("no_payment_methods".tr, size.height/2.5):
                  _appUtils.circularProgressIndicator()

                ),
                const SizedBox(height: 20),
              ],
            );
          }
        ),
      ),
    );
  }

  paymentOptionItem(icon, title, value, {isDefault = false, onTap}) {
    return Container(
      decoration: _appUtils.boxDecoration(
        ColorUtils.whiteColor,
        isDefault ? ColorUtils.purpleColor : ColorUtils.lightPurpleColor,
      ),
      margin: const EdgeInsets.symmetric(vertical: 5),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    decoration: _appUtils.boxDecoration(
                      ColorUtils.whiteColor,
                      ColorUtils.whiteColor,
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.asset(
                      "assets/icons/$icon",
                      width: 30,
                      height: 30,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _textUtils.bold14(
                            title,
                            isDefault
                                ? ColorUtils.purpleColor
                                : ColorUtils.blackColor,
                            TextAlign.start),
                        if (value != "")
                          const SizedBox(
                            height: 10,
                          ),
                        if (value != "")
                          _textUtils.normal14(value, ColorUtils.lightBlackColor,
                              TextAlign.start)
                      ],
                    ),
                  )
                ],
              ),
            ),
            if (isDefault)
              Positioned(
                top: 15,
                right: -25,
                child: RotationTransition(
                  turns: const AlwaysStoppedAnimation(50 / 360),
                  child: Container(
                    width: 90,
                    color: ColorUtils.purpleColor,
                    child: _textUtils.normal12(
                        "default".tr, ColorUtils.whiteColor, TextAlign.center),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
