import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_share/whatsapp_share.dart';
import 'package:yslcrm/src/api/http_helper.dart';
import 'package:yslcrm/src/common/ui/common.dart';
import 'package:yslcrm/src/models/appointment_management/get_all_appoint_data_model.dart';
import 'package:yslcrm/src/models/doctors_management/get_all_doctors_list_model.dart';
import 'package:yslcrm/src/utils/alerts.dart';
import 'package:yslcrm/src/utils/preferences.dart';
import 'package:yslcrm/src/utils/utilities.dart';
import 'package:http/http.dart' as http;

import '../widgets/active_inactive_radio.dart';

class AppointmentManagementController extends GetxController
    with GetTickerProviderStateMixin, StateMixin
    implements UtilitiesAbstract {
  AnimationController? animationController;
  // The controller for the ListView
  ScrollController? pController;

  final ScrollController scrollController = ScrollController();
  final searchCtrler = TextEditingController();
  final formKey = GlobalKey<FormState>();

  static var isLoading = false.obs;
  static var isDataNotFound = false.obs;
  static List<AppointmentData>? appointmentList = <AppointmentData>[].obs;
  bool isShowSelectAllBtn = false;
  bool isShowSelectAllBtnTxt = false;

  ///Radio Btn
  // Gender genderValue = Gender.male;
  Status statusValue = Status.active;

  int statusToPost = 1;
  String genderToPost = "";
  String userIdToPost = "";

  //Dropdown Stuff
  final appointmentDDCtrler = TextEditingController();
  List<String> appointmentDDList = <String>[
    "--Select--",
    "Active",
    "Cancelled"
  ];
  List<String> appointmentDDIDList = [];
  String appointmentDDIdToPost = "";
  String appointmentDDValueToPost = "--Select--";
  String appointmentDDValueToPostServer = "";
  String tokenDDValueToPostServer = "";

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
  List<String> appointmentIdListToPost = [];
  final exportDateCtrler = TextEditingController();
  //Dropdown Stuff
  final paymentDDCtrler = TextEditingController();
  List<String> paymentDDList = <String>["Cash", "Walk In Online"];
  List<String> paymentDDIDList = [];
  String paymentDDIdToPost = "";

  //Dropdown Stuff
  final doctorDDCtrler = TextEditingController(text: '--Select a doctor--');
  List<String> doctorDDList = <String>[];
  List<String> doctorDDIDList = [];
  String doctorDDIdToPost = "";

  // At the beginning, we fetch the first 20 posts
  int page = 1;
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
    await [getAppointmentListData(), getDoctorsListData(isShowTaost: false)];
    pController = ScrollController()..addListener(_loadMore);
    //Textfield Listener
    searchCtrler
      ..addListener(() async {
        if (searchCtrler.text.length > 0) {
          showSearchClearBtn = true;
          page = 1;
        } else {
          showSearchClearBtn = false;
        }
        update();
      });
  }

  void _loadMore() async {
    if (isLoading.value == false &&
        isLoadMoreRunning == false &&
        // searchCtrler.text == "" &&
        isShowSelectAllBtn == false &&
        isShowSelectAllBtnTxt == false &&
        pController!.position.pixels == pController!.position.maxScrollExtent) {
      print('scrolled');

      isLoadMoreRunning = true;
      update();
      // Display a progress indicator at the bottom
      page += 1; // Increase page by 1
      print('PAGE :$page');

      try {
        if (doctorDDIdToPost.isNotEmpty) {
          await getAppointmentListData(
              isShowTaost: false, doctorId: doctorDDIdToPost);
        } else if (searchCtrler.text.isNotEmpty) {
          await getAppointmentListData(
            isShowTaost: false,
            search: searchCtrler.text.trim(),
          );
        } else {
          await getAppointmentListData(
            isShowTaost: false,
          );
        }
      } catch (err) {
        if (kDebugMode) {
          print('Something went wrong!');
        }
      }

      isLoadMoreRunning = false;
      update();
    }
  }

  Future<void> getAppointmentListData(
      {String? search,
      String? doctorId,
      bool isShowTaost = true,
      bool isReload = false}) async {
    if (await Utilities.isOnline()) {
      try {
        // Utilities.showDialog(Get.context!);
        if (page == 1 || search != null || isReload) {
          isLoading.value = true;
          if (isReload) {
            page = 1;
          }
        }
        final result;
        // await Utilities.delay(3000);
        final token = await Preferences.getString(Preferences.login_token);
        if (search != null && search.isNotEmpty) {
          if (page > 1) {
            result = await HttpHelper.executePost(
                {},
                HttpHelper.getAppointmentList +
                    "?page=$page&doctor_id=$doctorId&search=$search",
                null,
                token);
          } else {
            if (doctorId != null && doctorId.isNotEmpty) {
              result = await HttpHelper.executePost(
                  {},
                  HttpHelper.getAppointmentList +
                      "?doctor_id=$doctorId&search=$search",
                  null,
                  token);
            } else {
              result = await HttpHelper.executePost({},
                  HttpHelper.getAppointmentList + "?search=$search",
                  null,
                  token);
            }
          }

          //?patient_id=147&name=varsha&phone=9511242559
        } else if (doctorId != null && doctorId.isNotEmpty) {
          if (page > 1) {
            if (search != null && search.isNotEmpty) {
              result = await HttpHelper.executePost(
                  {},
                  HttpHelper.getAppointmentList +
                      "?page=$page&doctor_id=$doctorId&search=$search",
                  null,
                  token);
            } else {
              result = await HttpHelper.executePost(
                  {},
                  HttpHelper.getAppointmentList +
                      "?page=$page&doctor_id=$doctorId",
                  null,
                  token);
            }
          } else {
            if (search != null && search.isNotEmpty) {
              result = await HttpHelper.executePost(
                  {},
                  HttpHelper.getAppointmentList +
                      "?doctor_id=$doctorId&search=$search",
                  null,
                  token);
            } else {
              result = await HttpHelper.executePost({},
                  HttpHelper.getAppointmentList + "?doctor_id=$doctorId",
                  null,
                  token);
            }
          }

          //?patient_id=147&name=varsha&phone=9511242559
        } else {
          if (page > 1) {
            result = await HttpHelper.executePost(
                {}, HttpHelper.getAppointmentList + "?page=$page", null, token);
          } else {
            result = await HttpHelper.executePost(
                {}, HttpHelper.getAppointmentList, null, token);
          }
        }
        debugPrint(result.toString());
        //  Utilities.hideDialog();
        if (page == 1 || search != null || isReload) {
          isLoading.value = false;
        }
        if (result["status"] == 1) {
          if (result["data"] != null && result["data"]["data"] != null) {
            final GetAllAppointmentDataModel data =
                GetAllAppointmentDataModel.fromJson(result);
            if (data.data!.basedata != null) {
              /* if (search != null) {
                doctorDDCtrler.text = '--Select a doctor--';
                update();
              } else {
                // doctor id to be added
                searchCtrler.text = '';
                update();
              } */
              if (page == 1 || search != null || isReload) {
                isDataNotFound.value = false;
                if (page == 1) {
                  appointmentList!.clear();
                }
              }

              debugPrint(data.data!.toString());
              for (var element in data.data!.basedata!) {
                appointmentList!.add(element);
              }
              //appointmentList = data.data!.basedata!;

              debugPrint(appointmentList.toString());
              if (appointmentList!.isEmpty) {
                isDataNotFound.value = true;
                isLoading.value = false;
              }
              update();
            } else {
              appointmentList!.clear();
              isDataNotFound.value = true;
              isLoading.value = false;
            }
            if (isShowTaost)
              Utilities.showToast(message: result["message"] ?? "status");
          } else {
            appointmentList!.clear();
            isDataNotFound.value = true;
            isLoading.value = false;
            if (isShowTaost)
              Utilities.showToast(message: "No data found, Please try again.");
          }
        } else {
          if (page == 1 || search != null || isReload) {
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
        if (page == 1 || search != null || isReload) {
          isLoading.value = false;
          isDataNotFound.value = true;
        }
        Utilities.showToast(message: "Something went wrong");
      }
    } else {
      Utilities.noInternet();
    }
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

  Future<void> changeAppointmentStatus() async {
    if (await Utilities.isOnline()) {
      try {
        Utilities.showDialog(Get.context!);
        final token = await Preferences.getString(Preferences.login_token);
        final Map<String, dynamic> jsonObject = {
          "status": appointmentDDValueToPostServer,
          "id": appointmentIdListToPost,
        };
        final result = await HttpHelper.executePostforJson(
            jsonObject, HttpHelper.changestatus, null, token);
        debugPrint(result.toString());
        Utilities.hideDialog();
        if (result["status"] == 1) {
          if (result["data"] != null) {
            Utilities.showToast(message: result["message"] ?? "success");
            isShowSelectAllBtn = false;
            isShowSelectAllBtnTxt = false;

            /*  showSearchClearBtn = false;
            searchCtrler.text = ""; */
            FocusScope.of(Get.context!).requestFocus(FocusNode());
            for (AppointmentData appointment in appointmentList!) {
              if (appointmentIdListToPost.first == appointment.id.toString()) {
                appointment.status!.value = appointmentDDValueToPostServer;
              }
            }
            appointmentIdListToPost.clear();
            update();
            /* await getAppointmentListData(
                isShowTaost: false,
                doctorId: doctorDDIdToPost,
                search: searchCtrler.text); */
            //update();
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

  Future<void> changeStokenStatus() async {
    if (await Utilities.isOnline()) {
      try {
        Utilities.showDialog(Get.context!);
        final token = await Preferences.getString(Preferences.login_token);
        final Map<String, dynamic> jsonObject = {
          "status": tokenDDValueToPostServer,
          "id": appointmentIdListToPost,
        };
        final result = await HttpHelper.executePostforJson(
            jsonObject, HttpHelper.changetokenstatus, null, token);
        debugPrint(result.toString());
        Utilities.hideDialog();
        if (result["status"] == 1) {
          if (result["data"] != null) {
            Utilities.showToast(message: result["message"] ?? "success");
            isShowSelectAllBtn = false;
            isShowSelectAllBtnTxt = false;
            searchCtrler.text = "";
            showSearchClearBtn = false;
            FocusScope.of(Get.context!).requestFocus(FocusNode());
            for (AppointmentData appointment in appointmentList!) {
              if (appointmentIdListToPost.first == appointment.id.toString()) {
                appointment.tokenStatus!.value = tokenDDValueToPostServer;
              }
            }
            appointmentIdListToPost.clear();

            update();
            //await getAppointmentListData(isShowTaost: false);
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

  Future<void> whatsappAPI(
      {required String phone,
      required String pname,
      required String recieptURL}) async {
    if (await Utilities.isOnline()) {
      try {
        Utilities.showDialog(Get.context!);
        final token =
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjbGllbnRJZCI6ImJhbnNhbF9ob3NwaXRhbCIsImVtYWlsIjoia2Vzb2pvYzg0MkBsZXRwYXlzLmNvbSIsInRpbWVzdGFtcCI6IjIwMjQtMTEtMjhUMDg6Mjk6NDAuMDg5WiIsImNoYW5uZWwiOiJ3aGF0c2FwcCIsImlhdCI6MTczMjc4MjU4MH0.yeFP3TkLyc0MPqtzM0Uxw-9msNuivyTzsJ5DVQ-vsnQ";
        final Map<String, dynamic> jsonObject = {
          "clientId": "bansal_hospital",
          "channel": "whatsapp",
          "token": "",
          "send_to": phone,
          "button": false,
          "header": "",
          "footer": "",
          "parameters": [pname],
          "msg_type": "DOCUMENT",
          "templateName": "send_receipt",
          "media_url": recieptURL,
          "buttonUrlParam": "",
          "userName": "",
          "lang": "en"
        };
        final result = await HttpHelper.executePostforJson(
            jsonObject,
            "https://api.helloyubo.com/v2/whatsapp/notification",
            null,
            token,
            true);
        debugPrint(result.toString());
        Utilities.hideDialog();
        if (result["status"] == true) {
          Utilities.showToast(message: result["message"] ?? "successfully");
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
      await getAppointmentListData(search: textValue);
    });
  }

  launchWhatsapp(context,
      {required String mobileNo,
      required String msg,
      required String receiptNo}) async {
    debugPrint("Mobile No: ${mobileNo}");
    debugPrint("Receipt Name: ${msg}");
    final whatsappNo = "91$mobileNo";
    // var whatsappAndroid =
    //     Uri.parse("whatsapp://send?phone=$whatsapp&text=${msg.trim()}");
    try {
      // var url = "whatsapp://send?phone=$mobileNo&file=$msg";

      await downloadFile(
          url: msg, filename: "${receiptNo}", mobileNo: whatsappNo);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Something went wrong, Please try again"),
        ),
      );
    }
  }

  Future<void> printPDF(String URL) async {
    var datas = await http.get(Uri.parse(URL));
    await Printing.layoutPdf(onLayout: (_) => datas.bodyBytes);
  }

  /// download file function
  Future downloadFile({
    required String url,
    required String filename,
    required String mobileNo,
  }) async {
    try {
      HttpClient client = HttpClient();
      List<int> downloadData = [];
      debugPrint(mobileNo);
      debugPrint(filename);
      debugPrint(url);
      Directory downloadDirectory;

      if (Platform.isIOS) {
        downloadDirectory = await getApplicationDocumentsDirectory();
      } else {
        downloadDirectory = Directory('/storage/emulated/0/Download');
        if (!await downloadDirectory.exists())
          downloadDirectory = (await getExternalStorageDirectory())!;
      }

      String filePathName = "${downloadDirectory.path}/$filename";
      File savedFile = File(filePathName);
      bool fileExists = await savedFile.exists();

      if (fileExists) {
        /*  ScaffoldMessenger.of(Get.context!).showSnackBar(
            const SnackBar(content: Text("File already downloaded"))); */
        client.getUrl(Uri.parse(url)).then(
          (HttpClientRequest request) {
            return request.close();
          },
        ).then(
          (HttpClientResponse response) {
            response.listen((d) => downloadData.addAll(d), onDone: () async {
              savedFile.writeAsBytes(downloadData);
              //  downloadedFile = savedFile;
              await WhatsappShare.shareFile(
                phone: mobileNo,
                filePath: [savedFile.path],
              );
            });
          },
        );
      } else {
        client.getUrl(Uri.parse(url)).then(
          (HttpClientRequest request) {
            return request.close();
          },
        ).then(
          (HttpClientResponse response) {
            response.listen((d) => downloadData.addAll(d), onDone: () async {
              savedFile.writeAsBytes(downloadData);
              //  downloadedFile = savedFile;
              await WhatsappShare.shareFile(
                phone: mobileNo,
                filePath: [savedFile.path],
              );
            });
          },
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          content: Text("Something went wrong, Please try again"),
        ),
      );
    }
  }

  @override
  void onClose() {
    animationController?.dispose();
    pController!.removeListener(_loadMore);

    appointmentList!.clear();
    if (timeHandle != null) {
      timeHandle!.cancel();
    }
    super.onClose();
  }

  @override
  Future<void> onRefresh() async {
    searchCtrler.text = "";
    page = 1;
    showSearchClearBtn = false;
    doctorDDCtrler.text = '--Select a doctor--';
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    doctorDDIdToPost = '';
    update();
    await getAppointmentListData();
  }
}
