import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:shop_go/api/api_service.dart';
import 'package:shop_go/app_utils/color_utils.dart';
import 'package:shop_go/app_utils/common.dart';
import 'package:shop_go/screens/home_screen.dart';
import 'package:shop_go/screens/on_board.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var box = Hive.box('credentials');

  @override
  void initState() {
    super.initState();

    Common.checkConnectivity();
    getUsd();
    checkSession();
  }

  getUsd() async {
    await ApiService().getUsdRate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
              colors: [Color(0xFF2B1744), Color(0xFF8C6AB8)],
              focal: Alignment.center,
              focalRadius: 2.0),
        ),
        padding: const EdgeInsets.only(bottom: 50),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SizedBox(
                  height: 220,
                  width: 220,
                  child: SvgPicture.asset("assets/images/app_logo.svg"),
                ),
              ),
            ),
            CircularProgressIndicator(
              color: ColorUtils.whiteColor,
            )
          ],
        ),
      ),
    );
  }

  Future<void> checkSession() async {
    var box = Hive.box('credentials');
    var token = await box.get('token');
    var onBoardCheck = await box.get('onBoardCheck');
    if (token != null) {
      debugPrint(token);
      await ApiService().verifyToken(token.toString());
    } else {
      debugPrint("OnBoard Check : $onBoardCheck");
      if (onBoardCheck == 2) {
        Get.offAll(() => const HomeScreen());
        debugPrint('Go to Home screen');
      } else {
        Get.offAll(() => const OnBoard());
        debugPrint('Go to Boarding screen');
      }
    }
  }
}
