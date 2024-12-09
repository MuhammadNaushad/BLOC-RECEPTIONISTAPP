import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/api/http_helper.dart';
import 'package:yslcrm/src/common/ui/common.dart';
import 'package:yslcrm/src/models/patients_management/get_all_patients_model.dart';
import 'package:yslcrm/src/utils/alerts.dart';
import 'package:yslcrm/src/utils/preferences.dart';
import 'package:yslcrm/src/utils/utilities.dart';

class PatientManagementController extends GetxController
    with GetTickerProviderStateMixin
    implements UtilitiesAbstract {
  AnimationController? animationController;

  final ScrollController scrollController = ScrollController();
  // The controller for the ListView
  ScrollController? pController;
  final searchCtrler = TextEditingController();

  static var isLoading = false.obs;
  static var isDataNotFound = false.obs;
  static List<PatientData>? patientsList = <PatientData>[].obs;

// At the beginning, we fetch the first 20 posts
  int _page = 1;
  // you can change this value to fetch more or less posts per page (10, 15, 5, etc)
  final int _limit = 10;

  // There is next page or not
  bool _hasNextPage = true;

  // Used to display loading indicators when _firstLoad function is running
  bool showSearchClearBtn = false;

  // Used to display loading indicators when _loadMore function is running
  bool isLoadMoreRunning = false;

  @override
  void onInit() async {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.onInit();
    print("TOKEN: ${await Preferences.getString(Preferences.login_token)}");
    //await getPatientListData();
    pController = ScrollController()..addListener(_loadMore);
    //Textfield Listener
    searchCtrler
      ..addListener(() async {
        if (searchCtrler.text.length > 0) {
          showSearchClearBtn = true;
          _page = 1;
        } else {
          showSearchClearBtn = false;
        }
        update();
      });
  }

  void _loadMore() async {
    if (isLoading.value == false &&
        isLoadMoreRunning == false &&
        searchCtrler.text == "" &&
        pController!.position.pixels == pController!.position.maxScrollExtent) {
      print('scrolled');

      isLoadMoreRunning = true;
      update();
      // Display a progress indicator at the bottom
      _page += 1; // Increase _page by 1
      print('PAGE :$_page');

      try {
        await getPatientListData(isShowTaost: false);
      } catch (err) {
        print(err);
      }

      isLoadMoreRunning = false;
      update();
    }
  }

  Future<void> getPatientListData(
      {String? search, bool isShowTaost = true, bool isReload = false}) async {
    if (await Utilities.isOnline()) {
      try {
        // Utilities.showDialog(Get.context!);
        if (_page == 1 || search != null || isReload) {
          isLoading.value = true;
          if (isReload) {
            _page = 1;
          }
        }
        final result;
        // await Utilities.delay(3000);
        final token = await Preferences.getString(Preferences.login_token);
        if (search != null) {
          result = await HttpHelper.executeGet(
              HttpHelper.getPatientsList + "?search=$search",
              token); //?patient_id=147&name=varsha&phone=9511242559
        } else {
          if (_page > 1) {
            result = await HttpHelper.executeGet(
                HttpHelper.getPatientsList + "?page=$_page", token);
          } else {
            result =
                await HttpHelper.executeGet(HttpHelper.getPatientsList, token);
          }
        }

        debugPrint(result.toString());

        //  Utilities.hideDialog();
        if (_page == 1 || search != null || isReload) {
          isLoading.value = false;
        }
        if (result["status"] == 1) {
          if (result["data"] != null) {
            final GetAllPatientsList data = GetAllPatientsList.fromJson(result);
            if (data.data!.basedata != null &&
                data.data!.basedata!.isNotEmpty) {
              if (_page == 1 || search != null || isReload) {
                patientsList!.clear();
                isDataNotFound.value = false;
              }
              debugPrint(data.data!.toString());
              for (var element in data.data!.basedata!) {
                patientsList!.add(element);
              }
              // patientsList = data.data;
              debugPrint(patientsList.toString());
            } else {
              patientsList!.clear();
              isDataNotFound.value = true;
              isLoading.value = false;
            }
            if (isShowTaost)
              Utilities.showToast(message: result["message"] ?? "status");
          } else {
            patientsList!.clear();
            isDataNotFound.value = true;
            isLoading.value = false;
            if (isShowTaost)
              Utilities.showToast(message: "No data found, Please try again.");
          }
        } else {
          if (_page == 1 || search != null || isReload) {
            isLoading.value = false;
            isDataNotFound.value = true;
          }
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
        if (_page == 1 || search != null || isReload) {
          isLoading.value = false;
          isDataNotFound.value = true;
        }
        Utilities.showToast(message: "Something went wrong");
      }
    } else {
      Utilities.noInternet();
    }
  }

  Future<void> deletePatient({required String patient_id}) async {
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
          showSearchClearBtn = false;
          searchCtrler.text = "";
          update();
          FocusScope.of(Get.context!).requestFocus(FocusNode());
          Utilities.showToast(
              message: result["message"] ?? "Deleted successfully");
          await getPatientListData(isShowTaost: false, isReload: true);
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
      await getPatientListData(search: textValue);
    });
  }

  @override
  void onClose() {
    animationController?.dispose();
    patientsList!.clear();
    if (timeHandle != null) {
      timeHandle!.cancel();
    }
    super.onClose();
  }

  @override
  Future<void> onRefresh() async {
    searchCtrler.text = "";
    _page = 1;
    showSearchClearBtn = false;
    await getPatientListData();
  }
}
