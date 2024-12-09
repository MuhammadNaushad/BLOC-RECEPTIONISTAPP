import 'dart:developer';

import 'package:yslcrm/src/api/api.dart';
import 'package:yslcrm/src/models/patients_management/get_all_patients_model.dart';

import 'patient_remote_repo.dart';

class PatientRepository {
  PatientRemoteRepository _patientRemoteRepository = PatientRemoteRepository();

  Future<GetAllPatientsList> getPatients({
    required String page,
    required String search,
  }) async {
    try {
      final result = await _patientRemoteRepository.getPatients(
          page: page, search: search);
      log(result.toString());
      final response = GetAllPatientsList.fromJson(result);
      return response;
    } catch (e) {
      print(e);
      throw ApiMessageAndCodeException(errorMessage: e.toString());
    }
  }
}
