import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shop_go/api/api_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jovial_svg/jovial_svg.dart';
import 'package:shop_go/app_utils/color_utils.dart';
import 'package:shop_go/app_utils/common.dart';
import 'package:shop_go/app_utils/text_utils.dart';
import 'package:shop_go/controllers/common_controller.dart';
import 'package:shop_go/model/customer_detail_model.dart';
import 'package:shop_go/screens/categories_brand_screen.dart';
import 'package:shop_go/screens/home_tabs/profile_tab.dart';
import 'package:shop_go/screens/login_screen.dart';

class AppUtils {
  final TextUtils _textUtils = TextUtils();
  CommonController commonController = Get.find<CommonController>();

  boxDecoration(color, borderColor, {giveShadow, radius = 5.0}) {
    return BoxDecoration(
      color: color,
      border: Border.all(color: borderColor),
      borderRadius: BorderRadius.circular(radius + 0.0),
      boxShadow: giveShadow != null && giveShadow
          ? [
              BoxShadow(
                  color: ColorUtils.whiteGreyColor,
                  spreadRadius: 3,
                  blurRadius: 1,
                  offset: const Offset(1, 1))
            ]
          : [],
    );
  }

  inputDecorationWithLabel(hint, labelText, fillColor,
      {prefixImage, image, onTap}) {
    return InputDecoration(
      hintStyle: TextStyle(
          fontSize: 14,
          color: ColorUtils.hintColor,
          height: 1.5,
          fontFamily: Common.fontFamily,
          fontWeight: FontWeight.w500),
      hintText: hint,
      labelStyle: TextStyle(
          fontSize: 14,
          color: ColorUtils.hintColor,
          height: 1,
          fontFamily: Common.fontFamily,
          fontWeight: FontWeight.w500),
      labelText: labelText == "" ? null : labelText,
      floatingLabelStyle: TextStyle(color: ColorUtils.purpleColor),
      filled: true,
      alignLabelWithHint: true,
      fillColor: fillColor,
      errorMaxLines: 2,
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: ColorUtils.lightPurpleColor)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: ColorUtils.purpleColor)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: ColorUtils.lightPurpleColor)),
      suffixIcon: image != null
          ? InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Icon(image, size: 20, color: ColorUtils.blackColor),
              ),
            )
          : null,
      prefixIcon: prefixImage != null
          ? Padding(
              padding: const EdgeInsets.all(15.0),
              child: SvgPicture.asset('assets/images/$prefixImage.svg',
                  height: 10, width: 10, color: ColorUtils.purpleColor),
            )
          : null,
    );
  }

  brandItem(brands) {
    return Container(
      padding: const EdgeInsets.all(5),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: ColorUtils.purpleColor.withOpacity(.5))),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Center(
        child: brands.brandLogo!.split('.').last == "svg"
            ? ScalableImageWidget.fromSISource(
                si: ScalableImageSource.fromSvgHttpUrl(
                    Uri.parse(brands.brandLogo!)),
                onError: (context) => Image.asset("assets/images/img.png"),
                onLoading: (context) =>
                    CupertinoActivityIndicator(color: ColorUtils.purpleColor))
            : CachedNetworkImage(
                imageUrl: brands.brandLogo!.toString(),
                //color: ColorUtils.purpleColor,
                placeholder: (context, url) =>
                    CupertinoActivityIndicator(color: ColorUtils.purpleColor),
                errorWidget: (context, url, error) =>
                    Image.asset("assets/images/img.png"),
              ),
      ),
    );
  }

  String allWordsCapitalize(String str) {
    return str.toLowerCase().split(' ').map((word) {
      String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
      return word[0].toUpperCase() + leftText;
    }).join(' ');
  }

  Widget categoryItem(Map categoryData) {
    return GestureDetector(
      onTap: () {
        var categories = commonController.brandCategories.value.brandsList!;
        if (categoryData["title"] == categories.womenCat!.title) {
          Get.to(() => CategoriesBrandScreen(
                categoryName: categoryData["title"],
                categoryId: categoryData["id"],
              ));
        } else if (categoryData["title"] == categories.menCat!.title) {
          Get.to(() => CategoriesBrandScreen(
                categoryName: categoryData["title"],
                categoryId: categoryData["id"],
              ));
        } else if (categoryData["title"] == categories.kidsCat!.title) {
          Get.to(() => CategoriesBrandScreen(
                categoryName: categoryData["title"],
                categoryId: categoryData["id"],
              ));
        } else if (categoryData["title"] == categories.homeCat!.title) {
          Get.to(() => CategoriesBrandScreen(
                categoryName: categoryData["title"],
                categoryId: categoryData["id"],
              ));
        } else if (categoryData["title"] == categories.cosmeticsCat!.title) {
          Get.to(() => CategoriesBrandScreen(
                categoryName: categoryData["title"],
                categoryId: categoryData["id"],
              ));
        } else if (categoryData["title"] == categories.accessoriesCat!.title) {
          Get.to(() => CategoriesBrandScreen(
                categoryName: categoryData["title"],
                categoryId: categoryData["id"],
              ));
        } else if (categoryData["title"] == categories.shoesCat!.title) {
          Get.to(() => CategoriesBrandScreen(
                categoryName: categoryData["title"],
                categoryId: categoryData["id"],
              ));
        } else if (categoryData["title"] == categories.sweetsCat!.title) {
          Get.to(() => CategoriesBrandScreen(
                categoryName: categoryData["title"],
                categoryId: categoryData["id"],
              ));
        }
      },
      child: Container(
        margin: const EdgeInsets.only(right: 7),
        padding: const EdgeInsets.all(5),
        width: 80,
        height: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: ColorUtils.purpleColor),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          children: [
            Expanded(
              child: CachedNetworkImage(
                color: ColorUtils.whiteColor,
                imageUrl: categoryData["icon"],
                placeholder: (context, url) =>
                    CupertinoActivityIndicator(color: ColorUtils.whiteColor),
                errorWidget: (context, url, error) => Image.asset(
                  "assets/images/img.png",
                  color: ColorUtils.whiteColor,
                ),
              ),
            ),
            Expanded(
                child: Center(
                    child: _textUtils.semiBold9(
                        allWordsCapitalize(categoryData["title"]),
                        ColorUtils.whiteColor,
                        TextAlign.center,
                        maxLines: 2))),
          ],
        ),
      ),
    );
  }

  makeDropDown(title, index) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _textUtils.medium14(
                  title,
                  index == title
                      ? ColorUtils.purpleColor
                      : ColorUtils.blackColor,
                  TextAlign.start),
              Visibility(
                visible: index == title ? true : false,
                child: Icon(Icons.check,
                    color: ColorUtils.purpleColor, size: 16.0),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Divider(height: 10.0, color: ColorUtils.lightPurpleColor),
          ),
        ],
      ),
    );
  }

  numberCounter(
      {decrement,
      value,
      increment,
      showBorder = true,
      height = 40,
      hPadding = 0.0}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: decrement,
          child: Center(
              child: Icon(
            CupertinoIcons.minus_square_fill,
            color: ColorUtils.lightBlackColor,
            size: 20,
          )),
        ),
        Expanded(
            child: _textUtils.normal14(
          "$value",
          ColorUtils.lightBlackColor,
          TextAlign.center,
        )),
        InkWell(
          onTap: increment,
          child: Icon(
            CupertinoIcons.plus_app_fill,
            color: ColorUtils.yellowColor,
            size: 20,
          ),
        )
      ],
    );
  }

  addressItem(
    Shipping? shipping, {
    onTap,
  }) {
    return Container(
      height: 100,
      decoration: boxDecoration(
        ColorUtils.whiteColor,
        ColorUtils.purpleColor,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    decoration: boxDecoration(
                      ColorUtils.whiteColor,
                      ColorUtils.whiteColor,
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.asset("assets/images/map_image.png",
                        fit: BoxFit.cover, width: 80, height: 80),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _textUtils.bold14(shipping!.company.toString(),
                            ColorUtils.purpleColor, TextAlign.start),
                        const SizedBox(
                          height: 10,
                        ),
                        _textUtils.normal14(
                            shipping.address1! +
                                shipping.city! +
                                shipping.country!,
                            ColorUtils.lightBlackColor,
                            TextAlign.start)
                      ],
                    ),
                  )
                ],
              ),
            ),
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

  unitItem({text = "", isSelected = false, onTap}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              padding: const EdgeInsets.all(.8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    width: 1,
                    color: isSelected
                        ? ColorUtils.purpleColor
                        : ColorUtils.lightGrayColor),
              ),
              child: Icon(
                CupertinoIcons.circle_fill,
                size: 12,
                color: isSelected
                    ? ColorUtils.purpleColor
                    : ColorUtils.lightGrayColor,
              )),
          _textUtils.normal14(
              " $text",
              isSelected ? ColorUtils.purpleColor : ColorUtils.lightGrayColor,
              TextAlign.start)
        ],
      ),
    );
  }

  totalPriceWidget(title, value, {isLarge = false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: isLarge
            ? [
                Expanded(
                  child: _textUtils.bold18(
                      "$title", ColorUtils.blackColor, TextAlign.start),
                ),
                _textUtils.bold18(
                    "$value", ColorUtils.blackColor, TextAlign.start),
                _textUtils.bold18(
                    Common.currency, ColorUtils.purpleColor, TextAlign.start)
              ]
            : [
                Expanded(
                  child: _textUtils.normal13(
                      "$title", ColorUtils.blackColor, TextAlign.start),
                ),
                _textUtils.normal13(
                    "$value", ColorUtils.blackColor, TextAlign.start),
                _textUtils.normal13(
                    Common.currency, ColorUtils.purpleColor, TextAlign.start),
              ],
      ),
    );
  }

  sliderIndicator({count, currentIndex}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < count; i++)
            Container(
              margin: const EdgeInsets.only(right: 7),
              height: 5,
              width: currentIndex == i ? 25 : 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: currentIndex == i
                    ? ColorUtils.yellowColor
                    : ColorUtils.lightGrayColor,
              ),
              child: const SizedBox(),
            )
        ],
      ),
    );
  }

  showLoadingDialog() {
    Get.dialog(
      Center(
          child: CircularProgressIndicator(
              backgroundColor: ColorUtils.purpleColor,
              color: ColorUtils.whiteColor)),
      barrierDismissible: false,
      useSafeArea: true,
    );
  }

  showToast(text) {
    return Fluttertoast.showToast(
        msg: text + "",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0);
  }

  showSnakeBar(title, text) {
    return Get.snackbar(title, text,
        snackPosition: SnackPosition.BOTTOM,
        overlayBlur: 5.0,
        backgroundColor: ColorUtils.purpleColor,
        colorText: Colors.white);
  }

  placeholderText(String text, height) {
    return SizedBox(
        height: height,
        child: Center(
            child: _textUtils.medium16(
                text, ColorUtils.purpleColor, TextAlign.start)));
  }

  circularProgressIndicator({double? height}) {
    return SizedBox(
      height: height,
      child: Center(
        child: CircularProgressIndicator(color: ColorUtils.purpleColor),
      ),
    );
  }

  socialLoginButtons() {
    final ApiService apiService = ApiService();
    return Column(
      children: [
        socialWidget('assets/images/google.svg', "google_login".tr,
            onTap: () async {
          await signInWithGoogle();
          if (FirebaseAuth.instance.currentUser != null) {
            var uid = FirebaseAuth.instance.currentUser?.uid;
            var idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
            var displayName = FirebaseAuth.instance.currentUser?.displayName;
            var email = FirebaseAuth.instance.currentUser?.email;

            await apiService.login(
                '', '', "start", true, uid!, idToken!, email!, displayName!);
          } else {
            Get.back();
          }
        }),
        socialWidget('assets/images/facebook.svg', "facebook_login".tr,
            onTap: () {
          showToast("This option is not available for now");
        }),
        if (defaultTargetPlatform == TargetPlatform.iOS)
          socialWidget('assets/images/apple.svg', "apple_login".tr),
      ],
    );
  }

  Widget socialWidget(image, text, {onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45,
        width: Get.size.width,
        decoration:
            boxDecoration(Colors.transparent, ColorUtils.lightPurpleColor),
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
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // showLoadingDialog();
    var credential;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken!, idToken: googleAuth.idToken!);
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print('errr $e');
    }

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook() async {
    showLoadingDialog();
    final LoginResult loginResult = await FacebookAuth.instance.login();
    final OAuthCredential credential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void checkUser(String email) async {
    // int code = await ApiInterface().loginWithEmail(email);
    // if (code == 200) {
    //   _appUtils.showToast("Logged in successfully");
    //   await Hive.openBox('credentials');
    //   var box = Hive.box('credentials');
    //   box.put('loginCredential', email);
    //   box.put('loginBy', "email");
    // if (commonController.loginResponse.value.user != null) {
    //   if (commonController.loginResponse.value.user!.fullName == null || commonController.loginResponse.value.user!.fullName!.isEmpty) {
    //     Common.emailVerified.value = true;
    //     Get.offAll(() => const HomeScreen());
    //   } else {
    //     await ApiInterface().getProfileDetails();
    //     Get.offAll(() => const HomeTabScreen());
    //   }
    // }
    //}
  }

  simpleAppBarWidget() {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      title: SvgPicture.asset(
        "assets/images/shop_go_text.svg",
        height: 35,
      ),
    );
  }

  homeAppBarWidget() {
    return AppBar(
      backgroundColor: ColorUtils.purpleColor,
      elevation: 0,
      leadingWidth: 70,
      leading: InkWell(
        onTap: () {
          if (Common.accessToken.value != "") {
            // Common.currentIndex.value=2;
            Get.to(() => const ProfileTab());
          } else {
            Get.to(() => const LoginScreen(
                  origin: "home",
                ));
          }
        },
        child: Container(
          padding: const EdgeInsets.only(top: 10),
          width: 50,
          child: Icon(CupertinoIcons.person_solid,
              color: ColorUtils.yellowColor, size: 30),
        ),
      ),
      title: Common.accessToken.value != ""
          ? Obx(
              () => commonController.customerDetail.value.firstName != null &&
                      commonController.customerDetail.value.lastName != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _textUtils.bold18(
                            commonController.customerDetail.value.firstName
                                .toString(),
                            ColorUtils.whiteColor,
                            TextAlign.start),
                        const SizedBox(
                          width: 5,
                        ),
                        _textUtils.bold19(
                            commonController.customerDetail.value.lastName
                                .toString(),
                            ColorUtils.yellowColor,
                            TextAlign.start),
                      ],
                    )
                  : const SizedBox(),
            )
          : InkWell(
              onTap: () => homeAppBarOnTap(),
              child: SvgPicture.asset(
                "assets/images/shop_go_text.svg",
                height: 35,
              ),
            ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      actions: [
        Common.accessToken.value == ''
            ? Center(child: langList())
            : InkWell(
                onTap: () => homeAppBarOnTap(),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(
                    "assets/images/shop_go.svg",
                  ),
                ),
              ),
        // if (_currentIndex.value == 0)
        //   InkWell(
        //     onTap: () => Get.to(() => const NotificationScreen()),
        //     child: Padding(
        //       padding: const EdgeInsets.only(right: 15),
        //       child: Icon(CupertinoIcons.bell_solid, color: ColorUtils.yellowColor),
        //     ),
        //   ),
      ],
    );
  }

  String selectedLanguage = 'english';

  Widget langList() {
    return DropdownButton(
      value: selectedLanguage,
      alignment: AlignmentDirectional.bottomCenter,
      iconEnabledColor: ColorUtils.whiteColor,
      underline: const SizedBox(),
      style: const TextStyle(color: Colors.white),
      selectedItemBuilder: (BuildContext context) {
        return [
          DropdownMenuItem(
            value: 'english',
            child: _textUtils.bold12(
                "english".tr, ColorUtils.whiteColor, TextAlign.center),
          ),
          DropdownMenuItem(
            value: 'arabic',
            child: _textUtils.bold12(
                "arabic".tr, ColorUtils.whiteColor, TextAlign.center),
          ),
          DropdownMenuItem(
            value: 'hebrew',
            child: _textUtils.bold12(
                "hebrew".tr, ColorUtils.whiteColor, TextAlign.center),
          ),
        ];
      },
      items: [
        DropdownMenuItem(
          value: 'english',
          child: _textUtils.bold12(
              "english".tr, ColorUtils.blackColor, TextAlign.center),
        ),
        DropdownMenuItem(
          value: 'arabic',
          child: _textUtils.bold12(
              "arabic".tr, ColorUtils.blackColor, TextAlign.center),
        ),
        DropdownMenuItem(
          value: 'hebrew',
          child: _textUtils.bold12(
              "hebrew".tr, ColorUtils.blackColor, TextAlign.start),
        ),
      ],
      onChanged: (value) {
        switch (value) {
          case 'english':
            Get.updateLocale(const Locale('en', 'US'));
            break;
          case 'arabic':
            Get.updateLocale(const Locale('ar'));
            break;
          case 'hebrew':
            Get.updateLocale(const Locale('he', 'IL'));
            break;
          default:
            Get.updateLocale(const Locale('en', 'US'));
        }
        selectedLanguage = value!;
      },
    );
  }

  homeAppBarOnTap() {
    // if (Common.currentIndex.value !=0) {
    //   Common.currentIndex.value = 0;
    // } else {
    //   Common.currentIndex.value = 2;
    // }
    // Get.to(() => const HomeScreen());
  }

  addToCartDialogue({onConfirm}) {
    return Get.defaultDialog(
      title: "welcome".tr,
      middleText: "login_to_continue".tr,
      textConfirm: "login_lowercase".tr,
      textCancel: "cancel".tr,
      onConfirm: onConfirm,
      buttonColor: ColorUtils.purpleColor,
      confirmTextColor: ColorUtils.whiteColor,
      cancelTextColor: ColorUtils.purpleColor,
    );
  }

  expandableBoxDecoration() {
    return BoxDecoration(
        color: ColorUtils.purpleColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10));
  }
}
