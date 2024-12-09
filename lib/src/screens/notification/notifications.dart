import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yslcrm/src/common/widgets/appBar.dart';

import 'controllers/notifications_cntler.dart';

class NotificationScreen extends GetView<NotificationsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(viewType: 'Notifications'),
        body: SafeArea(child: Center(child: Text('No Notifications'))));
  }
}
