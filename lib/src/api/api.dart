import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:yslcrm/src/utils/ErrorMessageKeys.dart';
import 'package:yslcrm/src/utils/preferences.dart';

import '../utils/constant.dart';
import '../utils/internetConnectivity.dart';

class ApiMessageAndCodeException implements Exception {
  final String errorMessage;

  ApiMessageAndCodeException({required this.errorMessage});

  Map toError() => {"message": errorMessage};

  @override
  String toString() => errorMessage;
}

class ApiException implements Exception {
  String errorMessage;

  ApiException(this.errorMessage);

  @override
  String toString() {
    return errorMessage;
  }
}

class Api {
  static Future<String> getToken() async {
    String token = await Preferences.getString(Preferences.login_token);
    debugPrint("token $token");
    return (token.trim().isNotEmpty) ? token : "";
  }

  static Map<String, String> get headers =>
      {"Authorization": 'Bearer ${getToken()}'};

  //all apis list
  static String getUserSignUpApi = 'user_signup';
  static String getNewsApi = 'get_news';
  //------------------------Patients Management-------------------//
  static const String getPatientsList = "patients";
  static const String checkuser = "checkuser";
  static const String deletepatient = "deletepatient";
  static const String adduser = "adduser";
  static const String addpatient = "addpatient";
  static const String editpatient = "editpatient";

//API Method
  static Future<Map<String, dynamic>> sendApiRequest(
      {bool isGet = false,
      required Map<String, dynamic> body,
      required String url}) async {
    try {
      if (await InternetConnectivity.isNetworkAvailable() == false) {
        throw const SocketException(ErrorMessageKeys.noInternet);
      }
      final Dio dio = Dio();
      final apiUrl = "${Constant.databaseUrl}$url";
      final FormData formData =
          FormData.fromMap(body, ListFormat.multiCompatible);
      debugPrint(
          "Requested APi - $url & is Get? $isGet & params are ${formData.fields}");
      log("API URL - $apiUrl");
      log("TOKEN - $headers");
      String token = await Preferences.getString(Preferences.login_token);
      Map<String, dynamic> mheaders = {"Authorization": 'Bearer $token'};
      debugPrint("token $token");
      dio.interceptors.add(InterceptorsWrapper());
      final Response response;
      response = (isGet)
          ? await dio.get(apiUrl,
              queryParameters: body, options: Options(headers: mheaders))
          : await dio.post(apiUrl,
              data: formData, options: Options(headers: mheaders));
      log('$response');

      if (response.data['status'] == 0) {
        debugPrint(
            "APi exception for $url - msg - ${response.data['message']}");
        throw ApiException(response.data['message']);
      } else {
        debugPrint("APi response data for $url is ${response.data}");
      }
      return Map.from(response.data);
    } on DioException catch (e) {
      debugPrint("Dio Error - ${e.toString()}");
      if (e.response != null)
        debugPrint("Dio Error Status code - ${e.response!.statusCode}");
      if (e.response != null && e.response!.statusCode == 503) {
        throw ApiException(ErrorMessageKeys.serverDownMessage);
      } else if (e.response!.statusCode == 404) {
        throw ApiException(ErrorMessageKeys.requestAgainMessage);
      } else {
        throw ApiException(e.error is SocketException
            ? ErrorMessageKeys.noInternet
            : ErrorMessageKeys.defaultErrorMessage);
      }
    } on SocketException catch (e) {
      debugPrint("Socket Exception - ${e.toString()}");
      throw SocketException(e.message);
    } on ApiException catch (e) {
      debugPrint("APi Exception - ${e.toString()}");
      throw ApiException(e.errorMessage);
    } catch (e) {
      debugPrint("catch Exception- ${e.toString()}");
      throw ApiException(ErrorMessageKeys.defaultErrorMessage);
    }
  }
}
