import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shop_go/app_utils/app_utils.dart';
import 'package:shop_go/app_utils/color_utils.dart';
import 'package:shop_go/app_utils/common.dart';
import 'package:shop_go/app_utils/text_utils.dart';
import 'package:shop_go/screens/login_tabs/login_tab.dart';
import 'package:shop_go/screens/login_tabs/register_tab.dart';

class LoginScreen extends StatefulWidget {
  final String? origin;
  const LoginScreen({this.origin,Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final TextUtils _textUtils = TextUtils();
  final AppUtils _appUtils = AppUtils();
  // TabController? _tabController;

  @override
  void initState() {
    Common.tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Common.tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appUtils.simpleAppBarWidget(),
      backgroundColor: ColorUtils.textColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              "assets/images/login_page_header.png",
              width: double.infinity,
              height: 130,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0,bottom: 7),
                      child: _textUtils.bold30("welcome".tr, ColorUtils.purpleColor, TextAlign.start),
                    ),
                    _textUtils.medium16("login_signup_text".tr, ColorUtils.blackColor, TextAlign.start),
                    const SizedBox(height: 15),
                    TabBar(
                      onTap: (value){
                        setState(() {});
                      },
                        controller: Common.tabController,
                        isScrollable: false,
                        indicatorColor: ColorUtils.yellowColor,
                        indicatorPadding: const EdgeInsets.symmetric(horizontal: 15),
                        labelColor: ColorUtils.whiteColor,
                        unselectedLabelColor: ColorUtils.blackColor,
                        indicator: BoxDecoration(
                          color: ColorUtils.yellowColor,
                          borderRadius: BorderRadius.circular(5),

                        ),
                        tabs: [
                          Tab(height: 30,
                            icon: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.person_rounded),
                                const SizedBox(width: 5,),
                                TextUtils().bold14('login_lowercase'.tr,null, TextAlign.start)
                              ],
                            ),),
                          Tab(
                            height: 30,
                            icon: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/signup.png",color: Common.tabController!.index==1?ColorUtils.whiteColor:ColorUtils.blackColor,),
                                const SizedBox(width: 5,),
                                TextUtils().bold14('register_text'.tr,null, TextAlign.start)
                              ],
                            ),),
                        ]
                    ),
                    const SizedBox(height: 10,),
                    Expanded(
                      child: TabBarView(
                        controller: Common.tabController,
                        children:  [LoginTab(origin: widget.origin), const RegisterTab()],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
