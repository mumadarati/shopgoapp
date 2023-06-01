import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_go/api/api_service.dart';
import 'package:shop_go/app_utils/app_utils.dart';
import 'package:shop_go/app_utils/common.dart';
import 'package:shop_go/controllers/common_controller.dart';
import 'package:shop_go/model/all_brands_model.dart';
import 'package:shop_go/screens/brand_detail_web_view.dart';

class BrandsTab extends StatefulWidget {
  const BrandsTab({Key? key}) : super(key: key);

  @override
  State<BrandsTab> createState() => _BrandsTabState();
}

class _BrandsTabState extends State<BrandsTab> {
  final AppUtils _appUtils = AppUtils();
  CommonController commonController = Get.find<CommonController>();
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    callApis();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Obx(() {
      List<BrandModel>? brandsList =
          commonController.allBrands.value.brandsList;
      if (!commonController.isBrandClicked.value) {
        return Column(
          children: [
            Image.asset(
              "assets/images/login_page_header.png",
              width: double.infinity,
              height: 130,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                children: [
                  ///Categories
                  const SizedBox(height: 5),
                  Common.categoriesData.isNotEmpty
                      ? SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children: Common.categoriesData.map((categories) {
                            return _appUtils.categoryItem(categories);
                          }).toList()),
                        )
                      : _appUtils.circularProgressIndicator(
                          height: 70,
                        ),
                  const SizedBox(height: 15),

                  ///Brands
                  brandsList != null
                      ? brandsList.isNotEmpty
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
                                for (var brand in brandsList)
                                  InkWell(
                                    onTap: () {
                                      commonController.clickedBrand.value =
                                          brand;
                                      commonController.isBrandClicked.value =
                                          true;
                                      // Get.to(() => BrandDetailWebView(
                                      //       brand: brands,
                                      //     ));
                                    },
                                    child: _appUtils.brandItem(brand),
                                  )
                              ],
                            )
                          : _appUtils.placeholderText(
                              "No Brands Found", size.height / 3)
                      : _appUtils.circularProgressIndicator(
                          height: size.height / 3),

                  const SizedBox(height: 15),
                ],
              ),
            ),
          ],
        );
      } else {
        return BrandDetailWebView(
          brand: commonController.clickedBrand.value,
        );
      }
    });
  }

  callApis() {
    _apiService.getCategoriesApis();
    _apiService.getAllBrands();
  }
}
