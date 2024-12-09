import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/api/http_helper.dart';
import 'package:yslcrm/src/common/ui/common.dart';
import 'package:yslcrm/src/models/patients_management/get_all_patients_model.dart';
import 'package:yslcrm/src/models/schedule_management/get_all_slot_model.dart';
import 'package:yslcrm/src/utils/alerts.dart';
import 'package:yslcrm/src/utils/preferences.dart';
import 'package:yslcrm/src/utils/utilities.dart';

class AssignScheduleController extends GetxController
    with GetTickerProviderStateMixin
    implements UtilitiesAbstract {
  AnimationController? animationController;

  final ScrollController scrollController = ScrollController();
  final searchCtrler = TextEditingController();

  static var isLoading = false.obs;
  static var isDataNotFound = false.obs;
  static List<SlotData>? slotList = <SlotData>[].obs;
  static String slotID = "";
  static String doctorID = "";

  String slotIdToPost = "";
  Map<String, String> doctorData = {};

  bool showSearchClearBtn = false;

  @override
  void onInit() async {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.onInit();
    print("TOKEN: ${await Preferences.getString(Preferences.login_token)}");
    await getScheduleListData();
    //Checking Data
    doctorData = Get.parameters as Map<String, String>;
    //Textfield Listener
    searchCtrler
      ..addListener(() async {
        if (searchCtrler.text.length > 0) {
          showSearchClearBtn = true;
          // _page = 1;
        } else {
          showSearchClearBtn = false;
        }
        update();
      });
  }

  static Future<void> getScheduleListData(
      {String? search, bool isShowTaost = true}) async {
    if (await Utilities.isOnline()) {
      try {
        // Utilities.showDialog(Get.context!);
        isLoading.value = true;
        final result;
        // await Utilities.delay(3000);
        final token = await Preferences.getString(Preferences.login_token);
        final Map<String, dynamic> jsonObject = {
          "doctor_id": doctorID,
        };
        if (search != null) {
          result = await HttpHelper.executePost(
              jsonObject, HttpHelper.getSheduleList, null, token);
        } else {
          result = await HttpHelper.executePost(
              jsonObject, HttpHelper.getSheduleList, null, token);
        }
        debugPrint(result.toString());
        //  Utilities.hideDialog();
        isLoading.value = false;

        if (result["status"] == 1) {
          if (result["data"] != null) {
            final GetAllSheduleModel data = GetAllSheduleModel.fromJson(result);
            if (data.data != null && data.data!.isNotEmpty) {
              slotList!.clear();
              isDataNotFound.value = false;
              debugPrint(data.data!.toString());
              slotList = data.data;
              debugPrint(slotList.toString());
            } else {
              slotList!.clear();
              isLoading.value = false;
              isDataNotFound.value = true;
            }
            if (isShowTaost)
              Utilities.showToast(message: result["message"] ?? "status");
          } else {
            // Utilities.hideDialog();
            isDataNotFound.value = true;
            if (isShowTaost)
              Utilities.showToast(message: "No data found, Please try again.");
          }
        } else {
          isLoading.value = false;
          isDataNotFound.value = true;
          // Utilities.hideDialog();
          if (result["message"] == "Unauthenticated.") {
            Utilities.showToast(
                message:
                    result["message"] ?? "Session expired! Please login again");
            Alerts.showOneBtnDialog();
          } else {
            Utilities.showToast(
                message: result["message"] ??
                    "Unable to proceed, Please try again.");
          }
        }
      } catch (e) {
        // Utilities.hideDialog();
        isLoading.value = false;
        isDataNotFound.value = true;
        Utilities.showToast(message: "Something went wrong");
      }
    } else {
      Utilities.noInternet();
    }
  }

  Future<void> deleteSchedule({required String slot_id}) async {
    if (await Utilities.isOnline()) {
      try {
        Utilities.showDialog(Get.context!);
        final token = await Preferences.getString(Preferences.login_token);
        final Map<String, dynamic> jsonObject = {
          "slot_id": slot_id,
        };
        final result = await HttpHelper.executePost(
            jsonObject, HttpHelper.deleteschedule, null, token);
        debugPrint(result.toString());
        Utilities.hideDialog();
        if (result["status"] == 1) {
          Utilities.showToast(
              message: result["message"] ?? "Deleted successfully");
          await getScheduleListData(isShowTaost: false);
        } else {
          Utilities.hideDialog();
          if (result["message"] == "Unauthenticated.") {
            Utilities.showToast(
                message: result["message"] ??
                    "Session expired!, Please login again.");
            Alerts.showOneBtnDialog();
          } else {
            Utilities.showToast(
                message: result["message"] ??
                    "Unable to proceed, Please try again.");
          }
        }
      } catch (e) {
        Utilities.hideDialog();
        Utilities.showToast(message: "Something went wrong");
      }
    } else {
      Utilities.noInternet();
    }
  }

  Future<void> updateSchedule({required String patient_id}) async {
    if (await Utilities.isOnline()) {
      try {
        Utilities.showDialog(Get.context!);
        final token = await Preferences.getString(Preferences.login_token);
        final Map<String, dynamic> jsonObject = {
          "patient_id": patient_id,
        };
        final result = await HttpHelper.executePost(
            jsonObject, HttpHelper.deletepatient, null, token);
        debugPrint(result.toString());
        Utilities.hideDialog();
        if (result["status"] == 1) {
          Utilities.showToast(
              message: result["message"] ?? "Deleted successfully");
          await getScheduleListData(isShowTaost: false);
        } else {
          Utilities.hideDialog();
          if (result["message"] == "Unauthenticated.") {
            Utilities.showToast(
                message: result["message"] ??
                    "Session expired!, Please login again.");
            Alerts.showOneBtnDialog();
          } else {
            Utilities.showToast(
                message: result["message"] ??
                    "Unable to proceed, Please try again.");
          }
        }
      } catch (e) {
        Utilities.hideDialog();
        Utilities.showToast(message: "Something went wrong");
      }
    } else {
      Utilities.noInternet();
    }
  }

//TF Stuff
  String? textValue;
  Timer? timeHandle;
  void textChanged(String val) {
    textValue = val;
    if (timeHandle != null) {
      timeHandle!.cancel();
    }
    timeHandle = Timer(Duration(seconds: 1), () async {
      print("Calling now the API: $textValue");
      await getScheduleListData(search: textValue);
    });
  }

  @override
  Future<void> onRefresh() async {
    searchCtrler.text = "";
    await getScheduleListData();
  }

  @override
  void onClose() {
    animationController?.dispose();
    slotList!.clear();
    if (timeHandle != null) {
      timeHandle!.cancel();
    }
    super.onClose();
  }
}
