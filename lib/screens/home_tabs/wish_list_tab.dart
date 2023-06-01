import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_go/api/api_service.dart';
import 'package:shop_go/app_utils/app_utils.dart';
import 'package:shop_go/app_utils/color_utils.dart';
import 'package:shop_go/app_utils/common.dart';
import 'package:shop_go/app_utils/text_utils.dart';
import 'package:shop_go/controllers/common_controller.dart';
import 'package:shop_go/model/user_wishlist_model.dart';
import 'package:shop_go/screens/login_screen.dart';

class WishListTab extends StatefulWidget {
  const WishListTab({Key? key}) : super(key: key);

  @override
  State<WishListTab> createState() => _WishListTabState();
}

class _WishListTabState extends State<WishListTab>
    with SingleTickerProviderStateMixin {
  final AppUtils _appUtils = AppUtils();
  final TextUtils _textUtils = TextUtils();
  final ApiService _apiService = ApiService();
  RxInt tabIndex = 0.obs;
  CommonController commonController = Get.find<CommonController>();

  @override
  void initState() {
    super.initState();
    _apiService.getUserWishlist();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Obx(
      () {
        List<Wishlist>? userWishlist = commonController.userWishlist.value.wishlist;

        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Common.accessToken.value != ""
                ? SingleChildScrollView(
                    child: userWishlist != null
                        ? userWishlist.isNotEmpty
                            ? Column(
                                children: [
                                  for (var item in userWishlist)
                                    wishListItem(item)
                                ],
                              )
                            : _appUtils.placeholderText("No Products in the Wishlist", height/1.5)
                        : _appUtils.circularProgressIndicator(height: height/1.5),
                  )
                : InkWell(
                    onTap: () => Get.to(() => const LoginScreen(origin: "wishlist",)),
                    child: _appUtils.placeholderText("Login to View Wishlist", height),
                  ));
      },
    );
  }

  Widget wishListItem(Wishlist item) {
    return Container(
      decoration: _appUtils.boxDecoration(
          Colors.transparent, ColorUtils.lightGrayColor),
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                CachedNetworkImage(
                  width: 100,
                  imageUrl: item.thumbnail!,
                  placeholder: (context, url) => Image.asset("assets/images/img.png",color: ColorUtils.whiteColor,),
                  errorWidget: (context, url, error) =>  Image.asset("assets/images/img.png",color: ColorUtils.whiteColor,),),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: _textUtils.medium14(item.productName, ColorUtils.purpleColor, TextAlign.start)),
                          InkWell(
                              onTap: (){
                                _appUtils.showLoadingDialog();
                                _apiService.deleteWishlist(item.productId.toString());

                              },
                              child: Icon(Icons.close, color: ColorUtils.redColor, size: 20)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Expanded(child: brandWidget("img.png")),
                          Expanded(child: cartInnerWidget("brand".tr, item.productMeta?.siteLogo ?? '',true)),
                          Expanded(child: cartInnerWidget("size".tr, item.productMeta!.productSize!=null&&item.productMeta!.productSize!=""?item.productMeta!.productSize:"N/A")),
                          Expanded(child: cartInnerWidget("color".tr, item.productMeta!.productColor!=null&&item.productMeta!.productColor!=""?item.productMeta!.productColor:"N/A")),
                        ],
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Row(
                        children: [
                          Expanded(child: Container()),
                          Expanded(child: _textUtils.bold12("price".tr, ColorUtils.purpleColor, TextAlign.center)),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: InkWell(
                  onTap: (){
                    _appUtils.showLoadingDialog();
                    _apiService.addToCartFromWishlist(item.productId.toString(), item.productMeta!.productCustomer.toString());
                  },
                  child: Container(
                    height: 35,
                    decoration: _appUtils.boxDecoration(
                        ColorUtils.yellowColor, ColorUtils.yellowColor),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    child: _textUtils.medium14("add_to_cart".tr,
                        ColorUtils.whiteColor, TextAlign.center),
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Expanded(
                child: Container(
                  height: 35,
                  decoration: _appUtils.boxDecoration(
                      ColorUtils.whiteColor, ColorUtils.lightPurpleColor),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: _textUtils.bold14(" ${item.productRegularPrice!+Common.currency}",
                      ColorUtils.purpleColor, TextAlign.center),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget cartInnerWidget(text1, text2, [bool islogo = false]) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _textUtils.bold12(text1, ColorUtils.purpleColor, TextAlign.center),
        const SizedBox(height: 5),
        islogo
            ? CachedNetworkImage(
                imageUrl: text2,
                placeholder: (context, url) => Image.asset(
                  "assets/images/img.png",
                  color: ColorUtils.whiteColor,
                ),
                errorWidget: (context, url, error) => Image.asset(
                  "assets/images/img.png",
                  color: ColorUtils.whiteColor,
                ),
              )
            : _textUtils.normal12(
                text2, ColorUtils.blackColor, TextAlign.center),
      ],
    );
  }

  Widget brandWidget(image) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _textUtils.bold13("brand".tr, ColorUtils.purpleColor, TextAlign.center),
        const SizedBox(height: 5),
        SizedBox(
          height: 35,
          width: 40,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            elevation: 2,
            color: ColorUtils.whiteColor,
            child: Image.asset("assets/images/$image",
                height: 30, width: 30, fit: BoxFit.cover),
          ),
        )
      ],
    );
  }
}
