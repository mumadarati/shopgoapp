import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:shop_go/api/api_service.dart';
import 'package:shop_go/app_utils/app_utils.dart';
import 'package:shop_go/app_utils/color_utils.dart';
import 'package:shop_go/app_utils/text_utils.dart';

class ResetPassword extends StatefulWidget {
  final String? origin;
  const ResetPassword({this.origin, Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final AppUtils _appUtils = AppUtils();
  final TextUtils _textUtils = TextUtils();
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var box = Hive.box('credentials');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appUtils.simpleAppBarWidget(),
        backgroundColor: ColorUtils.textColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "assets/images/login_page_header.png",
                width: double.infinity,
                height: 130,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 7),
                child: _textUtils.bold30("Reset password".tr,
                    ColorUtils.purpleColor, TextAlign.start),
              ),
              _textUtils.medium16("Enter Your Email To Continue ".tr,
                  ColorUtils.blackColor, TextAlign.start),
              const SizedBox(height: 10),
              _textUtils.medium13("You Will Get Vefication Via Email ".tr,
                  ColorUtils.blackColor, TextAlign.start),
              const SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: _appUtils.inputDecorationWithLabel(
                          'email'.tr, 'email'.tr, ColorUtils.whiteColor,
                          prefixImage: 'email'),
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'enter_email'.tr;
                        }
                        if (!RegExp(
                                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                            .hasMatch(value)) {
                          return 'enter_correct_email'.tr;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            _appUtils.showLoadingDialog();
                            ApiService()
                                .resetPassword(emailController.text.trim());
                          }
                        },
                        child: Container(
                          height: 40,
                          width: Get.size.width,
                          decoration: _appUtils.boxDecoration(
                              ColorUtils.purpleColor, ColorUtils.purpleColor),
                          margin: const EdgeInsets.symmetric(vertical: 30),
                          alignment: Alignment.center,
                          child: _textUtils.medium14('Reset password'.tr,
                              ColorUtils.whiteColor, TextAlign.center),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
