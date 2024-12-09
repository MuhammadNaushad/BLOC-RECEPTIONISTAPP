import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/api/http_helper.dart';
import 'package:yslcrm/src/routes/app_pages.dart';
import 'package:yslcrm/src/utils/utilities.dart';

class ChangePwdController extends GetxController {
  final mobileCtrler = TextEditingController();
  final pwdCtrler = TextEditingController();
  final changePwdCtrler = TextEditingController();
  final otpCtrler = TextEditingController();
  static var isLoading = false.obs;
  var obscureText = true.obs;
  var obscureText2 = true.obs;
  int start = 60;
  late Timer timer;
  //

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          timer.cancel();
        } else {
          start--;
        }
        update();
      },
    );
  }

  static Future<void> changePwd(
      {required String emailId,
      required String password,
      required String otp}) async {
    if (await Utilities.isOnline()) {
      try {
        isLoading.value = true;
        final Map<String, dynamic> jsonObject = {
          "email": emailId,
          "password": password,
          "password_confirmation": password,
          "otp": otp,
        };
        final result = await HttpHelper.executePost(
            jsonObject, HttpHelper.change_password);
        print(result);
        isLoading.value = false;
        if (result["status"] == true) {
          Utilities.showToast(message: result["message"] ?? "status");
          Get.offAllNamed(Routes.LOGIN);
        } else {
          isLoading.value = false;
          Utilities.showToast(
              message: result["data"]["error"] ??
                  "Unable to proceed, Please try again.");
        }
      } catch (e) {
        isLoading.value = false;
        Utilities.showToast(message: "Something went wrong");
      }
    } else {
      Utilities.noInternet();
    }
  }

  Future<void> validation() async {
    if (pwdCtrler.text.isEmpty) {
      Utilities.showToast(message: 'Please enter PIN');
    } else if (changePwdCtrler.text.isEmpty) {
      Utilities.showToast(message: 'Please enter confirm PIN');
    } else if (pwdCtrler.text != changePwdCtrler.text) {
      Utilities.showToast(message: 'PIN should be match');
    } else if (otpCtrler.text.isEmpty || otpCtrler.text.length < 6) {
      Utilities.showToast(message: 'OTP is not valid');
    } else {
      FocusScope.of(Get.context!).unfocus();
      await changePwd(
          emailId: Get.parameters['email'].toString(),
          password: pwdCtrler.text,
          otp: otpCtrler.text);
    }
  }

  @override
  void onClose() {
    timer.cancel();
    super.onClose();
  }
}
