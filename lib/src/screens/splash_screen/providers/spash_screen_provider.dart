import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../../fcm_services/fcm_services.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/preferences.dart';

final splashScreenProvider = StateNotifierProvider((ref) {
  return SplashScreenNotifier(dynamic);
});

class SplashScreenNotifier extends StateNotifier {
  SplashScreenNotifier(super.state) {
    print(state.toString());
    onInit();
  }

  final label = 'Fleet On Street';
  void onInit() async {
    // Get.put(FCMController(), permanent: true);
    await navigateUser();
  }

  //Navigate User
  static Future<void> navigateUser() async {
    await Future.delayed(Duration(seconds: 2));
    final String? token = await Preferences.getString(Preferences.login_token);
    bool isLogged = false;
    if (token != null && token.isNotEmpty) {
      isLogged = true;
    }
    if (!isLogged) {
      LocalNotificationService.openSpeceficRouteWhenAppTerminated();
    } else {
      Get.offNamed(Routes.LOGIN);
    }
  }
}
