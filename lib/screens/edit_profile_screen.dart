import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_go/api/api_service.dart';
import 'package:shop_go/app_utils/app_utils.dart';
import 'package:shop_go/app_utils/color_utils.dart';
import 'package:shop_go/app_utils/common.dart';
import 'package:shop_go/app_utils/text_utils.dart';
import 'package:shop_go/controllers/common_controller.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final AppUtils _appUtils = AppUtils();
  final TextUtils _textUtils = TextUtils();
  final ApiService _apiService = ApiService();
  CommonController commonController = Get.find<CommonController>();

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final RxString language = ''.obs;
  final RxBool _oldPasswordVisible = true.obs;
  final RxBool _passwordVisible = true.obs;
  final RxBool _confirmPasswordVisible = true.obs;

  final List<String> languageModel = ["English", "Spanish", "German", "Arabic"];
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController.text = commonController.customerDetail.value.email ?? "";
    firstNameController.text =
        commonController.customerDetail.value.firstName ?? "";
    lastNameController.text =
        commonController.customerDetail.value.lastName ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.whiteColor,
      appBar: _appUtils.homeAppBarWidget(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15.0),
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _textUtils.bold20(
                    "edit_name".tr, ColorUtils.blackColor, TextAlign.start),
                Form(
                    key: _formKey1,
                    child: Column(
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 15),
                        //   child: TextFormField(
                        //     controller: userNameController,
                        //     keyboardType: TextInputType.text,
                        //     decoration: _appUtils.inputDecorationWithLabel(
                        //         'Username', 'Username', ColorUtils.whiteColor,
                        //         prefixImage: 'username'),
                        //     validator: (value) {
                        //       if (value!.isEmpty) {
                        //         return 'Please Enter Username';
                        //       }
                        //       return null;
                        //     },
                        //   ),
                        // ),
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
                              if (!RegExp(
                                      r"([a-zA-Z0-9\.!#$%&'*+/=?^_`{|}~-]+)@([a-zA-Z0-9]+)(\.)([a-zA-Z0-9]+)(\.)?([a-zA-Z0-9]+)?")
                                  .hasMatch(value)) {
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
                                'first_name'.tr,
                                'first_name'.tr,
                                ColorUtils.whiteColor,
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
                                'last_name'.tr,
                                'last_name'.tr,
                                ColorUtils.whiteColor,
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
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 15),
                        //   child: TextFormField(
                        //     controller: phoneNumberController,
                        //     keyboardType: TextInputType.number,
                        //     decoration: _appUtils.inputDecorationWithLabel(
                        //         'Phone Number', 'Phone Number', ColorUtils.whiteColor,
                        //         prefixImage: 'phone'),
                        //     validator: (value) {
                        //       if (value!.isEmpty) {
                        //         return 'Please Enter Phone Number';
                        //       }
                        //       return null;
                        //     },
                        //   ),
                        // ),
                        // Container(
                        //   margin: const EdgeInsets.only(top: 15),
                        //   decoration: _appUtils.boxDecoration(
                        //       Colors.transparent, ColorUtils.lightPurpleColor),
                        //   child: ExpansionTile(
                        //     trailing: Icon(Icons.keyboard_arrow_down,
                        //         size: 25, color: ColorUtils.blackColor),
                        //     key: GlobalKey(),
                        //     title: Row(
                        //       children: [
                        //         Padding(
                        //           padding: const EdgeInsets.only(right: 15),
                        //           child: SvgPicture.asset(
                        //               'assets/images/language.svg',
                        //               height: 20,
                        //               width: 20,
                        //               color: ColorUtils.purpleColor),
                        //         ),
                        //         Expanded(
                        //           child: _textUtils.medium14(
                        //               language.value == ''
                        //                   ? 'Language'
                        //                   : language.value,
                        //               language.value == ''
                        //                   ? ColorUtils.hintColor
                        //                   : ColorUtils.blackColor,
                        //               TextAlign.start),
                        //         ),
                        //       ],
                        //     ),
                        //     children: <Widget>[
                        //       Column(
                        //         children: [
                        //           Divider(
                        //               height: 10.0,
                        //               color: ColorUtils.lightPurpleColor),
                        //           const SizedBox(height: 10),
                        //           ListView.builder(
                        //             physics: const NeverScrollableScrollPhysics(),
                        //             shrinkWrap: true,
                        //             itemCount: languageModel.length,
                        //             scrollDirection: Axis.vertical,
                        //             itemBuilder: (context, i) => InkWell(
                        //                 onTap: () {
                        //                   language.value = languageModel[i];
                        //                 },
                        //                 child: _appUtils.makeDropDown(
                        //                     languageModel[i], language.value)),
                        //           ),
                        //         ],
                        //       )
                        //     ],
                        //   ),
                        // ),
                      ],
                    )),
                InkWell(
                  onTap: () async {
                    if (_formKey1.currentState!.validate()) {
                      _appUtils.showLoadingDialog();
                      await _apiService.updateCustomerProfile(
                          Common.userId.value,
                          firstNameController.text,
                          lastNameController.text,
                          emailController.text);
                    await  ApiService().getCustomerDetail(Common.userId.value);
                    }
                  },
                  child: Container(
                    height: 40,
                    width: Get.size.width,
                    decoration: _appUtils.boxDecoration(
                        ColorUtils.purpleColor, ColorUtils.purpleColor),
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    alignment: Alignment.center,
                    child: _textUtils.medium14('Update Profile',
                        ColorUtils.whiteColor, TextAlign.center),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                _textUtils.bold20("change_password".tr, ColorUtils.blackColor,
                    TextAlign.start),
                Form(
                    key: _formKey2,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: TextFormField(
                            controller: oldPasswordController,
                            keyboardType: TextInputType.text,
                            obscureText: _oldPasswordVisible.value,
                            decoration: _appUtils.inputDecorationWithLabel(
                                'old_password'.tr,
                                'old_password'.tr,
                                ColorUtils.whiteColor,
                                prefixImage: 'password',
                                image: _oldPasswordVisible.value
                                    ? Icons.visibility_off
                                    : Icons.visibility, onTap: () {
                              _oldPasswordVisible.value =
                                  !_oldPasswordVisible.value;
                            }),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'enter_old_password'.tr;
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: TextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.text,
                            obscureText: _passwordVisible.value,
                            decoration: _appUtils.inputDecorationWithLabel(
                                'new_password'.tr,
                                'new_password'.tr,
                                ColorUtils.whiteColor,
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
                                  !value.contains(RegExp(
                                      r'(?=.*?[#?!@$%^&*-.,+_/():;{}\[\]\\])')) ||
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
                      ],
                    )),
                InkWell(
                  onTap: () async {
                    if (_formKey2.currentState!.validate()) {
                      _appUtils.showLoadingDialog();
                      await _apiService.changePasswordApi(Common.userId.value,
                          oldPasswordController.text, passwordController.text);
                    }
                  },
                  child: Container(
                    height: 40,
                    width: Get.size.width,
                    decoration: _appUtils.boxDecoration(
                        ColorUtils.purpleColor, ColorUtils.purpleColor),
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    alignment: Alignment.center,
                    child: _textUtils.medium14('update_password'.tr,
                        ColorUtils.whiteColor, TextAlign.center),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
