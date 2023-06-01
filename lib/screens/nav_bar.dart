import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_go/app_utils/bottom_navy_bar.dart';
import 'package:shop_go/app_utils/color_utils.dart';
import 'package:shop_go/app_utils/common.dart';
import 'package:shop_go/app_utils/text_utils.dart';
import 'package:get/get.dart';
import 'package:shop_go/controllers/common_controller.dart';
import 'package:shop_go/model/cart_products_model.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final TextUtils _textUtils = TextUtils();
  CommonController commonController = Get.find<CommonController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      String? balance = commonController.currentBalance.value.balance;
      UserCartSession? userCartSession =
          commonController.userCart.value.userCartSession;

      return BottomNavyBar(
        selectedIndex: Common.currentIndex.value,
        showElevation: true,
        itemCornerRadius: 5,
        curve: Curves.easeIn,
        backgroundColor: ColorUtils.purpleColor,
        onItemSelected: (index) {
          if (Common.currentIndex.value == 0 && index == 0) {
            commonController.isBrandClicked.value = false;
            commonController.brandClickedUrl.value = '';
          }
          if (Common.currentIndex.value == 1 && index == 1) {
            commonController.isBrandClicked.value = false;
            commonController.brandClickedUrl.value = '';
          }
          Common.currentIndex.value = index;
        },
        items: <BottomNavyBarItem>[
          bottomWidget(
              Common.currentIndex.value == 0 ? "active_home" : "inactive_home",
              "home".tr,
              isActive: Common.currentIndex.value == 0),
          bottomWidget(
              Common.currentIndex.value == 1
                  ? "active_brands"
                  : "inactive_brands",
              "brands".tr,
              isActive: Common.currentIndex.value == 1),
          // bottomWidget(Common.currentIndex.value == 2 ? "active_cart" : "inactive_cart", cartPrice!=null&&cartPrice!="0"?cartPrice+Common.currency:"cart".tr,isActive:Common.currentIndex.value == 2),
          BottomNavyBarItem(
            icon: Stack(
              children: [
                SvgPicture.asset(
                    "assets/bottom_navigation_icons/${Common.currentIndex.value == 2 ? "active_cart.svg" : "inactive_cart.svg"}",
                    color: Common.currentIndex.value == 2
                        ? ColorUtils.whiteColor
                        : ColorUtils.yellowColor,
                    height: 20,
                    width: 20),
                if (commonController.userCart.value.productsInCart != null)
                  Padding(
                      padding: const EdgeInsets.only(left: 9, top: 1),
                      child: _textUtils.medium12(
                          commonController.userCart.value.productsInCart!.length
                              .toString(),
                          Common.currentIndex.value == 2
                              ? ColorUtils.purpleColor
                              : ColorUtils.whiteColor,
                          TextAlign.start))
              ],
            ),
            title: Common.accessToken.value != ""
                ? _textUtils.bold14(
                    userCartSession != null
                        ? userCartSession.cartTotals!.total + Common.currency
                        : "cart".tr,
                    Common.currentIndex.value == 2
                        ? ColorUtils.whiteColor
                        : ColorUtils.yellowColor,
                    TextAlign.center)
                : _textUtils.bold14(
                    "cart".tr,
                    Common.currentIndex.value == 2
                        ? ColorUtils.whiteColor
                        : ColorUtils.yellowColor,
                    TextAlign.center),
            activeColor: ColorUtils.yellowColor,
            textAlign: TextAlign.center,
          ),
          bottomWidget(
              Common.currentIndex.value == 3
                  ? "active_wallet"
                  : "inactive_wallet",
              balance != null && balance != "0"
                  ? balance + Common.currency
                  : "wallet".tr,
              isActive: Common.currentIndex.value == 3,
              balance: balance),
          bottomWidget(
              Common.currentIndex.value == 4
                  ? "favourite icon"
                  : "favourite icon",
              "wishlist".tr,
              isActive: Common.currentIndex.value == 4),
        ],
      );
    });
  }

  BottomNavyBarItem bottomWidget(icon, text, {isActive = false, balance}) {
    return BottomNavyBarItem(
      icon: SvgPicture.asset("assets/bottom_navigation_icons/$icon.svg",
          color: !isActive ? ColorUtils.yellowColor : ColorUtils.whiteColor,
          height: 20,
          width: 20),
      title: _textUtils.bold14(
          text,
          !isActive ? ColorUtils.yellowColor : ColorUtils.whiteColor,
          TextAlign.center),
      activeColor: ColorUtils.yellowColor,
      textAlign: TextAlign.center,
    );
  }
}
