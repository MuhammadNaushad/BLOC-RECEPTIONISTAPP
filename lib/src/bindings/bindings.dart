import 'package:get/get.dart';
import 'package:yslcrm/src/screens/login_&_register/controllers/login_cntler.dart';

class AllControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    //Get.lazyPut<GetXNetworkManager>(() => GetXNetworkManager());
  }
}
