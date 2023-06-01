import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_go/app_utils/color_utils.dart';
import 'package:shop_go/app_utils/text_utils.dart';
import 'package:shop_go/model/notification_model.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final TextUtils _textUtils = TextUtils();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.whiteColor,
      appBar: AppBar(
        backgroundColor: ColorUtils.whiteColor,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios), color: ColorUtils.blackColor, onPressed: () => Get.back()),
        title: _textUtils.bold18("Notifications", ColorUtils.blackColor, TextAlign.center),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: notificationsList.map((e) => notificationWidget(e)).toList(),
        ),
      ),
    );
  }

  Widget notificationWidget(NotificationModel notificationModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            child: Image.asset("assets/icons/${notificationModel.image}", width: 100, height: 150, fit: BoxFit.cover),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _textUtils.semiBold12(notificationModel.title, ColorUtils.blackColor, TextAlign.start),
                const SizedBox(height: 10),
                _textUtils.normal10(notificationModel.description, ColorUtils.lightBlackColor, TextAlign.start),
              ],
            ),
          )
        ],
      ),
    );
  }
}
