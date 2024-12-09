import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/api/http_helper.dart';
import 'package:yslcrm/src/models/dashboard/dashboard_count_model.dart';
import 'package:yslcrm/src/utils/alerts.dart';
import 'package:yslcrm/src/utils/preferences.dart';
import 'package:yslcrm/src/utils/utilities.dart';

import '../../../common/ui/common.dart';

class DashboardController extends GetxController implements UtilitiesAbstract {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  static final Rx<DashboardCountModel> countData =
      DashboardCountModel(notification: 0, vendor: 0, order: 0, visit: 0).obs;
  static RxString profilePic = ''.obs;

  @override
  void onReady() async {
    profilePic.value = await Preferences.getString(Preferences.login_avtar);
    super.onReady();
    //await getDashboardData();
  }

  Future<void> getDashboardData({bool isReload = true}) async {
    if (await Utilities.isOnline()) {
      try {
        if (isReload) {
          Utilities.showDialog(Get.context!);
        }
        final token = await Preferences.getString(Preferences.login_token);
        final result = await HttpHelper.executeGet("", token);
        debugPrint('$result');
        if (isReload) {
          Utilities.hideDialog();
        }
        if (result["status"] == true) {
          if (result["data"] != null) {
            /* final DashboardCountModel data =
                DashboardCountModel.fromJson(result['data']);
            countData.value = data; */
            // Utilities.showToast(message: result["message"] ?? "status");
          } else {
            Utilities.showToast(message: "No data found, Please try again.");
          }
        } else {
          if (result["message"] == "Unauthenticated.") {
            Utilities.showToast(
                message:
                    result["message"] ?? "Session expired! Please login again");
            Alerts.showOneBtnDialog();
          } else {
            Utilities.showToast(
                message: result["data"]["error"] ??
                    "Unable to proceed, Please try again.");
          }
        }
      } catch (e) {
        if (isReload) {
          Utilities.hideDialog();
        }
        Utilities.showToast(message: "Something went wrong");
      } finally {
        Utilities.hideDialog();
      }
    } else {
      Utilities.noInternet();
    }
  }

  @override
  Future<void> onRefresh() async {
    await getDashboardData(isReload: false);
  }
}
