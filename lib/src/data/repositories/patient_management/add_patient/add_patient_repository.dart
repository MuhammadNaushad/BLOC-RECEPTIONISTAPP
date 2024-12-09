import 'dart:developer';

import 'package:yslcrm/src/api/api.dart';
import 'package:yslcrm/src/data/repositories/patient_management/add_patient/add_patient_remote_repo.dart';
import 'package:yslcrm/src/models/patients_management/existing_user_data_model.dart';

class AddPatientRepository {
  final AddPatientRemoteRepository _addPatientRemoteRepository =
      AddPatientRemoteRepository();
  Future<ExistingUserDataModel> checkPatient({required String phone_no}) async {
    final existingUserObj;
    final result =
        await _addPatientRemoteRepository.checkPatient(phone_no: phone_no);
    log(result.toString());
    if (result["data"]["data"] != null && result["data"]["data"] != "") {
      existingUserObj = ExistingUserDataModel.fromJson(result);
    } else {
      result["data"]["data"] = {"name": "not found"};
      existingUserObj = ExistingUserDataModel.fromJson(result);
    }

    return existingUserObj;
  }

  Future<void> addUser(
      {required String phone_no,
      required String name,
      required String age,
      required String gender,
      required String address,
      required String status}) async {}
}
