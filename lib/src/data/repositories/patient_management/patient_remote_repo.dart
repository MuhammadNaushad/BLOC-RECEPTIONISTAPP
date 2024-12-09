import 'package:flutter/material.dart';
import 'package:yslcrm/src/api/api.dart';

class PatientRemoteRepository {
  Future<dynamic> getPatients({
    required String page,
    String search = "",
  }) async {
    try {
      final Map<String, dynamic> body = {};
      final result;
      if (search.isEmpty) {
        result = await Api.sendApiRequest(
            body: body, url: Api.getPatientsList + "?page=$page", isGet: true);
      } else {
        result = await Api.sendApiRequest(
            body: body,
            url: Api.getPatientsList + "?search=$search",
            isGet: true);
      }

      debugPrint(result.runtimeType.toString());
      return result;
    } catch (e) {
      throw ApiMessageAndCodeException(errorMessage: e.toString());
    }
  }
}
