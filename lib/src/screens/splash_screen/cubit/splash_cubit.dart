import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:yslcrm/src/fcm_services/fcm_services.dart';
import 'package:yslcrm/src/routes/app_pages.dart';
import 'package:yslcrm/src/utils/preferences.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());
  //Navigate User
  Future<void> navigateUser() async {
    await Future.delayed(Duration(seconds: 2));
    final String? token = await Preferences.getString(Preferences.login_token);
    bool isLogged = false;
    if (token != null && token.isNotEmpty) {
      isLogged = true;
    }
    if (isLogged) {
      LocalNotificationService.openSpeceficRouteWhenAppTerminated();
    } else {
      Get.offNamed(Routes.LOGIN);
    }
  }
}
