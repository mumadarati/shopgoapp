import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:shop_go/api/api_service.dart';
import 'package:shop_go/app_utils/app_utils.dart';
import 'package:shop_go/app_utils/color_utils.dart';
import 'package:shop_go/app_utils/text_utils.dart';
import 'package:shop_go/screens/login_tabs/reset_password.dart';

class LoginTab extends StatefulWidget {
  final String? origin;
  const LoginTab({this.origin, Key? key}) : super(key: key);

  @override
  State<LoginTab> createState() => _LoginTabState();
}

class _LoginTabState extends State<LoginTab> {
  final AppUtils _appUtils = AppUtils();
  final TextUtils _textUtils = TextUtils();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final RxBool _passwordVisible = true.obs;
  late RxBool _rememberPassword = false.obs;
  final _formKey = GlobalKey<FormState>();
  var box = Hive.box('credentials');

  @override
  void initState() {
    super.initState();
    rememberPassword();
  }

  rememberPassword() {
    String password = box.get("password") ?? '';
    bool rememberPassword = box.get("remember_password") ?? false;
    if (rememberPassword && password.isNotEmpty) {
      _rememberPassword = true.obs;
      passwordController.text = password;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: _appUtils.inputDecorationWithLabel(
                    'username_email'.tr, 'email'.tr, ColorUtils.whiteColor,
                    prefixImage: 'email'),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'enter_email'.tr;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              InkWell(
                onTap: () {
                  Get.to(() => const ResetPassword());
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: _textUtils.medium14('forget_password_text'.tr,
                      ColorUtils.yellowColor, TextAlign.end),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  obscureText: _passwordVisible.value,
                  decoration: _appUtils.inputDecorationWithLabel(
                      'password'.tr, 'password'.tr, ColorUtils.whiteColor,
                      prefixImage: 'password',
                      image: _passwordVisible.value
                          ? Icons.visibility_off
                          : Icons.visibility, onTap: () {
                    _passwordVisible.value = !_passwordVisible.value;
                  }),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'enter_password_login'.tr;
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: Checkbox(
                      checkColor: ColorUtils.whiteColor,
                      activeColor: ColorUtils.purpleColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      value: _rememberPassword.value,
                      onChanged: (bool? value) {
                        _rememberPassword.value = value!;
                      },
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: _textUtils.medium14('remember_password'.tr,
                          ColorUtils.lightBlackColor, TextAlign.start),
                    ),
                  )
                ],
              ),
              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    _appUtils.showLoadingDialog();
                    box.put("remember_password", _rememberPassword.value);
                    if (_rememberPassword.value) {
                      box.put("password", passwordController.text);
                    }
                    ApiService().login(emailController.text.trim(),
                        passwordController.text, widget.origin!);
                  }
                },
                child: Container(
                  height: 40,
                  width: Get.size.width,
                  decoration: _appUtils.boxDecoration(
                      ColorUtils.purpleColor, ColorUtils.purpleColor),
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  alignment: Alignment.center,
                  child: _textUtils.medium14('login_uppercase'.tr,
                      ColorUtils.whiteColor, TextAlign.center),
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: Divider(
                    height: 1,
                    color: ColorUtils.lightPurpleColor,
                    thickness: 1,
                  )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: _textUtils.medium14(
                        'or'.tr, ColorUtils.lightPurpleColor, TextAlign.center),
                  ),
                  Expanded(
                      child: Divider(
                    height: 1,
                    color: ColorUtils.lightPurpleColor,
                    thickness: 1,
                  )),
                ],
              ),
              const SizedBox(height: 15),
              _appUtils.socialLoginButtons()
            ],
          ),
        ),
      );
    });
  }
}
