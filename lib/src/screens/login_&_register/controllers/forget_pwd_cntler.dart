import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/api/http_helper.dart';
import 'package:yslcrm/src/utils/utilities.dart';

class ForgetPWDController extends GetxController {
  final emailCtrler = TextEditingController();
  static var isLoading = false.obs;
  static var isLoading2 = false.obs;
  final formKey = GlobalKey<FormState>();

  //
  Future<void> forgotPwd(
      {required String emailId, String? type, bool isResend = true}) async {
    if (await Utilities.isOnline()) {
      try {
        // type == 'pwd' ? isLoading.value = true : isLoading2.value = true;
        Utilities.showDialog(Get.context!);
        final Map<String, dynamic> jsonObject = {"email": emailId};
        final result = await HttpHelper.executePost(
            jsonObject, HttpHelper.change_password, HttpHelper.otherBaseURL);
        debugPrint('$result');
        // type == 'pwd' ? isLoading.value = false : isLoading2.value = false;
        Utilities.hideDialog();
        if (result["status"] == true) {
          emailCtrler.text = '';
          Utilities.showToast(message: result["message"] ?? "status");
          Get.back();
        } else {
          // type == 'pwd' ? isLoading.value = false : isLoading2.value = false;
          Utilities.hideDialog();
          Utilities.showToast(
              message:
                  result["message"] ?? "Unable to proceed, Please try again.");
        }
      } catch (e) {
        // type == 'pwd' ? isLoading.value = false : isLoading2.value = false;
        Utilities.hideDialog();
        Utilities.showToast(message: "Something went wrong");
      }
    } else {
      Utilities.noInternet();
    }
  }

  Future<void> validation({String? type}) async {
    if (emailCtrler.text.isEmpty || !Utilities.emailValid(emailCtrler)) {
      Utilities.showToast(message: 'Please enter valid employee id');
    } else {
      FocusScope.of(Get.context!).unfocus();
      await forgotPwd(emailId: emailCtrler.text, type: type);
      // Get.toNamed(Routes.ChangePwd);
    }
  }
}
