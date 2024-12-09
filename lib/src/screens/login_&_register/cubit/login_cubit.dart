import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:yslcrm/src/data/repositories/auth/auth_repository.dart';
import 'package:yslcrm/src/routes/app_pages.dart';
import 'package:yslcrm/src/utils/preferences.dart';
import 'package:yslcrm/src/utils/utilities.dart';

part 'login_state.dart';

class TogglePWDCubit extends Cubit<bool> {
  TogglePWDCubit() : super(true);

  void togglePasswordVisibility(bool val) {
    emit(!state);
  }
}

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit(this._authRepository) : super(LoginInitial());

  void togglePasswordVisibility(bool val) {
    emit(TogglePasswordIcon(val));
  }

  Future<void> login({
    required String email,
    required String password,
    String? fcmToken,
  }) async {
    final result;
    try {
      emit(LoginInProgress());
      result = await _authRepository.login(email: email, password: password);
      debugPrint('$result');
      // isLoading.value = false;
      if (result["status"] == 1) {
        final data = result["data"];
        if (data["data"] != null) {
          await Preferences.putString(
              Preferences.user_id, data['data']['id'].toString());
          await Preferences.putString(Preferences.user_first_name,
              data['data']['first_name'] ?? data['data']['username'] ?? "User");
          await Preferences.putString(
              Preferences.user_last_name, data['data']['last_name'] ?? "");
          await Preferences.putString(
              Preferences.login_email_id, data['data']['type'] ?? "");
          await Preferences.putString(
              Preferences.remember_token, data['data']['remember_token'] ?? "");
          await Preferences.putString(
              Preferences.user_type, data['data']['type'] ?? "");
          await Preferences.putString(
              Preferences.login_token, data['token'] ?? "");
        }
        debugPrint('${await Preferences.getString(Preferences.user_id)}');
        debugPrint(
            '${await Preferences.getString(Preferences.user_first_name)}');
        //Param to login
        final Map<String, String> param = {
          "token": await Preferences.getString(Preferences.login_token),
        };
        debugPrint('$param');
        emit(LoginSuccess(data: param));
        // Get.offAllNamed(Routes.DASHBOARD, parameters: param);
        Utilities.showToast(message: result["message"] ?? "Logged In");
      } else {
        Utilities.showToast(
            message: result["message"] ?? "Something went wrong!");
        emit(LoginFailure(result["message"]));
      }
    } catch (e) {
      Utilities.showToast(message: "Something went wrong!");

      print(e);
    }
  }
}
