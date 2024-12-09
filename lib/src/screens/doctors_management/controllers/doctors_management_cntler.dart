import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/api/http_helper.dart';
import 'package:yslcrm/src/common/ui/common.dart';
import 'package:yslcrm/src/models/doctors_management/get_all_doctors_list_model.dart';
import 'package:yslcrm/src/utils/alerts.dart';
import 'package:yslcrm/src/utils/preferences.dart';
import 'package:yslcrm/src/utils/utilities.dart';

class DoctorManageController extends GetxController
    with GetTickerProviderStateMixin
    implements UtilitiesAbstract {
  AnimationController? animationController;

  final ScrollController scrollController = ScrollController();
  final searchCtrler = TextEditingController();

  static var isLoading = false.obs;
  static var isDataNotFound = false.obs;
  static List<DoctorsData>? doctorsList = <DoctorsData>[].obs;

  bool? isDoctorManagementView;
  bool showSearchClearBtn = false;

  @override
  void onInit() async {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.onInit();
    await getDoctorsListData();
    debugPrint(isDoctorManagementView.toString());
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

  Future<void> getDoctorsListData(
      {String? search, bool isShowTaost = true}) async {
    if (await Utilities.isOnline()) {
      try {
        // Utilities.showDialog(Get.context!);
        isLoading.value = true;
        final result;
        // await Utilities.delay(3000);
        final token = await Preferences.getString(Preferences.login_token);
        if (isDoctorManagementView!) {}
        if (search != null) {
          result = await HttpHelper.executeGet(
              isDoctorManagementView!
                  ? HttpHelper.getDoctorsList + "?search=$search"
                  : HttpHelper.getActiveDoctorsList + "?search=$search",
              token); //?patient_id=147&name=varsha&phone=9511242559
        } else {
          result = await HttpHelper.executeGet(
              isDoctorManagementView!
                  ? HttpHelper.getDoctorsList
                  : HttpHelper.getActiveDoctorsList,
              token);
        }

        debugPrint(result.toString());

        //  Utilities.hideDialog();
        isLoading.value = false;

        if (result["status"] == 1) {
          if (result["data"] != null) {
            final GetAllDoctorsListModel data =
                GetAllDoctorsListModel.fromJson(result);
            if (data.data != null && data.data!.isNotEmpty) {
              doctorsList!.clear();
              isDataNotFound.value = false;
              debugPrint(data.data!.toString());
              doctorsList = data.data;
              debugPrint(doctorsList.toString());
            } else {
              doctorsList!.clear();
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

  Future<void> deleteDoctor({required String doctor_id}) async {
    if (await Utilities.isOnline()) {
      try {
        Utilities.showDialog(Get.context!);
        final token = await Preferences.getString(Preferences.login_token);
        final Map<String, dynamic> jsonObject = {
          "doctor_id": doctor_id,
        };
        final result = await HttpHelper.executePost(
            jsonObject, HttpHelper.deletedoctor, null, token);
        debugPrint(result.toString());
        Utilities.hideDialog();
        if (result["status"] == 1) {
          Utilities.showToast(
              message: result["message"] ?? "Deleted successfully");
          await getDoctorsListData(isShowTaost: false);
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
      await getDoctorsListData(search: textValue);
    });
  }

  @override
  Future<void> onRefresh() async {
    searchCtrler.text = "";
    showSearchClearBtn = false;
    //Page=1;
    await getDoctorsListData();
  }

  @override
  void onClose() {
    animationController?.dispose();
    doctorsList!.clear();
    if (timeHandle != null) {
      timeHandle!.cancel();
    }
    super.onClose();
  }
}
