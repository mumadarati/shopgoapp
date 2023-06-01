import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_go/api/api_service.dart';
import 'package:shop_go/app_utils/app_utils.dart';
import 'package:shop_go/app_utils/color_utils.dart';
import 'package:shop_go/app_utils/common.dart';
import 'package:shop_go/app_utils/text_utils.dart';
import 'package:shop_go/controllers/common_controller.dart';
import 'package:shop_go/model/cart_products_model.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final AppUtils _appUtils = AppUtils();
  final TextUtils _textUtils = TextUtils();
  TextEditingController linkController = TextEditingController();
  CommonController commonController = Get.find<CommonController>();
  double productsPrice = 0.0;
  RxString selectedShipping = "DHL".obs;
  RxString selectedPayment = "PayTR".obs;
  @override
  void initState() {
    super.initState();
    commonController.userCart.value.productsInCart?.forEach((element) {
      productsPrice = productsPrice +
          (double.tryParse(element.productRegularPrice!)! * (element.qty!));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.whiteColor,
      appBar: _appUtils.homeAppBarWidget(),
      body: Obx(
        () {
          UserCartSession? cartTotal =
              commonController.userCart.value.userCartSession;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                _textUtils.bold15(
                    "Delivery Address", ColorUtils.blackColor, TextAlign.start),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 10),
                //   child: _appUtils.addressItem(),
                // ),
                _textUtils.bold15(
                    "Shipping Method", ColorUtils.blackColor, TextAlign.start),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      // deliveryMethodItem("DHL",selectedShipping.value == "DHL",(){ selectedShipping.value = "DHL";  },"16.32"),
                      // deliveryMethodItem("UPS",selectedShipping.value == "UPS",(){ selectedShipping.value = "UPS";  },"18.00"),
                      deliveryMethodItem("BRAVO EXPRESS",
                          selectedShipping.value == "BRAVO EXPRESS", () {
                        selectedShipping.value = "BRAVO EXPRESS";
                      }, "14.20"),
                    ],
                  ),
                ),
                _textUtils.bold15(
                    "Payment Method", ColorUtils.blackColor, TextAlign.start),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _appUtils.unitItem(
                          text: "PayTR",
                          isSelected: selectedPayment.value == "PayTR",
                          onTap: () {
                            selectedPayment.value = "PayTR";
                          }),
                      // _appUtils.unitItem(
                      //   text:"PayPal    ",
                      //   isSelected:selectedPayment.value=="PayPal",
                      //   onTap: (){selectedPayment.value = "PayPal";}
                      // ),
                      // _appUtils.unitItem(
                      //   text:"ShopGO Wallet   ",
                      //   isSelected:selectedPayment.value=="ShopGO Wallet",
                      //   onTap: (){selectedPayment.value ="ShopGO Wallet"; }
                      // )
                    ],
                  ),
                ),
                if (selectedPayment.value == "PayTR")
                  ListTile(
                    leading: Image.asset("assets/images/credit-card.png"),
                    title: _textUtils.bold10(
                        "PayTR", ColorUtils.blackColor, TextAlign.start),
                    // subtitle: _textUtils.normal10("****891929263",
                    //     ColorUtils.lightBlackColor, TextAlign.start),
                  ),
                const SizedBox(
                  height: 15,
                ),
                // cartTotal.cartTotals!.subtotal
                _appUtils.totalPriceWidget("Products Price", productsPrice),
                _appUtils.totalPriceWidget(
                    "Service Fee", cartTotal?.cartTotals!.serviceFees),
                _appUtils.totalPriceWidget("Consolidation & Quality Control",
                    cartTotal?.cartTotals!.qualityControl),
                _appUtils.totalPriceWidget(
                    "Shipping Total", cartTotal?.cartTotals!.shippingTotal),
                _appUtils.totalPriceWidget(
                    "Subtotal", cartTotal?.cartTotals!.subtotal,
                    isLarge: true),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    ApiService().placeOrder();
                  },
                  child: Container(
                    height: 50,
                    width: Get.size.width,
                    decoration: _appUtils.boxDecoration(
                        ColorUtils.purpleColor, ColorUtils.purpleColor),
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    alignment: Alignment.center,
                    child: _textUtils.medium14(
                        'Place Order', ColorUtils.whiteColor, TextAlign.center),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  deliveryMethodItem(title, isActive, onTap, value) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          children: [
            Expanded(
              child: _appUtils.unitItem(
                text: "$title  ",
                isSelected: isActive,
              ),
            ),
            _textUtils.normal13(
                "$value ${Common.currency}",
                isActive ? ColorUtils.purpleColor : ColorUtils.lightGrayColor,
                TextAlign.start)
          ],
        ),
      ),
    );
  }

  var items = [
    {"title": "Aerosols_L", "isLimited": true, "image": "aerosols.svg"},
    {
      "title": "Flammable & Combustible",
      "isLimited": false,
      "image": "flammable.svg"
    },
    {"title": "Explosives", "isLimited": false, "image": "bomb.svg"},
    {
      "title": "Hazardous Material & Dangerous Goods",
      "isLimited": false,
      "image": "skull.svg"
    },
    {"title": "Cell Phone", "isLimited": true, "image": "skull.svg"},
    {"title": "Liquids", "isLimited": true, "image": "liquids.svg"},
  ];
}
