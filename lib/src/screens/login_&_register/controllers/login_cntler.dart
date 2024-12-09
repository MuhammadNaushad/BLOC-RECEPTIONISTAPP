import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/api/http_helper.dart';
import 'package:yslcrm/src/models/login_and_userProfile/user_login_model.dart';
import 'package:yslcrm/src/routes/app_pages.dart';
import 'package:yslcrm/src/utils/preferences.dart';
import 'package:yslcrm/src/utils/shared_preferences.dart';
import 'package:yslcrm/src/utils/utilities.dart';

class LoginController extends GetxController {
  final emailCtrler = TextEditingController();
  final pwdCtrler = TextEditingController();
  var obscureText = true.obs;
  final formKey = GlobalKey<FormState>();

  static var isLoading = false.obs;

  static Future<void> userLogin(
      {required String email,
      required String password,
      String? fcmToken}) async {
    if (await Utilities.isOnline()) {
      try {
        Utilities.showDialog(Get.context!);

        final Map<String, dynamic> jsonObject = {
          "email": email,
          "password": password,
          // 'fcm_token': fcmToken
        };
        final result =
            await HttpHelper.executePost(jsonObject, HttpHelper.user_login);
        Utilities.hideDialog();
        debugPrint('$result');
        // isLoading.value = false;
        if (result["status"] == 1) {
          //Data Storing
          final data = result["data"];
          /* final UserLoginModel userLoginDataObj =
              UserLoginModel.fromJson(result); */
          if (data["data"] != null) {
            await Preferences.putString(
                Preferences.user_id, data['data']['id'].toString());
            await Preferences.putString(
                Preferences.user_first_name,
                data['data']['first_name'] ??
                    data['data']['username'] ??
                    "User");
            await Preferences.putString(
                Preferences.user_last_name, data['data']['last_name'] ?? "");
            await Preferences.putString(
                Preferences.login_email_id, data['data']['type'] ?? "");
            await Preferences.putString(Preferences.remember_token,
                data['data']['remember_token'] ?? "");
            await Preferences.putString(
                Preferences.user_type, data['data']['type'] ?? "");
            await Preferences.putString(
                Preferences.login_token, data['token'] ?? "");
          }
          debugPrint('${await Preferences.getString(Preferences.user_id)}');
          debugPrint(
              '${await Preferences.getString(Preferences.user_first_name)}');
          //Param to login
          final Map<String, String> param = {
            "token": await Preferences.getString(Preferences.login_token),
          };
          debugPrint('$param');
          Get.offAllNamed(Routes.DASHBOARD, parameters: param);
          Utilities.showToast(message: result["message"] ?? "Logged In");
        } else {
          Utilities.hideDialog();
          Utilities.showToast(
              message:
                  result["message"] ?? "Unable to proceed, Please try again.");
        }
      } catch (e) {
        Utilities.hideDialog();
        Utilities.showToast(message: "Something went wrong");
      }
    } else {
      Utilities.noInternet();
    }
  }

  Future<void> validation() async {
    if (emailCtrler.text.isEmpty || !emailCtrler.text.isEmail) {
      Utilities.showToast(message: 'Please enter valid email id.');
    } else if (pwdCtrler.text.isEmpty) {
      Utilities.showToast(message: 'Please enter password');
    } else if (pwdCtrler.text.length < 6) {
      Utilities.showToast(message: 'Please enter at least 6 characters.');
    } else {
      if (isLoading.value == false) {
        await userLogin(
            email: emailCtrler.text.trim(),
            password: pwdCtrler.text.trim(),
            fcmToken: await Preferences.getString(Preferences.fcm_token));
        // Get.offAllNamed(Routes.DASHBOARD);
      }
    }
  }

  static Future<void> storeData(Map<String, dynamic> jsonString) async {
    String user = jsonEncode(UserData.fromJson(jsonString));

    await SharedPrefs.setString(Preferences.user_object, user);
    var userObject = await SharedPrefs.getString(Preferences.user_object);
    Map<String, dynamic> userMap = jsonDecode(userObject);
    var userData = UserData.fromJson(userMap);
  }

  @override
  void onClose() {
    super.onClose();
    isLoading.value = false;
    debugPrint("Disposed");
  }
}
