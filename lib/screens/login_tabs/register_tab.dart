import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shop_go/api/api_service.dart';
import 'package:shop_go/app_utils/app_utils.dart';
import 'package:shop_go/app_utils/color_utils.dart';
import 'package:shop_go/app_utils/common.dart';
import 'package:shop_go/app_utils/text_utils.dart';
import 'package:shop_go/screens/outer_webview.dart';
import 'package:shop_go/model/external_links_model.dart';
import 'package:shop_go/controllers/common_controller.dart';

class RegisterTab extends StatefulWidget {
  const RegisterTab({Key? key}) : super(key: key);

  @override
  State<RegisterTab> createState() => _RegisterTabState();
}

class _RegisterTabState extends State<RegisterTab> {
  final AppUtils _appUtils = AppUtils();
  final TextUtils _textUtils = TextUtils();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final RxString language = ''.obs;
  final RxBool _passwordVisible = true.obs;
  final RxBool _confirmPasswordVisible = true.obs;
  final _formKey = GlobalKey<FormState>();
  final List<String> languageModel = ["English", "Arabic", "Hebrew"];
  late RxBool acceptTerm = false.obs;
  final ApiService _apiService = ApiService();
  CommonController commonController = Get.find<CommonController>();
  late Links? links;

  @override
  void initState() {
    super.initState();
    getLinks();
  }

  getLinks() {
    _apiService.getExternalLinks();
    links = commonController.externalLinks.value.links;
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
                controller: userNameController,
                keyboardType: TextInputType.text,
                decoration: _appUtils.inputDecorationWithLabel(
                    'username'.tr, 'username'.tr, ColorUtils.whiteColor,
                    prefixImage: 'username'),
                validator: (value) {
                  if (value!.trim().isEmpty ||
                      (value.trim().length < 2) ||
                      (value.trim().length > 50)) {
                    return 'enter_username'.tr;
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: _appUtils.inputDecorationWithLabel(
                      'email'.tr, 'email'.tr, ColorUtils.whiteColor,
                      prefixImage: 'email'),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'enter_email'.tr;
                    }
                    final bool isValid = EmailValidator.validate(value);
                    if (!isValid) {
                      return 'enter_correct_email'.tr;
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: TextFormField(
                  controller: firstNameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: _appUtils.inputDecorationWithLabel(
                      'first_name'.tr, 'first_name'.tr, ColorUtils.whiteColor,
                      prefixImage: 'name'),
                  validator: (value) {
                    if (value!.trim().isEmpty ||
                        (value.trim().length < 2) ||
                        (value.trim().length > 50)) {
                      return 'enter_first_name'.tr;
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: TextFormField(
                  controller: lastNameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: _appUtils.inputDecorationWithLabel(
                      'last_name'.tr, 'last_name'.tr, ColorUtils.whiteColor,
                      prefixImage: 'name'),
                  validator: (value) {
                    if (value!.trim().isEmpty ||
                        (value.trim().length < 2) ||
                        (value.trim().length > 50)) {
                      return 'enter_last_name'.tr;
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: TextFormField(
                  controller: phoneNumberController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                  ],
                  maxLength: 10,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                        fontSize: 14,
                        color: ColorUtils.hintColor,
                        height: 1.5,
                        fontFamily: Common.fontFamily,
                        fontWeight: FontWeight.w500),
                    hintText: '5XX XXXXXXX',
                    labelStyle: TextStyle(
                        fontSize: 14,
                        color: ColorUtils.hintColor,
                        height: 1,
                        fontFamily: Common.fontFamily,
                        fontWeight: FontWeight.w500),
                    labelText: 'phone_number'.tr,
                    floatingLabelStyle:
                        TextStyle(color: ColorUtils.purpleColor),
                    filled: true,
                    alignLabelWithHint: true,
                    fillColor: ColorUtils.whiteColor,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: ColorUtils.lightPurpleColor)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: ColorUtils.purpleColor)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: ColorUtils.lightPurpleColor)),
                    prefixIcon: SizedBox(
                      width: 80,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: SvgPicture.asset('assets/images/phone.svg',
                                height: 20,
                                width: 20,
                                color: ColorUtils.purpleColor),
                          ),
                          const Text('+972 ')
                        ],
                      ),
                    ),
                  ),
                  validator: (value) {
                    if ((value!.startsWith('0') && value.length != 10) ||
                        (!value.startsWith('0') && value.length != 9)) {
                      return 'enter_phone_number'.tr;
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                decoration: _appUtils.boxDecoration(
                    Colors.transparent, ColorUtils.lightPurpleColor),
                child: ExpansionTile(
                  trailing: Icon(Icons.keyboard_arrow_down,
                      size: 25, color: ColorUtils.blackColor),
                  key: GlobalKey(),
                  title: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: SvgPicture.asset('assets/images/language.svg',
                            height: 20,
                            width: 20,
                            color: ColorUtils.purpleColor),
                      ),
                      Expanded(
                        child: _textUtils.medium14(
                            language.value == ''
                                ? 'language'.tr
                                : language.value,
                            language.value == ''
                                ? ColorUtils.hintColor
                                : ColorUtils.blackColor,
                            TextAlign.start),
                      ),
                    ],
                  ),
                  children: <Widget>[
                    Column(
                      children: [
                        Divider(
                            height: 10.0, color: ColorUtils.lightPurpleColor),
                        const SizedBox(height: 10),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: languageModel.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, i) => InkWell(
                              onTap: () {
                                language.value = languageModel[i];
                              },
                              child: _appUtils.makeDropDown(
                                  languageModel[i], language.value)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
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
                    if (value!.isEmpty ||
                        !value.contains(RegExp(r'[A-Z]')) ||
                        !value.contains(RegExp(r'[a-z]')) ||
                        !value.contains(RegExp(r'[0-9]')) ||
                        !value.contains(
                            RegExp(r'(?=.*?[#?!@$%^&*-.,+_/():;{}\[\]\\])')) ||
                        (value.length < 5) ||
                        (value.length > 21)) {
                      return 'enter_password'.tr;
                    }
                    if (value != confirmPasswordController.text) {
                      return "password_wrong".tr;
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: TextFormField(
                  controller: confirmPasswordController,
                  keyboardType: TextInputType.text,
                  obscureText: _confirmPasswordVisible.value,
                  decoration: _appUtils.inputDecorationWithLabel(
                      'confirm_password'.tr,
                      'confirm_password'.tr,
                      ColorUtils.whiteColor,
                      prefixImage: 'password',
                      image: _confirmPasswordVisible.value
                          ? Icons.visibility_off
                          : Icons.visibility, onTap: () {
                    _confirmPasswordVisible.value =
                        !_confirmPasswordVisible.value;
                  }),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'enter_confirm_password'.tr;
                    }
                    if (value != passwordController.text) {
                      return "confirm_password_wrong".tr;
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: Checkbox(
                      checkColor: ColorUtils.whiteColor,
                      activeColor: ColorUtils.purpleColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      value: acceptTerm.value,
                      onChanged: (bool? value) {
                        acceptTerm.value = value!;
                      },
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      acceptTerm.value = !acceptTerm.value;
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: _textUtils.medium14('I read and understand'.tr,
                              ColorUtils.lightBlackColor, TextAlign.start),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => OuterWebView(url: links!.terms!));
                          },
                          child: _textUtils.medium14(' terms & conditions'.tr,
                              ColorUtils.purpleColor, TextAlign.start),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    if (language.value != "") {
                      if (!acceptTerm.value) {
                        _appUtils
                            .showToast("Read and accept terms & conditions".tr);
                      } else {
                        _appUtils.showLoadingDialog();
                        String languageCode = '';
                        switch (language.value) {
                          case 'English':
                            languageCode = 'en_US';
                            break;
                          case 'Arabic':
                            languageCode = 'ar';
                            break;
                          case 'Hebrew':
                            languageCode = 'he_IL';

                            break;
                          default:
                            languageCode = 'en_US';
                        }
                        ApiService().registerUser(
                            userNameController.text.trim(),
                            emailController.text.trim(),
                            passwordController.text,
                            confirmPasswordController.text,
                            phoneNumberController.text.trim(),
                            firstNameController.text.trim(),
                            lastNameController.text.trim(),
                            languageCode);
                      }
                    } else {
                      _appUtils.showToast("choose_language".tr);
                    }
                  }
                },
                child: Container(
                  height: 40,
                  width: Get.size.width,
                  decoration: _appUtils.boxDecoration(
                      ColorUtils.purpleColor, ColorUtils.purpleColor),
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  alignment: Alignment.center,
                  child: _textUtils.medium14(
                      'register'.tr, ColorUtils.whiteColor, TextAlign.center),
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: Divider(
                          height: 1, color: ColorUtils.lightPurpleColor)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: _textUtils.medium14(
                        'or'.tr, ColorUtils.lightPurpleColor, TextAlign.center),
                  ),
                  Expanded(
                      child: Divider(
                          height: 1, color: ColorUtils.lightPurpleColor)),
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

  Widget socialWidget(image, text) {
    return Container(
      height: 45,
      width: Get.size.width,
      decoration: _appUtils.boxDecoration(
          Colors.transparent, ColorUtils.lightPurpleColor),
      margin: const EdgeInsets.symmetric(vertical: 7),
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Align(
                  alignment: Alignment.centerRight,
                  child: SvgPicture.asset(image, height: 20, width: 20))),
          const SizedBox(width: 20),
          Expanded(
              flex: 2,
              child: _textUtils.semiBold14(
                  text, ColorUtils.blackColor, TextAlign.start)),
        ],
      ),
    );
  }
}
