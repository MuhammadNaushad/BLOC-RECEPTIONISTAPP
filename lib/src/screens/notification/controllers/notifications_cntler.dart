import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    debugPrint("Noti");
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() {
    debugPrint("Noti dispose");

    super.dispose();
  }
}
