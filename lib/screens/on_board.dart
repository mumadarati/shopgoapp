import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:shop_go/app_utils/app_utils.dart';
import 'package:shop_go/model/on_board_model.dart';
import 'package:shop_go/screens/home_screen.dart';
import 'package:shop_go/app_utils/color_utils.dart';
import 'package:shop_go/app_utils/text_utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  PageController pageController = PageController();
  RxInt pageChanged = 0.obs;
  final TextUtils _textUtils = TextUtils();
  final AppUtils _appUtils = AppUtils();
  var box = Hive.box('credentials');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appUtils.simpleAppBarWidget(),
        backgroundColor: ColorUtils.textColor,
        body: Obx(
          () => SafeArea(
              child: Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 40),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 25,
                          child: SmoothPageIndicator(
                            controller: pageController,
                            count: onBoardScreens.length,
                            effect: ExpandingDotsEffect(
                                activeDotColor: ColorUtils.yellowColor,
                                dotColor: const Color(0xFFDCDCDC),
                                dotHeight: 5,
                                dotWidth: 5,
                                expansionFactor: 5),
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: pageChanged < 2
                                  ? SizedBox(
                                      height: 30,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          pageChanged.value = 2;
                                          debugPrint(
                                              pageChanged.value.toString());
                                          box.put("onBoardCheck",
                                              pageChanged.value);

                                          Get.off(() => const HomeScreen());
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              ColorUtils.yellowColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                        ),
                                        child: _textUtils.normal14(
                                            "skip".tr,
                                            ColorUtils.textColor,
                                            TextAlign.start),
                                      ),
                                    )
                                  : const SizedBox()))
                    ],
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (index) {
                        pageChanged.value = index;
                      },
                      controller: pageController,
                      itemCount: onBoardScreens.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 300,
                              height: 265,
                              child:
                                  Image.asset(onBoardScreens[index].imageName!),
                            ),
                            Column(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30),
                                    child: _textUtils.bold22(
                                        onBoardScreens[index].boldText!.tr,
                                        ColorUtils.blackTextColor,
                                        TextAlign.center)),
                                // const SizedBox(
                                //   height: 20,
                                // ),
                                // Padding(
                                //     padding: const EdgeInsets.symmetric(horizontal: 20),
                                //     child: _textUtils.normal16(onBoardScreens[index].normalText, ColorUtils.blackTextColor, TextAlign.center)),
                              ],
                            )
                          ],
                        );
                      }),
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 45,
                    width: 150,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          backgroundColor: ColorUtils.yellowColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                      onPressed: () {
                        if (pageChanged.value == 2) {
                          box.put("onBoardCheck", pageChanged.value);
                        }
                        debugPrint(pageChanged.value.toString());
                        pageChanged < 2
                            ? pageController.animateToPage(++pageChanged.value,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.bounceInOut)
                            : Get.off(() => const HomeScreen());
                      },
                      child: _textUtils.bold14(
                          pageChanged < 2 ? "next".tr : "lets_start".tr,
                          ColorUtils.textColor,
                          TextAlign.center),
                    ),
                  ),
                )
              ],
            ),
          )),
        ));
  }
}
