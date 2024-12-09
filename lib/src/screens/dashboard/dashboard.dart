import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/common/ui/common.dart';
import 'package:yslcrm/src/screens/dashboard/controllers/dashboard_cntler.dart';
import 'package:yslcrm/src/utils/alerts.dart';

import 'navigation_home_screen.dart';

class Dashboard extends GetView<DashboardController> with CommonWidget {
  const Dashboard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: WillPopScope(
            onWillPop: () async {
              return Alerts.exitWidget(Get.context!);
            },
            child: NavigationHomeScreen()));
  }
}
