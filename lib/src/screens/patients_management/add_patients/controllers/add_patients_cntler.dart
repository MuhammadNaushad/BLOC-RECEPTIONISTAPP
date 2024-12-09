import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/api/http_helper.dart';
import 'package:yslcrm/src/models/patients_management/existing_user_data_model.dart';
import 'package:yslcrm/src/utils/alerts.dart';
import 'package:yslcrm/src/utils/preferences.dart';

import '../../../../utils/utilities.dart';
import '../widgets/active_inactive_radio.dart';
import '../widgets/gender_radio_btn.dart';

class AddPatientController extends GetxController {
//AddContacts TF Controllers
  final fNameCtrler = TextEditingController();
  final userCtrler = TextEditingController();
  final ageCtrler = TextEditingController();
  final addressCtrler = TextEditingController();
  final phoneCtrler = TextEditingController();
  final emailCtrler = TextEditingController();
  final pwdCtrler = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var obscureText = true.obs;
  var primaryContact = false.obs;
  static bool loadContacts = false;
  static String patientID = "";
  String patientIdToPost = "";

  //Handling View Stuff
  bool isShowSearchBtn = true;
  bool isShowUserView = false;
  bool isShowPatientView = false;
  int statusToPost = 1;
  String genderToPost = "";
  String userIdToPost = "";

  ///Radio Btn
  Gender genderValue = Gender.male;
  Status statusValue = Status.active;

  @override
  void onInit() async {
    genderToPost = genderValue.name.capitalizeFirst!;
    statusToPost = 1;
    debugPrint(genderToPost);
    print(patientID);

    ///checking condition
    if (patientID != "0" && patientID.isNotEmpty) {
      //Assigning Initial Values for update
      patientIdToPost = patientID;
      userCtrler.text = Get.parameters["user_name"]!;
      fNameCtrler.text = Get.parameters["patient_name"]!;
      ageCtrler.text = Get.parameters["age"]!;
      genderToPost = Get.parameters["gender"]!;
      isShowSearchBtn = false;

      //Radio Btn stuff
      if (genderToPost == "Male") {
        genderValue = Gender.male;
      } else if (genderToPost == "Female") {
        genderValue = Gender.female;
      } else {
        genderValue = Gender.other;
      }
      /* if (statusToPost == 1) {
        statusValue = Status.active;
      } else {
        statusValue = Status.inactive;
      } */
    }
    //Navigate From Add appoitnment Screen
    if (Get.parameters["key"] != null &&
        Get.parameters["key"] == "navigate_to_add_patient_page") {
      phoneCtrler.text = Get.parameters["phone"]!;
      isShowUserView = true;
      isShowPatientView = false;
      isShowSearchBtn = false;
    }
    super.onInit();
  }

  Future<void> addUser() async {
    if (await Utilities.isOnline()) {
      try {
        Utilities.showDialog(Get.context!);
        final token = await Preferences.getString(Preferences.login_token);
        final Map<String, dynamic> jsonObject = {
          "name": fNameCtrler.text.trim(),
          "age": ageCtrler.text.trim(),
          'gender': genderToPost,
          'address': addressCtrler.text.trim(),
          'status': statusToPost.toString(),
          "phone": phoneCtrler.text.trim(),
        };
        debugPrint(jsonObject.toString());

        final result = await HttpHelper.executePost(
            jsonObject, HttpHelper.adduser, null, token);

        debugPrint(result.toString());
        Utilities.hideDialog();
        if (result["status"] == 1) {
          if (result["data"] != null) {
            Utilities.showToast(message: result["message"] ?? "status");
            await Utilities.delay(1000);
            Navigator.pop(Get.context!, "getPatient");
          } else {
            Utilities.hideDialog();
            Utilities.showToast(message: "No data found, Please try again.");
          }
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

  Future<void> addPatient() async {
    if (await Utilities.isOnline()) {
      try {
        Utilities.showDialog(Get.context!);
        final token = await Preferences.getString(Preferences.login_token);
        final Map<String, dynamic> jsonObject = {
          "name": fNameCtrler.text.trim(),
          "age": ageCtrler.text.trim(),
          'gender': genderToPost,
          'user_id': userIdToPost,
        };
        debugPrint(jsonObject.toString());

        final result = await HttpHelper.executePost(
            jsonObject, HttpHelper.addpatient, null, token);

        debugPrint(result.toString());
        Utilities.hideDialog();
        if (result["status"] == 1) {
          if (result["data"] != null) {
            Utilities.showToast(message: result["message"] ?? "status");
            await Utilities.delay(1000);
            loadContacts = true;
            if (AddPatientController.loadContacts) {
              Navigator.pop(Get.context!, "getContacts");
            } else {
              Navigator.pop(Get.context!, "getContacts");
            }
          } else {
            Utilities.hideDialog();
            Utilities.showToast(message: "No data found, Please try again.");
          }
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

  Future<void> updatePatient() async {
    if (await Utilities.isOnline()) {
      try {
        Utilities.showDialog(Get.context!);
        final token = await Preferences.getString(Preferences.login_token);
        final Map<String, dynamic> jsonObject = {
          "name": fNameCtrler.text.trim(),
          "age": ageCtrler.text.trim(),
          'gender': genderToPost,
          'patient_id': patientIdToPost,
        };
        debugPrint(jsonObject.toString());

        final result = await HttpHelper.executePost(
            jsonObject, HttpHelper.editpatient, null, token);

        debugPrint(result.toString());
        Utilities.hideDialog();
        if (result["status"] == 1) {
          if (result["data"] != null) {
            Utilities.showToast(message: result["message"] ?? "status");
            await Utilities.delay(1000);
            Navigator.pop(Get.context!, "getPatientsList");
          } else {
            Utilities.hideDialog();
            Utilities.showToast(message: "No data found, Please try again.");
          }
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

  Future<void> checkPatient({required String phone_no}) async {
    if (await Utilities.isOnline()) {
      try {
        Utilities.showDialog(Get.context!);
        final token = await Preferences.getString(Preferences.login_token);
        final Map<String, dynamic> jsonObject = {
          "phone": phone_no,
        };
        final result = await HttpHelper.executePost(
            jsonObject, HttpHelper.checkuser, null, token);
        debugPrint(result.toString());
        Utilities.hideDialog();
        if (result["status"] == 1) {
          if (result["data"] != null) {
            isShowSearchBtn = false;
            if (result["data"]["user_status"] != null &&
                result["data"]["user_status"]) {
              isShowUserView = false;
              isShowPatientView = true;
              final existingUserObj = ExistingUserDataModel.fromJson(result);
              if (existingUserObj.data != null) {
                if (existingUserObj.data!.data != null) {
                  final userObj = existingUserObj.data!.data;
                  debugPrint(userObj.toString());
                  debugPrint(userObj!.id.toString());
                  userIdToPost = userObj.id.toString();
                  userCtrler.text = "${userObj.id} - ${userObj.name!}";
                }
              }
            } else {
              isShowUserView = true;
              isShowPatientView = false;
            }
            Utilities.showToast(message: result["message"] ?? "success");
            update();
          } else {
            Utilities.showToast(
                message: result["message"] ??
                    "Unable to proceed, Please try again.");
          }
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

  Future<void> validation() async {
    if (fNameCtrler.text.isEmpty) {
      Utilities.showToast(message: 'Please enter full name');
    } else if (fNameCtrler.text.isEmpty) {
      Utilities.showToast(message: 'Please enter last name');
    } else if (emailCtrler.text.isEmpty || !emailCtrler.text.isEmail) {
      Utilities.showToast(message: 'Please enter valid email id');
    } else if (pwdCtrler.text.isEmpty) {
      Utilities.showToast(message: 'Please enter password');
    } else {
      if (patientIdToPost.isNotEmpty && patientIdToPost != "0") {
        await updatePatient();
      } else {
        await addUser();
      }
    }
  }

  @override
  void onClose() {
    loadContacts = false;
    patientID = "";
    patientIdToPost = "";
    userIdToPost = "";
    super.onClose();
  }
}
