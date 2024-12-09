import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yslcrm/src/api/http_helper.dart';
import 'package:yslcrm/src/models/doctors_management/get_all_doctors_list_model.dart';
import 'package:yslcrm/src/utils/alerts.dart';
import 'package:yslcrm/src/utils/preferences.dart';
import 'package:yslcrm/src/utils/utilities.dart';
import 'package:http/http.dart' as http;

class ExportController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final exportDateCtrler = TextEditingController(text: '--select--');
  //Dropdown Stuff
  final paymentDDCtrler = TextEditingController();
  List<String> paymentDDList = <String>["Cash", "Online"];
  List<String> paymentDDIDList = [];
  String paymentDDIdToPost = "";

  //Doctor Dropdown Stuff
  final doctorDDCtrler = TextEditingController(text: '--Select a doctor--');
  List<String> doctorDDList = <String>[];
  List<String> doctorDDIDList = [];
  String doctorDDIdToPost = "";

  @override
  void onInit() async {
    super.onInit();
    await getDoctorsListData(isShowTaost: false);
    update();
  }

  Future<void> exportApppointment(
      {required String date, String? mode, bool isPDF = true}) async {
    if (await Utilities.isOnline()) {
      try {
        Utilities.showDialog(Get.context!);
        final token = await Preferences.getString(Preferences.login_token);
        final Map<String, dynamic> jsonObject = {
          "date": date,
          "mode": mode,
          "doctor_id": doctorDDIdToPost,
        };
        final result = await HttpHelper.executePost(
            jsonObject,
            isPDF ? HttpHelper.appointmentpdf : HttpHelper.exportappointment,
            null,
            token);
        debugPrint(result.toString());
        Utilities.hideDialog();
        if (result["status"] == 1) {
          Utilities.showToast(message: result["message"] ?? "successfully");
          //DOWNLOADING FILE STUFF
          if (result["data"] != null && result["data"] != "") {
            debugPrint(result["data"].toString());
            if (isPDF) {
              await _launchUrl(result["data"].toString());
            } else {
              //http://172.105.41.135/bansal-dashboard/public/storage/exports/appointment_658e60e29c8bf.xlsx
              /* await downloadFileFromUrl(result["data"].toString(),
                  filename: 'excel.xlsx'); */
              _launchUrl(
                  // "https://procuri.yugasa.org/plugins/Purchase/Uploads/pur_request/4/testsresult["data"].toString()-example%20%282%29.xls"
                  result["data"].toString());
            }
          } else {
            Utilities.showToast(message: "File URL not available");
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

  Future<File> downloadFileFromUrl(String url,
      {required String filename}) async {
    File? urlFile;

    try {
      final response = await http.get(Uri.parse(url));
      final bytes = response.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/" + filename);
      debugPrint("DOWNLOADED FILE PATH: ${file.path}");
      urlFile = await file.writeAsBytes(bytes);
    } catch (e) {
      print(e);
    }
    return urlFile!;
  }

  Future<void> _launchUrl(String _url) async {
    try {
      final uri = Uri.parse(_url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        Utilities.showToast(
            message: "Something went wrong, Please try after sometime");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getDoctorsListData(
      {String? search, bool isShowTaost = true}) async {
    if (await Utilities.isOnline()) {
      try {
        // Utilities.showDialog(Get.context!);
        final result;
        // await Utilities.delay(3000);
        final token = await Preferences.getString(Preferences.login_token);
        if (search != null) {
          result = await HttpHelper.executeGet(
              HttpHelper.getActiveDoctorsList + "?search=$search",
              token); //?patient_id=147&name=varsha&phone=9511242559
        } else {
          result = await HttpHelper.executeGet(
              HttpHelper.getActiveDoctorsList, token);
        }

        debugPrint(result.toString());

        //  Utilities.hideDialog();
        if (result["status"] == 1) {
          if (result["data"] != null) {
            doctorDDList.clear();
            doctorDDIDList.clear();
            final GetAllDoctorsListModel data =
                GetAllDoctorsListModel.fromJson(result);
            if (data.data != null && data.data!.isNotEmpty) {
              for (var i = 0; i < data.data!.length; i++) {
                doctorDDList.add(data.data![i].name ?? "");
                doctorDDIDList.add(data.data![i].id.toString());
              }
              debugPrint(doctorDDList.toString());
              debugPrint(doctorDDIDList.toString());
            } else {}
            if (isShowTaost)
              Utilities.showToast(message: result["message"] ?? "status");
          } else {
            // Utilities.hideDialog();
            if (isShowTaost)
              Utilities.showToast(message: "No data found, Please try again.");
          }
        } else {
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

        Utilities.showToast(message: "Something went wrong");
      }
    } else {
      Utilities.noInternet();
    }
  }

  @override
  void onClose() {
    paymentDDIdToPost = "";
    exportDateCtrler.dispose();
    paymentDDCtrler.dispose();
    super.onClose();
  }
}
