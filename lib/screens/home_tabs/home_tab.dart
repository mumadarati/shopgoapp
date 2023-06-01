import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_go/api/api_service.dart';
import 'package:shop_go/app_utils/app_utils.dart';
import 'package:shop_go/app_utils/color_utils.dart';
import 'package:shop_go/app_utils/text_utils.dart';
import 'package:shop_go/controllers/common_controller.dart';
import 'package:shop_go/model/all_brands_model.dart';
import 'package:shop_go/screens/brand_detail_web_view.dart';
import 'package:shop_go/screens/story_view_screen.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final TextUtils _textUtils = TextUtils();
  final AppUtils _appUtils = AppUtils();
  final ApiService _apiService = ApiService();
  RxInt slider1Index = 0.obs;
  RxInt slider2Index = 0.obs;
  final CarouselController _controller = CarouselController();
  final CarouselController _controller2 = CarouselController();
  CommonController commonController = Get.find<CommonController>();
  late VideoPlayerController controller;
  List categories = [];
  @override
  void initState() {
    super.initState();
    callApis();
  }

  callApis() async {
    _apiService.getAllBrands();
    _apiService.getShopGoSliderImages();
    _apiService.marketingSliderImages();
    _apiService.getStoriesApi();
    _apiService.getCategoriesApis();
    controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Obx(() {
      List<String>? shopGoSlider =
          commonController.shopGoSliderImages.value.data;
      List<String>? marketingSliderImages =
          commonController.marketingSliderImages.value.data;
      List<String>? data = commonController.storiesResponse.value.data;

      List<BrandModel>? allBrands = commonController.allBrands.value.brandsList;
      List<Map>? categoriesList =
          commonController.categoriesDataCommonController.value.categoriesList;
      if (!commonController.isBrandClicked.value) {
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          children: [
            Column(
              children: [
                ///Shop GO Slider
                shopGoSlider != null
                    ? shopGoSlider.isNotEmpty
                        ? sliderWidget(imageSliders, _controller,
                            slider1Index.value, shopGoSlider)
                        : _appUtils.placeholderText(
                            "ShopGO Images Not Found", 110.0)
                    : _appUtils.circularProgressIndicator(height: 110),
                const SizedBox(
                  height: 10,
                ),

                ///Marketing Slider
                marketingSliderImages != null
                    ? marketingSliderImages.isNotEmpty
                        ? sliderWidget(marketingSliders, _controller2,
                            slider2Index.value, marketingSliderImages)
                        : _appUtils.placeholderText(
                            "Marketing Images Not Found", 110.0)
                    : _appUtils.circularProgressIndicator(height: 110),
              ],
            ),

            ///Stories
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _textUtils.bold18(
                      "stories".tr, ColorUtils.blackColor, TextAlign.start),
                ],
              ),
            ),
            data != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (int i = 0; i < data.length; i++)
                            Container(
                              margin: EdgeInsets.only(left: i == 0 ? 0 : 10),
                              child: FutureBuilder<Widget>(
                                  future: storyItem(i, data),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<Widget> snapshot) {
                                    if (snapshot.hasData) {
                                      return snapshot.data!;
                                    } else {
                                      _appUtils.placeholderText(
                                          "stories_not_found".tr, 50.0);
                                    }
                                    return CupertinoActivityIndicator(
                                        color: ColorUtils.purpleColor);
                                  }),
                            )
                        ],
                      ),
                    ),
                  )
                : _appUtils.circularProgressIndicator(),

            ///Categories
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _textUtils.bold18(
                      "categories".tr, ColorUtils.blackColor, TextAlign.start),
                ],
              ),
            ),
            (categoriesList != null && categoriesList.isNotEmpty)
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: categoriesList.map((category) {
                      return _appUtils.categoryItem(category);
                    }).toList()),
                  )
                : _appUtils.circularProgressIndicator(
                    height: 70,
                  ),

            ///Brands
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _textUtils.bold18(
                      "brands".tr, ColorUtils.blackColor, TextAlign.start),
                ],
              ),
            ),

            allBrands != null
                ? allBrands.isNotEmpty
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
                          for (var brand in allBrands)
                            InkWell(
                              onTap: () {
                                commonController.clickedBrand.value = brand;
                                commonController.isBrandClicked.value = true;
                              },
                              child: _appUtils.brandItem(brand),
                            )
                        ],
                      )
                    : _appUtils.placeholderText("brands_not_found".tr, 50.0)
                : _appUtils.circularProgressIndicator(height: size.height / 3),
          ],
        );
      } else {
        return BrandDetailWebView(
          brand: commonController.clickedBrand.value,
        );
      }
    });
  }

  late List<Widget> imageSliders =
      commonController.shopGoSliderImages.value.data!
          .map((item) => ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: item,
                  placeholder: (context, url) =>
                      CupertinoActivityIndicator(color: ColorUtils.purpleColor),
                  errorWidget: (context, url, error) =>
                      Image.asset("assets/images/img.png"),
                ),
              ))
          .toList();

  late List<Widget> marketingSliders =
      commonController.marketingSliderImages.value.data!
          .map((item) => ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: item,
                  placeholder: (context, url) =>
                      CupertinoActivityIndicator(color: ColorUtils.purpleColor),
                  errorWidget: (context, url, error) =>
                      Image.asset("assets/images/img.png"),
                ),
              ))
          .toList();

  Widget sliderWidget(imageSliders, controller, current, List<String> data) {
    return Column(
      children: [
        SizedBox(
          height: 110,
          width: MediaQuery.of(context).size.width,
          child: CarouselSlider(
            items: imageSliders,
            carouselController: controller,
            options: CarouselOptions(
                autoPlay: data.length > 1 ? true : false,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  current = index;
                }),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        if (data.length > 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: data.asMap().entries.map((entry) {
              return GestureDetector(
                  onTap: () => controller.animateToPage(entry.key),
                  child: Container(
                    margin: const EdgeInsets.only(right: 7),
                    height: 5,
                    width: current == entry.key ? 25 : 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: current == entry.key
                          ? ColorUtils.yellowColor
                          : ColorUtils.lightGrayColor,
                    ),
                    child: const SizedBox(),
                  ));
            }).toList(),
          ),
      ],
    );
  }

  Future<Widget> storyItem(int index, List<String> data) async {
    dynamic fileName;
    if (data[index].split('.').last == 'mp4') {
      fileName = await getThumb(data[index]);
    }
    return InkWell(
      onTap: () {
        Get.to(() => StoryViewScreen(
              storiesList: data,
              index: index,
            ));
      },
      child: Container(
          margin: const EdgeInsets.only(right: 10),
          width: 110,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: data[index].split('.').last != "mp4"
              ? CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: data[index],
                  placeholder: (context, url) =>
                      CupertinoActivityIndicator(color: ColorUtils.purpleColor),
                  errorWidget: (context, url, error) =>
                      Image.asset("assets/images/img.png"),
                )
              : Image.memory(
                  fileName,
                  fit: BoxFit.cover,
                )),
    );
  }

  getThumb(message) async {
    Uint8List? fileName = await VideoThumbnail.thumbnailData(
        video: message, imageFormat: ImageFormat.PNG);
    return fileName;
  }
}
