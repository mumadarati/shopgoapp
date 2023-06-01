import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:shop_go/app_utils/color_utils.dart';
import 'package:shop_go/controllers/common_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shop_go/screens/splash_screen.dart';
import 'package:shop_go/translation/translation_file.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }
  await Firebase.initializeApp();
  Directory directory = await path_provider.getApplicationSupportDirectory();
  Hive.init(directory.path);
  await Hive.openBox('credentials');
  getNotifcation();
  runApp(const MyApp());
}

int counterNnoti = 0;
getNotifcation() async {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {}
  });

  _getDevToken();
}

_getDevToken() async {
  String deviceToken = await FirebaseMessaging.instance.getToken() ?? '';
  var box = Hive.box('credentials');
  await box.put('deviceToken', deviceToken);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CommonController(), permanent: true);
    return GetMaterialApp(
      title: 'Shop go',
      debugShowCheckedModeBanner: false,
      translations: TranslationFile(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      theme: ThemeData(
        platform: TargetPlatform.iOS,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        primaryColor: ColorUtils.purpleColor,
        colorScheme: ThemeData().colorScheme.copyWith(
            secondary: ColorUtils.purpleColor, primary: ColorUtils.purpleColor),
      ),
      home: const SplashScreen(),
    );
  }
}
