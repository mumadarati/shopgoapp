import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shop_go/api/api_service.dart';
import 'package:shop_go/app_utils/app_utils.dart';
import 'package:shop_go/app_utils/color_utils.dart';
import 'package:shop_go/app_utils/common.dart';
import 'package:shop_go/app_utils/text_utils.dart';
import 'package:shop_go/controllers/common_controller.dart';
import 'package:shop_go/model/transactions_model.dart';
import 'package:shop_go/screens/login_screen.dart';

class WalletTab extends StatefulWidget {
  const WalletTab({Key? key}) : super(key: key);

  @override
  State<WalletTab> createState() => _WalletTabState();
}

class _WalletTabState extends State<WalletTab> {
  final AppUtils _appUtils = AppUtils();
  final TextUtils _textUtils = TextUtils();
  final ApiService _apiService = ApiService();
  CommonController commonController = Get.find<CommonController>();

  @override
  void initState() {
    super.initState();
    _apiService.getCurrentBalance();
    _apiService.getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Obx(
          (){
            List<Transactions>? transactions = commonController.transactions.value.transactions;
           return Common.accessToken.value!=""?
           Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15,),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: _appUtils.boxDecoration(ColorUtils.whiteColor, ColorUtils.lightPurpleColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _textUtils.normal14("total_amount".tr, ColorUtils.purpleColor, TextAlign.center),
                        const SizedBox(height: 10,),
                        if(commonController.currentBalance.value.balance!=null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _textUtils.bold22(commonController.currentBalance.value.balance!, ColorUtils.blackColor, TextAlign.center),
                            _textUtils.bold22(Common.currency, ColorUtils.yellowColor, TextAlign.center),
                          ],
                        ),
                        const SizedBox(height: 15,),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              Expanded(
                                child:  Container(
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: _appUtils.boxDecoration(ColorUtils.yellowColor, ColorUtils.yellowColor),
                                  child: _textUtils.medium14('deposit'.tr, ColorUtils.whiteColor, TextAlign.center),
                                ),
                              ),
                              const SizedBox(width: 10,),
                              Expanded(
                                child:  Container(
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: _appUtils.boxDecoration(ColorUtils.lightPurpleColor.withOpacity(.4), ColorUtils.lightPurpleColor.withOpacity(.4)),
                                  child: _textUtils.medium14('withdraw'.tr, ColorUtils.blackColor, TextAlign.center),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 15,),
                  _textUtils.medium14("previous_transactions".tr, ColorUtils.blackColor, TextAlign.center),
                  const SizedBox(height: 15,),
                  Expanded(
                    child: transactions!=null?
                     transactions.isNotEmpty?
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: _appUtils.boxDecoration(ColorUtils.whiteColor, ColorUtils.lightPurpleColor),
                      child: DataTable2(
                          columnSpacing: 2,
                          horizontalMargin: 10,
                          minWidth: 300,
                          columns: [
                            DataColumn2(
                                label: _textUtils.semiBold12("order_id".tr, ColorUtils.blackColor, TextAlign.center),
                                size: ColumnSize.S
                            ),
                            DataColumn2(
                                label: _textUtils.semiBold12("total_bill".tr, ColorUtils.blackColor, TextAlign.center),
                                size: ColumnSize.S
                            ),
                            DataColumn2(
                                label: _textUtils.semiBold12("items".tr, ColorUtils.blackColor, TextAlign.center),
                                size: ColumnSize.S
                            ),
                            DataColumn2(
                                label: _textUtils.semiBold12("date".tr, ColorUtils.blackColor, TextAlign.center),
                                size: ColumnSize.S
                            ),
                          ],
                          rows: List<DataRow>.generate(
                              transactions.length,(i) => DataRow(
                              cells: [
                                DataCell( _textUtils.normal12(transactions[i].transactionId, ColorUtils.blackColor, TextAlign.center)),
                                DataCell( _textUtils.normal12("${transactions[i].amount!.split('.').first} ${Common.currency}", ColorUtils.blackColor, TextAlign.center)),
                                DataCell( _textUtils.normal12("0", ColorUtils.blackColor, TextAlign.center)),
                                DataCell( _textUtils.normal12(transactions[i].date!.split(' ').first, ColorUtils.blackColor, TextAlign.center)),
                              ])
                          )
                      ),
                    ):
                     _appUtils.placeholderText("No Transactions Found", height/2):
                    _appUtils.circularProgressIndicator(),
                  ),

                  const SizedBox(height: 15,),
                ],
              ),
            ):
           InkWell(
             onTap: () => Get.to(() => const LoginScreen(origin: "wishlist",)),
             child: _appUtils.placeholderText("Login to View Wallet", height),
           );
          },
        ),
      ),
    );
  }
}
