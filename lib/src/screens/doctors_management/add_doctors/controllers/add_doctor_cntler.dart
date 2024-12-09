import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/api/http_helper.dart';
import 'package:yslcrm/src/models/patients_management/existing_user_data_model.dart';
import 'package:yslcrm/src/models/patients_management/single_contact_data_model.dart';
import 'package:yslcrm/src/screens/doctors_management/add_doctors/widgets/gender_radio_btn.dart';
import 'package:yslcrm/src/utils/alerts.dart';
import 'package:yslcrm/src/utils/preferences.dart';

import '../../../../utils/utilities.dart';
import '../widgets/active_inactive_radio.dart';

class AddDoctorController extends GetxController {
//AddContacts TF Controllers
  final fNameCtrler = TextEditingController();
  final userCtrler = TextEditingController();
  final ageCtrler = TextEditingController();
  final addressCtrler = TextEditingController();
  final phoneCtrler = TextEditingController();
  final emailCtrler = TextEditingController();
  final pwdCtrler = TextEditingController();
  final newConsultationFeeCtrler = TextEditingController();
  final followUpConsultationFeeCtrler = TextEditingController();
  final formKey = GlobalKey<FormState>();

  ///Radio Btn
  Gender genderValue = Gender.male;
  Status statusValue = Status.active;

  var obscureText = true.obs;
  var primaryContact = false.obs;
  static bool loadContacts = false;
  static String doctorID = "";
  String doctorIdToPost = "";

  //Assign Schedule M
  static String slotID = "";
  String slotIdToPost = "";

  //Handling View Stuff
  bool isShowSearchBtn = true;

  int statusToPost = 1;
  String genderToPost = "";
  String userIdToPost = "";

  @override
  void onInit() async {
    print(doctorID);
    print(genderToPost);
    genderToPost = "Male";
    statusToPost = 1;

    ///checking condition
    if (doctorID != "0" && doctorID.isNotEmpty) {
      //Assigning Initial Values for update
      doctorIdToPost = doctorID;
      fNameCtrler.text = Get.parameters["name"]!;
      emailCtrler.text = Get.parameters["email"]!;
      phoneCtrler.text = Get.parameters["phone"]!;
      // pwdCtrler.text = Get.parameters["password"]!;
      genderToPost = Get.parameters["gender"]!;
      newConsultationFeeCtrler.text = Get.parameters["new_consultation_fees"]!;
      followUpConsultationFeeCtrler.text =
          Get.parameters["followup_consultation_fees"]!;
      statusToPost = int.parse(Get.parameters["status"]!);
      //Radio Btn stuff
      if (genderToPost == "Male") {
        genderValue = Gender.male;
      } else if (genderToPost == "Female") {
        genderValue = Gender.female;
      } else {
        genderValue = Gender.other;
      }
      if (statusToPost == 1) {
        statusValue = Status.active;
      } else {
        statusValue = Status.inactive;
      }
    }
    super.onInit();
  }

  Future<void> addDoctor() async {
    if (await Utilities.isOnline()) {
      try {
        Utilities.showDialog(Get.context!);
        final token = await Preferences.getString(Preferences.login_token);
        final Map<String, dynamic> jsonObject = {
          "name": fNameCtrler.text.trim(),
          "email": emailCtrler.text.trim(),
          'password': pwdCtrler.text.trim(),
          'gender': genderToPost,
          'phone': phoneCtrler.text.trim(),
          'new_consultation_fees': newConsultationFeeCtrler.text.trim(),
          'followup_consultation_fees':
              followUpConsultationFeeCtrler.text.trim(),
          'status': statusToPost.toString(),
        };
        debugPrint(jsonObject.toString());

        final result = await HttpHelper.executePost(
            jsonObject, HttpHelper.addDoctor, null, token);

        debugPrint(result.toString());
        Utilities.hideDialog();
        if (result["status"] == 1) {
          if (result["data"] != null) {
            Utilities.showToast(message: result["message"] ?? "status");
            await Utilities.delay(1000);
            loadContacts = true;
            if (AddDoctorController.loadContacts) {
              Navigator.pop(Get.context!, "getDocList");
            } else {
              Navigator.pop(Get.context!);
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

  Future<void> updateDoctor() async {
    if (await Utilities.isOnline()) {
      try {
        Utilities.showDialog(Get.context!);
        final token = await Preferences.getString(Preferences.login_token);
        final Map<String, dynamic> jsonObject = {
          "doctor_id": doctorIdToPost,
          "name": fNameCtrler.text.trim(),
          "email": emailCtrler.text.trim(),
          'password': pwdCtrler.text.trim(),
          'gender': genderToPost,
          'phone': phoneCtrler.text.trim(),
          'new_consultation_fees': newConsultationFeeCtrler.text.trim(),
          'followup_consultation_fees':
              followUpConsultationFeeCtrler.text.trim(),
          'status': statusToPost.toString(),
        };
        debugPrint(jsonObject.toString());

        final result = await HttpHelper.executePost(
            jsonObject, HttpHelper.editdoctor, null, token);

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
      if (doctorIdToPost.isNotEmpty && doctorIdToPost != "0") {
        await updateDoctor();
      } else {
        await addDoctor();
      }
    }
  }

  @override
  void onClose() {
    loadContacts = false;
    doctorID = "";
    doctorIdToPost = "";
    userIdToPost = "";
    super.onClose();
  }
}
