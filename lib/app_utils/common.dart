import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_go/model/testing.dart';

class Common{
  static String fontFamily = "Montserrat";
  static String currency = "\$";
  static String consumerKey = "ck_a302b9347e5517655b96052bf0aedf5d16fe742b";
  static String consumerSecret = "cs_6733932b24e290ceb71b550d5ca5d86a2d2b94b9";
  static RxString accessToken = "".obs;
  static RxInt currentIndex = 0.obs;
  static RxBool isFromCurrentIndex = false.obs;
  static RxInt categoryIndex = 0.obs;
  static RxInt storyIndex = 0.obs;
  static RxString userId = "".obs;
  static RxString totalCartPrice = "".obs;
  static TabController? tabController;
  static RxBool isInternetAvailable = false.obs;
  static List<Map> categoriesData = [];
  static double usdRate = 0.0;
  static RxBool rememberPassword = false.obs;
  static List<Testing> testingArray = [];

  static checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isInternetAvailable.value = false;
      if (kDebugMode) {
        print("not connected");
      }
    } else {
      isInternetAvailable.value = true;
      if (kDebugMode) {
        print("connected");
      }
    }

  }
}