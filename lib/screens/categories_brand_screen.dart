import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_go/app_utils/app_utils.dart';
import 'package:shop_go/app_utils/color_utils.dart';
import 'package:shop_go/app_utils/text_utils.dart';
import 'package:shop_go/controllers/common_controller.dart';
import 'package:shop_go/model/all_brands_model.dart';

class CategoriesBrandScreen extends StatefulWidget {
  final String? categoryName;
  final String? categoryId;
  const CategoriesBrandScreen({this.categoryName, this.categoryId, Key? key})
      : super(key: key);

  @override
  State<CategoriesBrandScreen> createState() => _CategoriesBrandScreenState();
}

class _CategoriesBrandScreenState extends State<CategoriesBrandScreen> {
  final AppUtils _appUtils = AppUtils();
  final TextUtils _textUtils = TextUtils();
  late List<BrandModel>? categoryBrands = [];
  @override
  void initState() {
    super.initState();
    categoryBrands = [...?commonController.allBrands.value.brandsList];

    filterBrands();
  }

  filterBrands() {
    categoryBrands!.removeWhere((brand) {
      return !brand.brandCategories.toString().contains(widget.categoryId!);
    });
  }

  CommonController commonController = Get.find<CommonController>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            centerTitle: true,
            title: _textUtils.bold16(widget.categoryName!.toUpperCase(),
                ColorUtils.whiteColor, TextAlign.start)),
        body: Column(
          children: [
            Image.asset(
              "assets/images/login_page_header.png",
              width: double.infinity,
              height: 130,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    categoryBrands != null
                        ? categoryBrands!.isNotEmpty
                            ? GridView(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  crossAxisCount: 4,
                                ),
                                children: [
                                  for (var brand in categoryBrands!)
                                    InkWell(
                                      onTap: () {
                                        Get.back();
                                        commonController.clickedBrand.value =
                                            brand;
                                        commonController.isBrandClicked.value =
                                            true;
                                      },
                                      child: _appUtils.brandItem(brand),
                                    )
                                ],
                              )
                            : _appUtils.placeholderText(
                                "No Brands Found", size.height / 2.2)
                        : _appUtils.circularProgressIndicator(),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
