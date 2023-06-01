import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:shop_go/api/api_service.dart';
import 'package:shop_go/app_utils/app_utils.dart';
import 'package:shop_go/app_utils/bottom_navy_bar.dart';
import 'package:shop_go/app_utils/color_utils.dart';
import 'package:shop_go/app_utils/common.dart';
import 'package:shop_go/app_utils/text_utils.dart';
import 'package:shop_go/controllers/common_controller.dart';
import 'package:shop_go/screens/home_tabs/brands_tab.dart';
import 'package:shop_go/screens/home_tabs/cart_tab.dart';
import 'package:shop_go/screens/home_tabs/home_tab.dart';
import 'package:shop_go/screens/home_tabs/wallet_tab.dart';
import 'package:shop_go/screens/home_tabs/wish_list_tab.dart';
import 'package:shop_go/screens/login_screen.dart';
import 'package:shop_go/screens/nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextUtils _textUtils = TextUtils();
  final AppUtils _appUtils = AppUtils();
  CommonController commonController = Get.find<CommonController>();
  @override
  void initState() {
    super.initState();
    var box = Hive.box('credentials');
    var userId = box.get("userId").toString();
    debugPrint("User id : $userId");
    commonController.customerDetail.value.firstName = '';
    commonController.customerDetail.value.lastName = '';
    ApiService().getCustomerDetail(userId.toString());
    ApiService().getUserCart();
    ApiService().getCurrentBalance();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          backgroundColor: ColorUtils.whiteColor,
          appBar: (commonController.isBrandClicked.value &&
                      (Common.currentIndex.value == 0 ||
                          Common.currentIndex.value == 1)) ||
                  (Common.currentIndex.value == 2 &&
                      Common.accessToken.value == "") ||
                  (Common.currentIndex.value == 3 &&
                      Common.accessToken.value == "") ||
                  (Common.currentIndex.value == 4 &&
                      Common.accessToken.value == "")
              ? null
              : _appUtils.homeAppBarWidget(),
          body: SafeArea(child: changePage()),
          bottomNavigationBar: const NavBar());
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
  // Widget changeTitle() {
  //
  //   if (Common.currentIndex.value == 0) {
  //     return SvgPicture.asset("assets/images/text_logo.svg", height: 30,color: ColorUtils.whiteColor,);
  //   } else if (Common.currentIndex.value == 1) {
  //     return _textUtils.bold20("Brands", ColorUtils.yellowColor, TextAlign.center);
  //   } else if (Common.currentIndex.value == 2) {
  //     return _textUtils.bold20("my_cart".tr, ColorUtils.yellowColor, TextAlign.center);
  //   } else if (Common.currentIndex.value == 3) {
  //     return _textUtils.bold20("my_wallet".tr, ColorUtils.yellowColor, TextAlign.center);
  //   } else {
  //     return _textUtils.bold20("my_profile".tr, ColorUtils.yellowColor, TextAlign.center);
  //   }
  // }

  Widget changePage() {
    if (Common.currentIndex.value == 0) {
      return const HomeTab();
    } else if (Common.currentIndex.value == 1) {
      return const BrandsTab();
    } else if (Common.currentIndex.value == 2) {
      if (Common.accessToken.value == "") {
        Common.isFromCurrentIndex = true.obs;
        return (const LoginScreen(origin: "cart"));
      } else {
        Common.isFromCurrentIndex = false.obs;
        return const CartTab();
      }
    } else if (Common.currentIndex.value == 3) {
      if (Common.accessToken.value == "") {
        Common.isFromCurrentIndex = true.obs;
        return (const LoginScreen(origin: "wallet"));
      } else {
        Common.isFromCurrentIndex = false.obs;
        return const WalletTab();
      }
    } else if (Common.currentIndex.value == 4) {
      if (Common.accessToken.value == "") {
        Common.isFromCurrentIndex = true.obs;
        return (const LoginScreen(origin: "wishList"));
      } else {
        Common.isFromCurrentIndex = false.obs;
        return const WishListTab();
      }
    } else {
      return (const LoginScreen());
    }
  }
}
