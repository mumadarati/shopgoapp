import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:shop_go/api/api_service.dart';
import 'package:shop_go/app_utils/app_utils.dart';
import 'package:shop_go/app_utils/color_utils.dart';
import 'package:shop_go/app_utils/common.dart';
import 'package:shop_go/app_utils/text_utils.dart';
import 'package:shop_go/controllers/common_controller.dart';
import 'package:shop_go/screens/add_address_screen.dart';
import 'package:shop_go/screens/edit_address_screen.dart';

class MyAddressesScreen extends StatefulWidget {
  const MyAddressesScreen({Key? key}) : super(key: key);

  @override
  State<MyAddressesScreen> createState() => _MyAddressesScreenState();
}

class _MyAddressesScreenState extends State<MyAddressesScreen> {
  final AppUtils _appUtils = AppUtils();
  final TextUtils _textUtils = TextUtils();
  TextEditingController linkController = TextEditingController();
  final String _text = 'address_description'.tr;
  final ApiService _apiService = ApiService();
  CommonController commonController = Get.find<CommonController>();
  var box = Hive.box('credentials');

  @override
  void initState() {
    super.initState();
    Common.userId.value = box.get("userId").toString();
    _apiService.getCustomerDetail(Common.userId.value);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorUtils.whiteColor,
      appBar: _appUtils.homeAppBarWidget(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Obx(
          () => Column(
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
                          child: _textUtils.bold22("my_address".tr,
                              ColorUtils.purpleColor, TextAlign.center))),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                child: _textUtils.normal14(
                    _text, ColorUtils.lightBlackColor, TextAlign.center),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: commonController.customerDetail.value.shipping != null
                    ? commonController
                                .customerDetail.value.shipping!.address1 !=
                            ""
                        ? Column(
                            children: [
                              _appUtils.addressItem(
                                  commonController.customerDetail.value
                                      .shipping, onTap: () {
                                Get.to(() => const EditAddressScreen());
                              }),
                            ],
                          )
                        : _appUtils.placeholderText(
                            "No Address Found", size.height)
                    : _appUtils.circularProgressIndicator(),
              ),
              const SizedBox(height: 20),
              if (commonController.customerDetail.value.shipping!.address1 ==
                  '')
                InkWell(
                  onTap: () {
                    Get.to(() => const AddAddressScreen());
                  },
                  child: Container(
                    height: 50,
                    width: Get.size.width,
                    decoration: _appUtils.boxDecoration(
                        ColorUtils.purpleColor, ColorUtils.purpleColor),
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    alignment: Alignment.center,
                    child: _textUtils.medium14('add_new_address'.tr,
                        ColorUtils.whiteColor, TextAlign.center),
                  ),
                ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
