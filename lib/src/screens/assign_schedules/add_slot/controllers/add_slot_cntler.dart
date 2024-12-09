import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yslcrm/src/api/http_helper.dart';
import 'package:yslcrm/src/utils/alerts.dart';
import 'package:yslcrm/src/utils/preferences.dart';
import 'package:yslcrm/src/utils/table_test.dart' as time_picker_widget;

import '../../../../utils/utilities.dart';

class AddSlotController extends GetxController {
//AddContacts TF Controllers
  final dNameCtrler = TextEditingController();
  final slotStartCtrler = TextEditingController();
  final slotCtrler = TextEditingController();
  final slotEndCtrler = TextEditingController();
  final noOfTokensCtrler = TextEditingController();

  final formKey = GlobalKey<FormState>();

  var obscureText = true.obs;
  var primaryContact = false.obs;
  static bool loadContacts = false;
  static String slotID = "";
  String slotIdToPost = "";
  String doctorIdToPost = "";

  //Handling View Stuff
  bool isShowSearchBtn = true;
  bool isShowUserView = false;
  bool isShowPatientView = false;
  int statusToPost = 1;
  String genderToPost = "";
  String userIdToPost = "";

  @override
  void onInit() async {
    print(slotID);
    //Assigning Initial Values for update
    slotIdToPost = slotID;
    if (slotID.isNotEmpty) {
      dNameCtrler.text = Get.parameters["name"]!;
      noOfTokensCtrler.text = Get.parameters["tokens"]!;
      slotCtrler.text = Get.parameters["slots"]!;
      doctorIdToPost = Get.parameters["id"]!;
    } else {
      dNameCtrler.text = Get.parameters["name"]!;
      doctorIdToPost = Get.parameters["id"]!;
    }

    super.onInit();
  }

  Future<void> addSlot() async {
    if (await Utilities.isOnline()) {
      try {
        Utilities.showDialog(Get.context!);
        final token = await Preferences.getString(Preferences.login_token);
        final Map<String, dynamic> jsonObject = {
          "slot": "${slotStartCtrler.text} - ${slotEndCtrler.text}",
          'tokens': noOfTokensCtrler.text.trim(),
          'doctor_id': doctorIdToPost,
        };
        debugPrint(jsonObject.toString());

        final result = await HttpHelper.executePost(
            jsonObject, HttpHelper.addSlot, null, token);

        debugPrint(result.toString());
        Utilities.hideDialog();
        if (result["status"] == 1) {
          if (result["data"] != null) {
            Utilities.showToast(message: result["message"] ?? "status");
            await Utilities.delay(1000);
            loadContacts = true;
            if (AddSlotController.loadContacts) {
              Navigator.pop(Get.context!, "getList");
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

  Future<void> updateSlot() async {
    if (await Utilities.isOnline()) {
      try {
        Utilities.showDialog(Get.context!);
        final token = await Preferences.getString(Preferences.login_token);
        final Map<String, dynamic> jsonObject = {
          "slot_id": slotIdToPost,
          "tokens": noOfTokensCtrler.text.trim(),
        };
        debugPrint(jsonObject.toString());

        final result = await HttpHelper.executePost(
            jsonObject, HttpHelper.editSlot, null, token);

        debugPrint(result.toString());
        Utilities.hideDialog();
        if (result["status"] == 1) {
          if (result["data"] != null) {
            Utilities.showToast(message: result["message"] ?? "status");
            await Utilities.delay(1000);
            Navigator.pop(Get.context!, "getList");
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

  TimeOfDay? currentTime = TimeOfDay.now();

  Future<void> selectFullTime(
      TextEditingController textEditingController) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: Get.context!,
      initialTime: currentTime!,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null) {
      currentTime = timeOfDay;
      // Conversion logic starts here
      final DateTime tempDate = DateFormat("hh:mm").parse(
          timeOfDay.hour.toString() + ":" + currentTime!.minute.toString());

      DayPeriod dayPeriod = timeOfDay.period;
      print(dayPeriod.name);
      final dateFormat = DateFormat("hh:mm"); // you can change the format here
      print(dateFormat.format(tempDate));
      textEditingController.text =
          "${dateFormat.format(tempDate).toString()} ${dayPeriod.name.toUpperCase()}";
      /*   currentHour.value = timeOfDay.hour;
      currentMinuts.value = timeOfDay.minute; */
    }
  }

  Future<void> selectEndTime(
      TextEditingController textEditingController) async {
    DateTime dateTime = DateFormat("h:mm a").parse(slotStartCtrler.text);
    TimeOfDay _startTimeOfDay = TimeOfDay.fromDateTime(dateTime);
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: Get.context!,
      initialTime: _startTimeOfDay,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null) {
      currentTime = timeOfDay;
      // Conversion logic starts here
      final DateTime tempDate = DateFormat("hh:mm").parse(
          timeOfDay.hour.toString() + ":" + currentTime!.minute.toString());

      DayPeriod dayPeriod = timeOfDay.period;
      print(dayPeriod.name);
      final dateFormat = DateFormat("hh:mm"); // you can change the format here
      print(dateFormat.format(tempDate));
      slotEndCtrler.text =
          "${dateFormat.format(tempDate).toString()} ${dayPeriod.name.toUpperCase()}";
      /*   currentHour.value = timeOfDay.hour;
      currentMinuts.value = timeOfDay.minute; */
    }
  }

  Future<void> selectShortTimeForEndTime(
      TextEditingController textEditingController) async {
    DateTime dateTime = DateFormat("h:mm a").parse(slotStartCtrler.text);
    TimeOfDay _startTimeOfDay = TimeOfDay.fromDateTime(dateTime);
    print(slotStartCtrler.text.split(":").first);
    final TimeOfDay? timeOfDay = await time_picker_widget
        .showCustomTimePicker(
            context: Get.context!,
            // It is a must if you provide selectableTimePredicate
            onFailValidation: (context) =>
                Utilities.showToast(message: 'Unavailable selection'),
            initialTime: _startTimeOfDay,
            selectableTimePredicate: (time) =>
                time!.hour >= _startTimeOfDay.hour ||
                time.minute >= _startTimeOfDay.minute)
        .then((time) => currentTime = time);
    if (timeOfDay != null) {
      currentTime = timeOfDay;
// Conversion logic starts here
      DateTime tempDate = DateFormat("hh:mm").parse(
          timeOfDay.hour.toString() + ":" + currentTime!.minute.toString());
      DayPeriod dayPeriod = timeOfDay.period;
      print(dayPeriod.name);
      final dateFormat = DateFormat("hh:mm"); // you can change the format here
      print(dateFormat.format(tempDate));
      final dateTimeStr =
          "${dateFormat.format(tempDate).toString()} ${dayPeriod.name.toUpperCase()}";
      if (dateTimeStr != slotStartCtrler.text) {
        slotEndCtrler.text = dateTimeStr;
      } else {
        slotStartCtrler.text = "";
        Utilities.showToast(
            message: "End Time should be greater than Start Time");
      }
    }
  }

  Future<void> validation() async {
    if (slotIdToPost.isNotEmpty && slotIdToPost != "0") {
      await updateSlot();
    } else {
      await addSlot();
    }
  }

  @override
  void onClose() {
    loadContacts = false;
    slotID = "";
    slotIdToPost = "";
    userIdToPost = "";
    super.onClose();
  }
}
