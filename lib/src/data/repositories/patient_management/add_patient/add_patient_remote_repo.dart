import 'package:yslcrm/src/api/api.dart';
import 'package:yslcrm/src/utils/strings.dart';

class AddPatientRemoteRepository {
  Future<dynamic> checkPatient({required String phone_no}) async {
    try {
      final Map<String, dynamic> body = {PHONE: phone_no};
      final result;
      result = await Api.sendApiRequest(
          body: body, url: Api.checkuser, isGet: false);

      return result;
    } catch (e) {
      throw ApiMessageAndCodeException(errorMessage: e.toString());
    }
  }

  Future<void> addUser(
      {required String phone_no,
      required String name,
      required String age,
      required String gender,
      required String address,
      required String status}) async {}
}
