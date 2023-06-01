import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_go/api/api_service.dart';
import 'package:shop_go/app_utils/app_utils.dart';
import 'package:shop_go/app_utils/color_utils.dart';
import 'package:shop_go/app_utils/common.dart';
import 'package:shop_go/app_utils/text_utils.dart';
import 'package:shop_go/controllers/common_controller.dart';
import 'package:shop_go/model/cart_products_model.dart';
import 'package:shop_go/screens/checkout_screen.dart';
import 'package:shop_go/screens/login_screen.dart';
import 'package:shop_go/screens/my_addresses_screen.dart';

class CartTab extends StatefulWidget {
  const CartTab({Key? key}) : super(key: key);

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> with SingleTickerProviderStateMixin {
  final AppUtils _appUtils = AppUtils();
  final TextUtils _textUtils = TextUtils();
  final ApiService _apiService = ApiService();

  RxInt tabIndex = 0.obs;
  TabController? _tabController;
  final Rx<ExpandableController> cartController = ExpandableController().obs;
  final Rx<ExpandableController> pendingController = ExpandableController().obs;
  final Rx<ExpandableController> stockController = ExpandableController().obs;
  CommonController commonController = Get.find<CommonController>();
  RxBool showPriceBox = false.obs;
  RxString productType = "we_go".obs;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _apiService.getUserCart();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Obx(() {
        List<ProductsInCart>? productsInCart =
            commonController.userCart.value.productsInCart ?? [];
        List<ProductsPending>? productsPending =
            commonController.userCart.value.productsPending ?? [];
        UserCartSession? cartTotal =
            commonController.userCart.value.userCartSession;

        return Common.accessToken.value != ""
            ? Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          productsInCart != null && productsPending != null
                              ? Column(
                                  children: [
                                    ///Cart Products
                                    Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        decoration:
                                            _appUtils.expandableBoxDecoration(),
                                        padding: const EdgeInsets.only(
                                            top: 5, left: 0),
                                        child: ExpandablePanel(
                                            theme: ExpandableThemeData(
                                                iconColor:
                                                    ColorUtils.purpleColor,
                                                iconSize: 30,
                                                hasIcon: true,
                                                tapHeaderToExpand: true,
                                                tapBodyToCollapse: false),
                                            header: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      _textUtils.bold18(
                                                          "cart".tr,
                                                          ColorUtils
                                                              .purpleColor,
                                                          TextAlign.start),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Container(
                                                          decoration: BoxDecoration(
                                                              color: ColorUtils
                                                                  .whiteColor,
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      30)),
                                                          padding: const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: 10,
                                                              vertical: 5),
                                                          child: cartTotal != null
                                                              ? _textUtils.bold14(
                                                                  '${cartTotal.cartTotals!.total}${Common
                                                                          .currency}',
                                                                  ColorUtils
                                                                      .purpleColor,
                                                                  TextAlign
                                                                      .start)
                                                              : _textUtils.bold14(
                                                                  "0${Common.currency}",
                                                                  ColorUtils
                                                                      .purpleColor,
                                                                  TextAlign.start)),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      cartQuantityIconWidget(
                                                          "assets/icons/weg_icon.png",
                                                          productsInCart
                                                              .where((e) =>
                                                                  e.productType ==
                                                                  "we_go")
                                                              .length
                                                              .toString(),
                                                          "wego"),
                                                      cartQuantityIconWidget(
                                                          "assets/icons/yug_icon.png",
                                                          productsInCart
                                                              .where((e) =>
                                                                  e.productType ==
                                                                  "yu_go")
                                                              .length
                                                              .toString(),
                                                          "yugo"),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            collapsed: const SizedBox(),
                                            expanded: Container(
                                              color: ColorUtils.whiteColor,
                                              child: SingleChildScrollView(
                                                child: Column(children: [
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  tabBarWidget(),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  SizedBox(
                                                    height: height / 2,
                                                    child: productsInCart
                                                            .isNotEmpty
                                                        ? SingleChildScrollView(
                                                            child: Column(
                                                              children: [
                                                                for (var item in productsInCart
                                                                    .where((e) =>
                                                                        e.productType ==
                                                                        productType
                                                                            .value))
                                                                  cartProductsWidget(
                                                                      item,
                                                                      "cart"),
                                                                const SizedBox(
                                                                  height: 20,
                                                                ),
                                                                // _appUtils.totalPriceWidget(
                                                                //     "Products Price", "145.99"),
                                                                // _appUtils.totalPriceWidget("Service Fee", "18.25"),
                                                                // _appUtils.totalPriceWidget(
                                                                //     "Consolidation & Quality Control", "3.80"),
                                                                // _appUtils.totalPriceWidget("Shipping Fee", "35"),
                                                                // const SizedBox(
                                                                //   height: 10,
                                                                // ),
                                                              ],
                                                            ),
                                                          )
                                                        : _appUtils.placeholderText(
                                                            "No Products in the Cart",
                                                            height / 2),
                                                  ),
                                                ]),
                                              ),
                                            ))),

                                    ///Pending Products
                                    Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        decoration:
                                            _appUtils.expandableBoxDecoration(),
                                        padding: const EdgeInsets.only(
                                          top: 5,
                                        ),
                                        child: ExpandablePanel(
                                            theme: ExpandableThemeData(
                                                iconColor:
                                                    ColorUtils.purpleColor,
                                                iconSize: 30,
                                                hasIcon: true,
                                                tapHeaderToExpand: true,
                                                tapBodyToCollapse: false),
                                            header: headerWidget(
                                                "pending_products".tr,
                                                productsPending
                                                    .where((e) =>
                                                        e.productType ==
                                                        "we_go")
                                                    .length
                                                    .toString(),
                                                productsPending
                                                    .where((e) =>
                                                        e.productType ==
                                                        "yu_go")
                                                    .length
                                                    .toString()
                                                    .toString()),
                                            collapsed: const SizedBox(),
                                            expanded: Container(
                                              color: ColorUtils.whiteColor,
                                              child: Column(children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                tabBarWidget(),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                SizedBox(
                                                  height: height / 2,
                                                  child: productsPending
                                                          .isNotEmpty
                                                      ? SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              for (var item in productsPending
                                                                  .where((e) =>
                                                                      e.productType ==
                                                                      productType
                                                                          .value))
                                                                pendingProductsWidget(
                                                                    item,
                                                                    "pending"),
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      : _appUtils.placeholderText(
                                                          "pending_products_not_found"
                                                              .tr,
                                                          height / 2),
                                                ),
                                              ]),
                                            ))),

                                    ///Out of Stock Products
                                    Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        decoration:
                                            _appUtils.expandableBoxDecoration(),
                                        padding: const EdgeInsets.only(
                                          top: 5,
                                        ),
                                        child: ExpandablePanel(
                                            theme: ExpandableThemeData(
                                                iconColor:
                                                    ColorUtils.purpleColor,
                                                iconSize: 30,
                                                hasIcon: true,
                                                tapHeaderToExpand: true,
                                                tapBodyToCollapse: false),
                                            header: headerWidget(
                                                "Out of Stock Products",
                                                "0",
                                                "0"),
                                            collapsed: const SizedBox(),
                                            expanded: Container(
                                              color: ColorUtils.whiteColor,
                                              child: Column(children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                tabBarWidget(),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                SizedBox(
                                                  height: height / 3,
                                                ),
                                              ]),
                                            ))),
                                  ],
                                )
                              : _appUtils.circularProgressIndicator(
                                  height: height / 3),
                        ],
                      ),
                    ),
                  ),
                  if (cartTotal != null && showPriceBox.value == true)
                    Container(
                      decoration: BoxDecoration(
                          color: ColorUtils.purpleColor.withOpacity(0.15),
                          border: Border.all(color: ColorUtils.purpleColor),
                          borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          _appUtils.totalPriceWidget("Products Price",
                              cartTotal.cartTotals!.cartContentsTotal),
                          _appUtils.totalPriceWidget(
                              "Service Fee", cartTotal.cartTotals!.serviceFees),
                          _appUtils.totalPriceWidget(
                              "Consolidation & Quality Control",
                              cartTotal.cartTotals!.qualityControl),
                          _appUtils.totalPriceWidget("Shipping Fee",
                              cartTotal.cartTotals!.shippingTotal),
                          _appUtils.totalPriceWidget(
                              "Products Price", cartTotal.cartTotals!.total,
                              isLarge: true),
                        ],
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              if ((commonController.customerDetail.value.billing
                                          ?.email ==
                                      '') ||
                                  (commonController.customerDetail.value.billing
                                          ?.phone ==
                                      '')) {
                                Get.to(() => const MyAddressesScreen());
                              } else {
                                Get.to(() => const CheckoutScreen());
                              }
                            },
                            child: Container(
                              height: 40,
                              width: Get.size.width,
                              decoration: _appUtils.boxDecoration(
                                  ColorUtils.purpleColor,
                                  ColorUtils.purpleColor),
                              alignment: Alignment.center,
                              child: _textUtils.medium14('checkout'.tr,
                                  ColorUtils.whiteColor, TextAlign.center),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showPriceBox.value = !showPriceBox.value;
                          },
                          child: Container(
                              height: 40,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              margin: const EdgeInsets.only(left: 10),
                              alignment: Alignment.center,
                              decoration: _appUtils.boxDecoration(
                                  Colors.transparent, ColorUtils.purpleColor),
                              child: Row(
                                children: [
                                  cartTotal != null
                                      ? _textUtils.medium16(
                                          "${cartTotal.cartTotals!.total}${Common.currency}",
                                          ColorUtils.purpleColor,
                                          TextAlign.start)
                                      : _textUtils.medium16(
                                          "0${Common.currency}",
                                          ColorUtils.purpleColor,
                                          TextAlign.start),
                                  Icon(
                                    showPriceBox.value == false
                                        ? Icons.keyboard_arrow_down
                                        : Icons.keyboard_arrow_up,
                                    color: ColorUtils.purpleColor,
                                    size: 30,
                                  )
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                ],
              )
            : InkWell(
                onTap: () => Get.to(() => const LoginScreen(
                      origin: "cart",
                    )),
                child: _appUtils.placeholderText("Login to View Cart", height),
              );
      }),
    );
  }

  Widget cartProductsWidget(ProductsInCart item, productType) {
    return Container(
        decoration: _appUtils.boxDecoration(
            Colors.transparent, ColorUtils.lightGrayColor),
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: CachedNetworkImage(
                    imageUrl: item.thumbnail!,
                    placeholder: (context, url) => Image.asset(
                      "assets/images/img.png",
                      color: ColorUtils.whiteColor,
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      "assets/images/img.png",
                      color: ColorUtils.whiteColor,
                    ),
                  )),
              const SizedBox(width: 15),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Center(
                          child: _textUtils.bold14(
                              item.productName!,
                              productType == "cart"
                                  ? ColorUtils.purpleColor
                                  : ColorUtils.greyColor,
                              TextAlign.start),
                        )),
                        InkWell(
                          onTap: () async {
                            _appUtils.showLoadingDialog();
                            int? res = await _apiService
                                .deleteCartProducts(item.productId.toString());
                            if (res == 200) {
                              commonController.userCart.value.productsInCart!
                                  .removeWhere(
                                      (e) => e.productId == item.productId);
                              setState(() {});
                            }
                          },
                          child: Icon(Icons.close,
                              color: ColorUtils.redColor, size: 20),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: cartInnerWidget(
                                "brand".tr,
                                item.productMeta?.siteLogo ?? '',
                                productType,
                                true)),
                        Expanded(
                            child: cartInnerWidget(
                                "size".tr,
                                item.productMeta!.productSize != null &&
                                        item.productMeta!.productSize != ""
                                    ? item.productMeta!.productSize
                                    : "N/A",
                                productType)),
                        Expanded(
                            child: cartInnerWidget(
                                "color".tr,
                                item.productMeta!.productColor != null &&
                                        item.productMeta!.productColor != ""
                                    ? item.productMeta!.productColor
                                    : "N/A",
                                productType)),
                        Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _textUtils.bold12(
                                    "quantity".tr,
                                    productType == "cart"
                                        ? ColorUtils.purpleColor
                                        : ColorUtils.greyColor,
                                    TextAlign.center),
                                const SizedBox(height: 15),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: _appUtils.numberCounter(
                                      decrement: () {
                                        if (item.qty! > 0) {
                                          setState(() {
                                            item.qty = item.qty! - 1;
                                          });
                                        }
                                      },
                                      value: item.qty!,
                                      increment: () {
                                        if (item.qty! <
                                            int.parse(item.productMeta!.sStock
                                                .toString())) {
                                          setState(() {
                                            item.qty = item.qty! + 1;
                                          });
                                        } else {
                                          _appUtils.showToast(
                                              "Product out of stock");
                                        }
                                      },
                                      showBorder: true,
                                      height: 30,
                                      hPadding: 4.0),
                                ),
                              ],
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _textUtils.bold14(
                            "price".tr,
                            productType == "cart"
                                ? ColorUtils.purpleColor
                                : ColorUtils.greyColor,
                            TextAlign.start),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            height: 30,
                            decoration: _appUtils.boxDecoration(
                              productType == "cart"
                                  ? ColorUtils.yellowColor
                                  : ColorUtils.greyColor,
                              productType == "cart"
                                  ? ColorUtils.yellowColor
                                  : ColorUtils.greyColor,
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.center,
                            child: _textUtils.medium14(
                                "${item.productRegularPrice}${Common.currency}",
                                ColorUtils.whiteColor,
                                TextAlign.center),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget pendingProductsWidget(ProductsPending item, productType) {
    return Container(
        decoration: _appUtils.boxDecoration(
            Colors.transparent, ColorUtils.lightGrayColor),
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: CachedNetworkImage(
                    imageUrl: item.productMeta!.productImage!,
                    placeholder: (context, url) => Image.asset(
                      "assets/images/img.png",
                      color: ColorUtils.whiteColor,
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      "assets/images/img.png",
                      color: ColorUtils.whiteColor,
                    ),
                  )),
              const SizedBox(width: 15),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Center(
                          child: _textUtils.bold14(
                              item.productName,
                              productType == "cart"
                                  ? ColorUtils.purpleColor
                                  : ColorUtils.greyColor,
                              TextAlign.start),
                        )),
                        InkWell(
                          onTap: () async {
                            _appUtils.showLoadingDialog();
                            int? res = await _apiService
                                .deleteCartProducts(item.productId.toString());
                            if (res == 200) {
                              commonController.userCart.value.productsPending!
                                  .removeWhere(
                                      (e) => e.productId == item.productId);
                              setState(() {});
                            }
                          },
                          child: Icon(Icons.close,
                              color: ColorUtils.redColor, size: 20),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Expanded(child: brandWidget("img.png",productType)),
                        Expanded(
                            child: cartInnerWidget(
                                "brand".tr, "N/A", productType)),
                        Expanded(
                            child: cartInnerWidget(
                                "size".tr,
                                item.productMeta!.productSize != null &&
                                        item.productMeta!.productSize != ""
                                    ? item.productMeta!.productSize
                                    : "N/A",
                                productType)),
                        Expanded(
                            child: cartInnerWidget(
                                "color".tr,
                                item.productMeta!.productColor != null &&
                                        item.productMeta!.productColor != ""
                                    ? item.productMeta!.productColor
                                    : "N/A",
                                productType)),
                        Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _textUtils.bold12(
                                    "quantity".tr,
                                    productType == "cart"
                                        ? ColorUtils.purpleColor
                                        : ColorUtils.greyColor,
                                    TextAlign.center),
                                const SizedBox(height: 15),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: _appUtils.numberCounter(
                                      decrement: () {
                                        if (item.qty! > 0) {
                                          setState(() {
                                            item.qty = item.qty! - 1;
                                          });
                                        }
                                      },
                                      value: item.qty,
                                      increment: () {
                                        if (item.qty! <
                                            int.parse(
                                                item.productMeta!.sStock!)) {
                                          setState(() {
                                            item.qty = item.qty! + 1;
                                          });
                                        } else {
                                          _appUtils.showToast(
                                              "Product out of stock");
                                        }
                                      },
                                      showBorder: true,
                                      height: 30,
                                      hPadding: 4.0),
                                ),
                              ],
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _textUtils.bold14(
                            "price".tr,
                            productType == "cart"
                                ? ColorUtils.purpleColor
                                : ColorUtils.greyColor,
                            TextAlign.start),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            height: 30,
                            decoration: _appUtils.boxDecoration(
                              productType == "cart"
                                  ? ColorUtils.yellowColor
                                  : ColorUtils.greyColor,
                              productType == "cart"
                                  ? ColorUtils.yellowColor
                                  : ColorUtils.greyColor,
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.center,
                            child: _textUtils.medium14(
                                item.productRegularPrice.toString() +
                                    Common.currency,
                                ColorUtils.whiteColor,
                                TextAlign.center),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget cartInnerWidget(text1, text2, productType, [bool islogo = false]) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _textUtils.bold11(
            text1,
            productType == "cart"
                ? ColorUtils.purpleColor
                : ColorUtils.greyColor,
            TextAlign.center),
        const SizedBox(height: 15),
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

  Widget brandWidget(image, productType) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _textUtils.bold13(
            "brand".tr,
            productType == "cart"
                ? ColorUtils.purpleColor
                : ColorUtils.greyColor,
            TextAlign.center),
        const SizedBox(height: 10),
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

  Widget headerWidget(String title, wegQuantity, yugQuantity) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: _textUtils.medium14(
                  title, ColorUtils.purpleColor, TextAlign.start),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                cartQuantityIconWidget(
                    "assets/icons/weg_icon.png", wegQuantity, "wego"),
                cartQuantityIconWidget(
                    "assets/icons/yug_icon.png", yugQuantity, "yugo"),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget tabBarWidget() {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              productType.value = "we_go";
              tabIndex.value = 0;
              _tabController!.animateTo(0);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      color: const Color(0xffF1E5FF),
                      borderRadius: BorderRadius.circular(10),
                      border: tabIndex.value != 0
                          ? null
                          : Border.all(
                              color: ColorUtils.purpleTransColor, width: 2)),
                  child: Center(
                      child: Image.asset(
                    "assets/icons/weg_icon.png",
                    height: 25,
                  )),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              productType.value = "yu_go";
              tabIndex.value = 1;
              _tabController!.animateTo(1);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                  color: const Color(0xffF1E5FF),
                  borderRadius: BorderRadius.circular(10),
                  border: tabIndex.value != 1
                      ? null
                      : Border.all(
                          color: ColorUtils.purpleTransColor, width: 2)),
              child: Center(
                  child: Image.asset(
                "assets/icons/yug_icon.png",
                height: 25,
              )),
            ),
          ),
        ),
      ],
    );
  }

  Widget cartQuantityIconWidget(image, String quantity, type) {
    return Stack(
      children: [
        Image.asset(
          image,
          height: 25,
          width: 80,
        ),
        Positioned(
          left: type == "wego" ? 4 : 2,
          top: 10,
          child: SizedBox(
            width: 65,
            child: Align(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                backgroundColor: ColorUtils.whiteColor,
                radius: 6,
                child: _textUtils.medium8(
                    quantity, ColorUtils.purpleColor, TextAlign.center),
              ),
            ),
          ),
        )
      ],
    );
  }
}
