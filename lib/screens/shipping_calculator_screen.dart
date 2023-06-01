import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_go/api/api_service.dart';
import 'package:shop_go/app_utils/app_utils.dart';
import 'package:shop_go/app_utils/color_utils.dart';
import 'package:shop_go/app_utils/text_utils.dart';
import 'package:shop_go/controllers/common_controller.dart';

class ShippingCalculatorScreen extends StatefulWidget {
  const ShippingCalculatorScreen({Key? key}) : super(key: key);

  @override
  State<ShippingCalculatorScreen> createState() =>
      _ShippingCalculatorScreenState();
}

class _ShippingCalculatorScreenState extends State<ShippingCalculatorScreen> {
  final AppUtils _appUtils = AppUtils();
  final TextUtils _textUtils = TextUtils();
  TextEditingController linkController = TextEditingController();

  RxString selectedUnit = "Lbs / Inch".obs;
  String? fromDropdown;
  String? toDropdown;
  RxInt calculateShippingRates = 0.obs;
  RxBool isLoading = false.obs;
  RxInt selectedWeight = 0.obs;
  RxInt selectedWidth = 0.obs;
  RxInt selectedLength = 0.obs;
  RxInt selectedHeight = 0.obs;
  CommonController commonController = Get.find<CommonController>();

  @override
  void initState() {
    super.initState();
    ApiService().getShippingCountries();
    fromDropdown = 'Turkey';
    toDropdown = 'Israel';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.whiteColor,
      appBar: _appUtils.homeAppBarWidget(),
      body: Obx(
        () {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                        onTap: () => Get.back(),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: ColorUtils.purpleColor,
                        )),
                    Expanded(
                        child: Center(
                            child: _textUtils.bold22("shipping_calculator".tr,
                                ColorUtils.purpleColor, TextAlign.center))),
                  ],
                ),
                const SizedBox(height: 10),
                _textUtils.bold15("select_country_shop".tr,
                    ColorUtils.purpleColor, TextAlign.start),
                const SizedBox(height: 30),
                _textUtils.bold13(
                    "shop_from".tr, ColorUtils.blackColor, TextAlign.start),
                Obx(() => commonController.shippingCountries.value.from != null
                    ? Container(
                        height: 50,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(top: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: ColorUtils.greyColor)),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          hint: TextUtils().normal14(
                              "From", ColorUtils.greyColor, TextAlign.start),
                          value: 'Turkey',
                          icon: const Icon(Icons.keyboard_arrow_down),
                          underline: const SizedBox(),
                          // items: commonController.shippingCountries.value.from!
                          items: ['Turkey'].map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              fromDropdown = value;
                            });
                          },
                        ),
                      )
                    : Center(
                        child: CupertinoActivityIndicator(
                            color: ColorUtils.purpleColor))),
                const SizedBox(height: 15),
                _textUtils.bold13(
                    "send_it".tr, ColorUtils.blackColor, TextAlign.start),
                Obx(() => commonController.shippingCountries.value.to != null
                    ? Container(
                        height: 50,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(top: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: ColorUtils.greyColor)),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          hint: TextUtils().normal14(
                              "To", ColorUtils.greyColor, TextAlign.start),
                          value: 'Israel',
                          icon: const Icon(Icons.keyboard_arrow_down),
                          underline: const SizedBox(),
                          // items: commonController.shippingCountries.value.to!
                          items: ['Israel'].map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              toDropdown = value;
                            });
                          },
                        ),
                      )
                    : Center(
                        child: CupertinoActivityIndicator(
                            color: ColorUtils.purpleColor))),
                const SizedBox(height: 20),
                _textUtils.bold15("package_dimension".tr,
                    ColorUtils.purpleColor, TextAlign.start),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: _textUtils.semiBold13("weight".tr,
                            ColorUtils.blackColor, TextAlign.start)),
                    _appUtils.unitItem(
                        text: "Lbs / Inch  ",
                        isSelected: "Lbs / Inch" == selectedUnit.value,
                        onTap: () {
                          selectedUnit.value = "Lbs / Inch";
                        }),
                    _appUtils.unitItem(
                        text: "Kg / Cm",
                        isSelected: "Kg / Cm" == selectedUnit.value,
                        onTap: () {
                          selectedUnit.value = "Kg / Cm";
                        }),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: _appUtils.numberCounter(
                      decrement: () {
                        if (selectedWeight.value > 0) {
                          selectedWeight.value--;
                        }
                      },
                      value: selectedWeight.value.toString(),
                      increment: () {
                        selectedWeight.value++;
                      },
                      hPadding: 10),
                ),
                const SizedBox(height: 5),
                _textUtils.bold14(
                    "width".tr, ColorUtils.blackColor, TextAlign.start),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: _appUtils.numberCounter(
                      decrement: () {
                        if (selectedWidth.value > 0) {
                          selectedWidth.value--;
                        }
                      },
                      value: selectedWidth.value.toString(),
                      increment: () {
                        selectedWidth.value++;
                      },
                      hPadding: 10),
                ),
                const SizedBox(height: 5),
                _textUtils.bold14(
                    "length".tr, ColorUtils.blackColor, TextAlign.start),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: _appUtils.numberCounter(
                      decrement: () {
                        if (selectedLength.value > 0) {
                          selectedLength.value--;
                        }
                      },
                      value: selectedLength.value.toString(),
                      increment: () {
                        selectedLength.value++;
                      },
                      hPadding: 10),
                ),
                const SizedBox(height: 5),
                _textUtils.bold14(
                    "Height", ColorUtils.blackColor, TextAlign.start),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: _appUtils.numberCounter(
                      decrement: () {
                        if (selectedHeight.value > 0) {
                          selectedHeight.value--;
                        }
                      },
                      value: selectedHeight.value.toString(),
                      increment: () {
                        selectedHeight.value++;
                      },
                      hPadding: 10),
                ),
                const SizedBox(height: 5),
                InkWell(
                  onTap: () async {
                    if (selectedWeight.value != 0 ||
                        selectedHeight.value != 0 ||
                        selectedWidth.value != 0 ||
                        selectedLength.value != 0) {
                      isLoading.value = true;
                      await ApiService()
                          .calculateShippingRates(
                        units: selectedUnit.value == 'Lbs / Inch'
                            ? 'lb-in'
                            : 'kg-cm',
                        weight: selectedWeight.value.toString(),
                        height: selectedHeight.value.toString(),
                        width: selectedWidth.value.toString(),
                        length: selectedLength.value.toString(),
                      )
                          .then((value) {
                        calculateShippingRates.value = value;
                        isLoading.value = false;
                      });
                    }
                  },
                  child: Container(
                    height: 50,
                    width: Get.size.width,
                    decoration: _appUtils.boxDecoration(
                        ColorUtils.purpleColor, ColorUtils.purpleColor),
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _textUtils.medium14('calculate'.tr,
                            ColorUtils.whiteColor, TextAlign.center),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    _textUtils.semiBold15('Shipping rate is :'.tr,
                        ColorUtils.purpleColor, TextAlign.start),
                    const SizedBox(width: 10),
                    isLoading.value
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                                backgroundColor: ColorUtils.purpleColor,
                                color: ColorUtils.whiteColor),
                          )
                        : _textUtils.semiBold15(
                            calculateShippingRates.value == 0
                                ? ''
                                : "${calculateShippingRates.toString()}\$",
                            ColorUtils.purpleColor,
                            TextAlign.start),
                  ],
                ),
                const SizedBox(height: 15),
                _textUtils.semiBold11('calculate_description'.tr,
                    ColorUtils.purpleColor, TextAlign.start),
                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }
}
