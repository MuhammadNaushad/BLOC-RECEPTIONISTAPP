// ignore_for_file: equal_keys_in_map

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:yslcrm/src/api/http_helper.dart';
import 'package:yslcrm/src/utils/strings.dart';
import 'package:yslcrm/src/utils/utilities.dart';

class AuthRemoteRepository {
  Future<Map<String, dynamic>> login(
      {required String email,
      required String password,
      String? fcmToken}) async {
    Map<String, dynamic>? result;

    if (await Utilities.isOnline()) {
      try {
        final Map<String, dynamic> jsonObject = {
          EMAIL: email,
          PASSWORD: password,
          // FCM_TOKEN: fcmToken
        };
        result =
            await HttpHelper.executePost(jsonObject, HttpHelper.user_login);
        debugPrint(result.toString());
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      Fluttertoast.showToast(msg: "No Internet");
    }
    return result ?? {"ERROR": true};
  }
}
