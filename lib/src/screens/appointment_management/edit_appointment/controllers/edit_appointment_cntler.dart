import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/api/http_helper.dart';
import 'package:yslcrm/src/models/appointment_management/add_appointment/get_patients_for_appnmt.dart';
import 'package:yslcrm/src/models/doctors_management/get_all_doctors_list_model.dart';
import 'package:yslcrm/src/models/schedule_management/get_all_slot_model.dart';
import 'package:yslcrm/src/routes/app_pages.dart';
import 'package:yslcrm/src/utils/alerts.dart';
import 'package:yslcrm/src/utils/preferences.dart';

import '../../../../utils/utilities.dart';

class EditAppointmentController extends GetxController {
//AddContacts TF Controllers
  final fNameCtrler = TextEditingController();
  final userCtrler = TextEditingController();
  final ageCtrler = TextEditingController();
  final addressCtrler = TextEditingController();
  final phoneCtrler = TextEditingController();
  final emailCtrler = TextEditingController();
  final pwdCtrler = TextEditingController();
  final priceCtrler = TextEditingController();
  final receiptNoCtrler = TextEditingController();
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

//Patients Dropdown Stuff
  final patientDCtrler = TextEditingController();
  List<String> patientDList = <String>[];
  List<String> patientDIDList = [];
  String patientDropDIdToPost = "";
  //Dropdown Stuff
  final doctorDDCtrler = TextEditingController();
  List<String> doctorDDList = <String>[];
  List<String> doctorDDIDList = [];
  String doctorDDIdToPost = "";
  String appointmentIdToPost = "";
  //Dropdown Stuff
  final slotsDDCtrler = TextEditingController();
  List<String> slotsDDList = <String>[];
  List<String> slotsDDIDList = [];
  String slotsDDIdToPost = "";

  //Dropdown Stuff
  final paymentDDCtrler = TextEditingController();
  List<String> paymentDDList = <String>["Cash", "Walk In Online"];
  List<String> paymentDDIDList = [];
  String paymentDDIdToPost = "";
  //TextFieldCntlers
  final dateCtrler = TextEditingController();

  //Handling DropD Disable Views Stuff
  bool isDoctorDDEnable = false;
  bool isDateEnable = false;
  bool isSlotDDEnable = true;
  bool isPaymentTFEnable = false;

  //Appointment DD Stuff
  final appointmentDDCtrler = TextEditingController();
  List<String> appointmentDDList = <String>[
    "--Select--",
    "Active",
    "Completed",
    "Cancelled",
  ];
  List<String> appointmentDDIDList = [];
  String appointmentDDIdToPost = "";
  String appointmentDDValueToPost = "--Select--";
  String appointmentDDValueToPostServer = "";

//Dropdown Stuff
  final tokenDDCtrler = TextEditingController();
  List<String> tokenDDList = <String>[
    "--Select--",
    "Active",
    "InProgress",
    "Cancelled",
    "Completed"
  ];
  List<String> tokenDDIDList = [];
  String tokenDDIdToPost = "";
  String tokenDDValueToPost = "--Select--";
  String tokenDDValueToPostServer = "";

  @override
  void onInit() async {
    debugPrint(Get.parameters.toString());
    try {
      if (Get.parameters["doctor_id"] != null) {
        doctorDDIdToPost = Get.parameters["doctor_id"]!;
      }
      if (Get.parameters["id"] != null) {
        appointmentIdToPost = Get.parameters["id"]!;
      }
      //slot dd stuff
      slotsDDIdToPost = Get.parameters["slot_id"]!;
      slotsDDIDList = [Get.parameters["slot_id"]!];
      slotsDDList = [Get.parameters["time_slot"]!];
      slotsDDCtrler.text = Get.parameters["time_slot"]!;
      //token status stuff
      if (Get.parameters["token_status"]! == "1") {
        tokenDDValueToPostServer = "Active";
      } else if (Get.parameters["token_status"]! == "2") {
        tokenDDValueToPostServer = "InProgress";
      } else if (Get.parameters["token_status"]! == "0") {
        tokenDDValueToPostServer = "Completed";
      } else {
        tokenDDValueToPostServer = "Cancelled";
      }
      tokenDDValueToPost = tokenDDValueToPostServer;
      //Appointment status stuff
      if (Get.parameters["status"]! == "Active" ||
          Get.parameters["status"]! == "0") {
        appointmentDDValueToPostServer = "0";
        appointmentDDValueToPost = "Active";
      } else {
        appointmentDDValueToPostServer = Get.parameters["status"]!;
        appointmentDDValueToPost = appointmentDDValueToPostServer;
      }
      priceCtrler.text = Get.parameters["amount"]!;
      dateCtrler.text = Get.parameters["date"]!;
    } catch (e) {
      print(e);
    }

    super.onInit();
  }

  Future<void> updateAppointment() async {
    if (await Utilities.isOnline()) {
      try {
        Utilities.showDialog(Get.context!);
        final token = await Preferences.getString(Preferences.login_token);
        final Map<String, dynamic> jsonObject = {
          "date": dateCtrler.text.trim(),
          'availabilities': slotsDDIdToPost,
          'appoint_status': appointmentDDValueToPostServer,
          "status": tokenDDValueToPostServer,
          'id': appointmentIdToPost,
        };
        debugPrint(jsonObject.toString());

        final result = await HttpHelper.executePost(
            jsonObject, HttpHelper.updateAppointm, null, token);

        debugPrint(result.toString());
        Utilities.hideDialog();
        if (result["status"] == 1) {
          if (result["data"] != null) {
            Utilities.showToast(message: result["message"] ?? "status");
            await Utilities.delay(1000);
            loadContacts = true;
            if (EditAppointmentController.loadContacts) {
              Navigator.pop(Get.context!, "reload");
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

  Future<void> checkSlots() async {
    if (await Utilities.isOnline()) {
      try {
        Utilities.showDialog(Get.context!);
        final token = await Preferences.getString(Preferences.login_token);
        final Map<String, dynamic> jsonObject = {
          "doctor_id": doctorDDIdToPost,
          "date": dateCtrler.text,
        };
        final result = await HttpHelper.executePost(
            jsonObject, HttpHelper.checkslots, null, token);
        debugPrint(result.toString());
        Utilities.hideDialog();
        if (result["status"] == 1) {
          if (result["data"] != null) {
            isSlotDDEnable = true;
            final GetAllSheduleModel data = GetAllSheduleModel.fromJson(result);
            if (data.data != null && data.data!.isNotEmpty) {
              slotsDDList.clear();
              slotsDDIDList.clear();
              for (var i = 0; i < data.data!.length; i++) {
                slotsDDList.add(data.data![i].timeSlots ?? "");
                slotsDDIDList.add(data.data![i].id.toString());
              }
              debugPrint(slotsDDList.toString());
              debugPrint(slotsDDIDList.toString());
            } else {
              isSlotDDEnable = false;
              slotsDDList.clear();
              slotsDDIDList.clear();
              slotsDDCtrler.text = "";
              // dateCtrler.text = "";
            }
            Utilities.showToast(message: result["message"] ?? "success");
          } else {
            isSlotDDEnable = false;
            Utilities.showToast(
                message: result["message"] ??
                    "Unable to proceed, Please try again.");
          }
        } else {
          isSlotDDEnable = false;
          dateCtrler.text = "";
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

  Future<void> getPrice() async {
    if (await Utilities.isOnline()) {
      try {
        Utilities.showDialog(Get.context!);
        final token = await Preferences.getString(Preferences.login_token);
        final Map<String, dynamic> jsonObject = {
          "doctor_id": doctorDDIdToPost,
          "patient_id": patientDropDIdToPost,
        };
        final result = await HttpHelper.executePost(
            jsonObject, HttpHelper.getprice, null, token);
        debugPrint(result.toString());
        Utilities.hideDialog();
        if (result["status"] == 1) {
          if (result["data"] != null) {
            if (result["data"]["price"] != null) {
              priceCtrler.text = result["data"]["price"].toString();
            }
            Utilities.showToast(message: result["message"] ?? "success");
          } else {
            isSlotDDEnable = false;
            Utilities.showToast(
                message: result["message"] ??
                    "Unable to proceed, Please try again.");
          }
        } else {
          isSlotDDEnable = false;
          dateCtrler.text = "";
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
      await ();
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
