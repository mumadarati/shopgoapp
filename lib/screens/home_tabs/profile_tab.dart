import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:shop_go/api/api_service.dart';
import 'package:shop_go/app_utils/app_utils.dart';
import 'package:shop_go/app_utils/color_utils.dart';
import 'package:shop_go/app_utils/common.dart';
import 'package:shop_go/app_utils/text_utils.dart';
import 'package:shop_go/controllers/common_controller.dart';
import 'package:shop_go/model/external_links_model.dart';
import 'package:shop_go/screens/edit_profile_screen.dart';
import 'package:shop_go/screens/home_screen.dart';
import 'package:shop_go/screens/payment_methods_screen.dart';
import 'package:shop_go/screens/my_addresses_screen.dart';
import 'package:shop_go/screens/shipping_calculator_screen.dart';
import 'package:shop_go/screens/outer_webview.dart';
import 'package:shop_go/screens/tracking_page_view.dart';
import 'package:shop_go/screens/yugo_screen.dart';
import 'package:shop_go/screens/yugo_terms.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final AppUtils _appUtils = AppUtils();
  final TextUtils _textUtils = TextUtils();
  final ApiService _apiService = ApiService();
  CommonController commonController = Get.find<CommonController>();
  var box = Hive.box('credentials');

  @override
  void initState() {
    super.initState();
    _apiService.getExternalLinks();
    if (Common.accessToken.value != "") {
      Common.rememberPassword.value = box.get("remember_password");
      debugPrint(Common.rememberPassword.value.toString());
      Common.userId.value = box.get("userId").toString();
      _apiService.getCustomerDetail(Common.userId.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appUtils.homeAppBarWidget(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15.0),
          child: Obx(
            () {
              Links? links = commonController.externalLinks.value.links;
              return Column(
                children: [
                  if (Common.accessToken.value != "")
                    InkWell(
                        onTap: () {
                          Get.to(() => const EditProfileScreen());
                        },
                        child: profileWidget("my_account".tr,
                            icon: CupertinoIcons.person_alt_circle)),
                  InkWell(
                      onTap: () {
                        Common.currentIndex.value = 1;
                        Get.to(() => const HomeScreen());
                      },
                      child: profileWidget("wego_order".tr,
                          image: "wego.png", hasImage: true)),
                  InkWell(
                      onTap: () {
                        Common.rememberPassword.value == true
                            ? Get.to(() => const YuGoScreen(
                                  origin: "profile",
                                ))
                            : Get.to(() => const YuGoTermsScreen(
                                  fromPage: 'profile',
                                ));
                      },
                      child: profileWidget("yugo_order".tr,
                          image: "yugo.png", hasImage: true)),
                  InkWell(
                      onTap: () => Get.to(() => const TrackingOrderPage()),
                      child: profileWidget("track_order".tr,
                          icon: CupertinoIcons.cube_fill)),
                  InkWell(
                      onTap: () => Get.to(() => const PaymentMethodsScreen()),
                      child: profileWidget("Wallet",
                          icon: CupertinoIcons.creditcard)),
                  InkWell(
                      onTap: () => Get.to(() => const PaymentMethodsScreen()),
                      child: profileWidget("payments".tr,
                          icon: Icons.account_balance_wallet_outlined)),
                  InkWell(
                      onTap: () => Get.to(() => const MyAddressesScreen()),
                      child: profileWidget("my_address".tr,
                          icon: CupertinoIcons.location_solid)),
                  InkWell(
                      onTap: () =>
                          Get.to(() => const ShippingCalculatorScreen()),
                      child: profileWidget("shipping_calculator".tr,
                          icon: Icons.calculate_outlined)),
                  InkWell(
                      onTap: () {
                        Get.to(() => OuterWebView(url: links!.howItWorks!));
                      },
                      child: profileWidget("how_it_works".tr,
                          icon: CupertinoIcons.question)),
                  InkWell(
                      onTap: () =>
                          Get.to(() => OuterWebView(url: links!.whatIsShopgo!)),
                      child: profileWidget("What is ShopGO?",
                          icon: CupertinoIcons.question)),
                  // InkWell(
                  //     onTap: () => _launchUrl(links!.wego!),
                  //     child: profileWidget("WEGO",
                  //         image: "wego.png", hasImage: true)),
                  // InkWell(
                  //     onTap: () => _launchUrl(links!.yugo!),
                  //     child: profileWidget("YUGO",
                  //         image: "yugo.png", hasImage: true)),
                  // InkWell(
                  //     onTap: () => _launchUrl(links!.bannedProducts!),
                  //     child: profileWidget("Banned Products",
                  //         icon: CupertinoIcons.question)),
                  InkWell(
                      onTap: () =>
                          Get.to(() => OuterWebView(url: links!.terms!)),
                      child: profileWidget("Terms and Conditions",
                          icon: CupertinoIcons.question)),
                  InkWell(
                      onTap: () =>
                          Get.to(() => OuterWebView(url: links!.privacy!)),
                      child: profileWidget("Privacy Policy",
                          icon: CupertinoIcons.question)),
                  profileWidget("customer_service".tr,
                      icon: Icons.support_agent_rounded),
                  profileWidget(
                    "rate_us".tr,
                    icon: CupertinoIcons.star_fill,
                  ),
                  if (Common.accessToken.value != "")
                    InkWell(
                        onTap: () {
                          Get.defaultDialog(
                            title: "confirmation".tr,
                            middleText: "logout_confirmation".tr,
                            textConfirm: "yes".tr,
                            textCancel: "cancel".tr,
                            onConfirm: () async {
                              Get.back();
                              _appUtils.showLoadingDialog();
                              _apiService.logout();
                            },
                            buttonColor: ColorUtils.purpleColor,
                            confirmTextColor: ColorUtils.whiteColor,
                            cancelTextColor: ColorUtils.purpleColor,
                          );
                        },
                        child: profileWidget("logout".tr,
                            icon: CupertinoIcons.lock_fill)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget profileWidget(text, {icon, hasImage = false, image}) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      margin: const EdgeInsets.only(bottom: 10),
      alignment: Alignment.center,
      decoration: _appUtils.boxDecoration(
          Colors.transparent, ColorUtils.lightGrayColor),
      child: Row(
        children: [
          hasImage == true
              ? Image.asset(
                  "assets/images/$image",
                  height: 30,
                  width: 30,
                  color: ColorUtils.purpleColor,
                )
              : Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: ColorUtils.purpleColor),
                  child: Icon(icon, color: ColorUtils.whiteColor, size: 20)),
          const SizedBox(width: 10),
          Expanded(
              child: _textUtils.normal14(
                  text, ColorUtils.purpleColor, TextAlign.start)),
          const SizedBox(width: 10),
          Icon(Icons.arrow_forward_ios,
              color: ColorUtils.yellowColor, size: 20),
        ],
      ),
    );
  }
}
