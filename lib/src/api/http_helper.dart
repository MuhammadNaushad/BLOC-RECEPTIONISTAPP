import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;
import 'package:yslcrm/src/utils/preferences.dart';

class HttpHelper {
  //https://procuri.yugasa.org/index.php/api/vendor/;     //staging
  // "https://admin.innodesigns.in/api/fos/";    //Live
  //https://innodesigns-beta.yugasa.org/api/fos/ //for cilent testing

  static const bool isLiveUrl = true;
  static const String baseUrl = isLiveUrl == true
      ? "https://admin.bansalhospital.health.helloyubo.com/api/"
      : 'https://admin.bansalhospital.health.helloyubo.com/api/';

  static const String supervisorBaseUrl = 2 == 1 ? "" : '';

  static const String whatsappBaseURL =
      "https://admin.bansalhospital.health.helloyubo.com/pdf/";

  static const String otherBaseURL = "";

//------------------------Login&Register-------------------//
  static const String user_login = "login";
  static const String logout = "logout";
  static const String profile = "profile";
  static const String profileVendorCategory = "categoryList";
  static const String updateProfile = "updateProfile";
  static const String send_otp = "send_otp";
  static const String change_password = "send_reset_password_mail";

//------------------------Doctors Management-------------------//
  static const String getDoctorsList = "doctors";
  static const String deletedoctor = "deletedoctor";
  static const String addDoctor = "adddoctor";
  static const String editdoctor = "editdoctor";
  static const String checkpatient = "checkpatient";
//------------------------Schedule Management-------------------//
  static const String getSheduleList = "viewschedule";
  static const String addSlot = "addschedule";
  static const String editSlot = "editschedule";
  static const String deleteschedule = "deleteschedule";
//------------------------Patients Management-------------------//
  static const String getPatientsList = "patients";
  static const String checkuser = "checkuser";
  static const String deletepatient = "deletepatient";
  static const String adduser = "adduser";
  static const String addpatient = "addpatient";
  static const String editpatient = "editpatient";

//------------------------Appointment Management-------------------//
  static const String getAppointmentList = "appointment";
  static const String bookAppointment = "bookappointment";
  static const String updateAppointm = "edit-appointment";

  static const String getprice = "getprice";
  static const String checkslots = "checkslots";
  static const String checkPatientForAppointm = "checkpatient";

  static const String changestatus = "changestatus";
  static const String changetokenstatus = "changetokenstatus";
  static const String appointmentpdf = "appointmentpdf";
  static const String exportappointment = "exportappointment";
  static const String getActiveDoctorsList = "doctor-list";

//------------------------Notification-------------------//
  static const String notification_list = "notification";

  //Network Call Methods
  static Future<dynamic> executePost(
      Map<String, dynamic> jsonObject, String endPoint,
      [String? otherBaseUrl,
      String? token = '',
      bool superVisorBaseUrl = false]) async {
    var responseJson;
    try {
      /* final jsonBody = jsonEncode(jsonObject);
      log(jsonBody); */
      log(jsonObject.toString());
      log(jsonEncode(jsonObject));
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      final mainUrl = '${otherBaseUrl ?? baseUrl}' + endPoint;
      final supervisorBUrl = endPoint;
      log(mainUrl);
      log("TOKEN: $token");
      log("TOKEN: $token");
      var url = Uri.parse(!superVisorBaseUrl ? mainUrl : supervisorBUrl);
      log(supervisorBUrl);

      Map<String, String> builtHeaders = token!.length > 0 && token.isNotEmpty
          ? {
              'Authorization': 'Bearer $token',
              'Accept': 'application/json',
              'Content-Type': "application/x-www-form-urlencoded",
            }
          : {
              'Accept': 'application/json',
              'Content-Type': "application/x-www-form-urlencoded",
            };

      await http
          .post(url, body: jsonObject, headers: builtHeaders)
          .then((response) {
        debugPrint(response.body.toString());
        if (response.statusCode == HttpStatus.ok) {
          responseJson = jsonDecode(response.body);
        } else if (response.statusCode == 201) {
          responseJson = jsonDecode(response.body);
        } else if (response.statusCode == 401) {
          responseJson = jsonDecode(response.body);
        } else if (response.statusCode == 403) {
          responseJson = jsonDecode(response.body);
        } else if (response.statusCode == 404) {
          responseJson = jsonDecode(response.body);
        } else if (response.statusCode == 422) {
          responseJson = jsonDecode(response.body);
        } else {
          throw Exception("Failed due to Network Error");
        }
      });
      http.close();
      ioc.close();
    } catch (e) {
      print(e);
    }
    return responseJson;
  }

  static Future<dynamic> executeGet(String endPoint, String token,
      [String? otherBaseUrl, bool superVisorBaseUrl = false]) async {
    var responseJson;
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      final mainUrl = '${otherBaseUrl ?? baseUrl}' + endPoint;
      log(mainUrl);
      Map<String, String> builtHeaders = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      log(builtHeaders.toString());
      log("TOKEN: $token");
      final supervisorBUrl = '${otherBaseUrl ?? supervisorBaseUrl}' + endPoint;
      debugPrint(mainUrl);
      // print(supervisorBUrl);

      var url = Uri.parse(!superVisorBaseUrl ? mainUrl : supervisorBUrl);
      await http.get(url, headers: builtHeaders).then((response) {
        log(response.body.toString());
        if (response.statusCode == HttpStatus.ok) {
          responseJson = jsonDecode(response.body);
        } else if (response.statusCode == 201) {
          responseJson = jsonDecode(response.body);
        } else if (response.statusCode == 401) {
          responseJson = jsonDecode(response.body);
        } else if (response.statusCode == 403) {
          responseJson = jsonDecode(response.body);
        } else if (response.statusCode == 404) {
          responseJson = jsonDecode(response.body);
        } else {
          throw Exception("Failed due to Network Error");
        }
      });
      http.close();
      ioc.close();
    } catch (e) {
      print(e);
    }
    return responseJson;
  }

  static Future<dynamic> postFormData(String endPoint,
      {Map<String, dynamic>? data,
      Map<String, dynamic>? query,
      String? token,
      bool superVisorBaseUrl = false}) async {
    var responseJson;
    var url = superVisorBaseUrl == false
        ? baseUrl + endPoint
        : supervisorBaseUrl + endPoint;
    log(url);
    var httpUri = Uri.parse(url);
    Map<String, String> builtHeaders = {
      'content-type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var request = http.MultipartRequest(
      'POST',
      httpUri,
    )..headers.addAll(builtHeaders);
    log("TOKEN: $token");
    // Add form data fields from data map
    //final myData =jsonEncode( data!);
    data!.entries.forEach((e) async {
      if (e.value is List<File>) {
        //create multipart using filepath, string or bytes
        for (var item in e.value) {
          var file = await http.MultipartFile.fromPath(
            e.key,
            item.path,
          );
          //add multipart to request
          request.files.add(file);
        }
      } else if (e.value is File) {
        //create multipart using filepath, string or bytes
        var file = await http.MultipartFile.fromPath(
          e.key,
          e.value.path,
        );
        //add multipart to request
        request.files.add(file);
      } else if (e.value.runtimeType == String) {
        request.fields[e.key] = e.value;
      } else {
        request.fields[e.key] = jsonEncode(e.value);
      }
    });
    log(request.fields.toString());
    try {
      var response = await http.Response.fromStream(await request.send());
      if (response.statusCode == HttpStatus.ok) {
        responseJson = jsonDecode(response.body);
      } else if (response.statusCode == 201) {
        responseJson = jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        responseJson = jsonDecode(response.body);
      } else if (response.statusCode == 403) {
        responseJson = jsonDecode(response.body);
      } else if (response.statusCode == 404) {
        responseJson = jsonDecode(response.body);
      } else {
        throw Exception("Failed due to Network Error");
      }
    } catch (e) {
      print(e);
    }
    return responseJson;
  }

  //
  static Future<dynamic> executePostforJson(
      Map<String, dynamic> jsonObject, String endPoint,
      [String? otherBaseUrl,
      String? token = '',
      bool superVisorBaseUrl = false]) async {
    var responseJson;
    try {
      final jsonBody = json.encode(jsonObject);
      log(jsonBody);
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      final mainUrl = '${otherBaseUrl ?? baseUrl}' + endPoint;
      final supervisorBUrl = endPoint;
      print(mainUrl);
      log("TOKEN: $token");

      var url = Uri.parse(!superVisorBaseUrl ? mainUrl : supervisorBUrl);
      Map<String, String> builtHeaders = token!.length > 0 && token.isNotEmpty
          ? {
              'Content-Type': 'application/json',
              'accept': 'application/json',
              'Authorization': 'Bearer $token',
            }
          : {
              'Content-Type': 'application/json',
            };
      await http
          .post(url, body: jsonBody, headers: builtHeaders)
          .then((response) {
        if (response.statusCode == HttpStatus.ok) {
          responseJson = jsonDecode(response.body);
        } else if (response.statusCode == 201) {
          responseJson = jsonDecode(response.body);
        } else if (response.statusCode == 401) {
          responseJson = jsonDecode(response.body);
        } else if (response.statusCode == 403) {
          responseJson = jsonDecode(response.body);
        } else if (response.statusCode == 404) {
          responseJson = jsonDecode(response.body);
        } else {
          throw Exception("Failed due to Network Error");
        }
      });
      http.close();
      ioc.close();
    } catch (e) {
      print(e);
    }
    return responseJson;
  }

  static Future<Map<String, String>> getApiHeaders(
      bool authorizationRequired) async {
    Map<String, String> apiHeader = new Map<String, String>();
    if (authorizationRequired) {
      final token = await Preferences.getString(Preferences.login_token);
      if (token.isNotEmpty) {
        apiHeader.addAll({"Authorization": "Bearer $token"});
      }
    }
    apiHeader.addAll({"Content-Type": "application/json"});
    apiHeader.addAll({"Accept": "application/json"});
    return apiHeader;
  }

  static Future<void> getprofile() async {
    try {
      Response? response;
      var dio = Dio();
      final token = await Preferences.getString(Preferences.login_token);
      debugPrint(token);

      response = await dio.get(
          'https://procuri.yugasa.org/index.php/api/vendor/profile',
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));

      debugPrint(response.data);
    } catch (e) {
      print(e);
    }
  }
}
