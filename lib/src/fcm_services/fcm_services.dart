import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yslcrm/src/routes/app_pages.dart';
import 'package:yslcrm/src/utils/preferences.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static var notificationType = '';

  static void initialize() async {
    //----------------------------------------------------------------------//
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description:
            'This channel is used for important notifications.', // description
        importance: Importance.max,
        enableLights: true,
        playSound: true);

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    //----------------------------------------------------------------------//
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));

    _notificationsPlugin.initialize(initializationSettings,
        onDidReceiveBackgroundNotificationResponse: (route) async {
      Preferences.putBool(Preferences.isNotifyToAddVisit, true);
      //checking session
      final String? token =
          await Preferences.getString(Preferences.login_token);
      bool isLogged = false;
      /* if (token != null && token.isNotEmpty) {
        isLogged = true;
      }
      if (isLogged) {
        //-----Logic for notification type---//
        var ntf = "";
        final prefs = await SharedPreferences.getInstance();
        if (prefs.getString(Preferences.notificationType) != null) {
          ntf = prefs.getString(Preferences.notificationType)!;
          debugPrint(ntf);
        }

        //-------------Checking Ntotification Type------//
        if (await Preferences.getString(Preferences.fos_user_type) == '1') {
          if (notificationType == '5' ||
              notificationType == '9' ||
              notificationType == '22' ||
              notificationType == '3' ||
              ntf == '22' ||
              ntf == '5' ||
              ntf == '3' ||
              ntf == '9') {
            Alerts.showDeletImgDialog(
                onYes: () async {
                  Get.back();
                  await Utilities.logOut();
                },
                title: 'Alert',
                contenTStr: 'To see FOS notification first you have to logout');
          } else {
            Get.offAllNamed(Routes.NOTIFICATIONS_S);
          }
        } else {
          if (notificationType == '4' ||
              notificationType == '7' ||
              notificationType == '10' ||
              notificationType == '12' ||
              notificationType == '23' ||
              notificationType == '24' ||
              ntf == '12' ||
              ntf == '4' ||
              ntf == '7' ||
              ntf == '23' ||
              ntf == '24' ||
              ntf == '10') {
            Alerts.showDeletImgDialog(
                onYes: () async {
                  Get.back();
                  await Utilities.logOut();
                },
                title: 'Alert',
                contenTStr:
                    'To see supervisor notification first you have to logout');
          } else {
            Get.offAllNamed(Routes.NOTIFICATIONS);
          }
        }

        if (route != null) {
          print(route);
        }
      } else {
        Get.offNamed(Routes.LOGIN);
      } */
    });
  }

  static Future<void> openSpeceficRouteWhenAppTerminated() async {
    final response =
        await _notificationsPlugin.getNotificationAppLaunchDetails();
    if (response != null) {
      if (response.didNotificationLaunchApp) {
        Get.offAllNamed(Routes.NOTIFICATIONS);
      } else {
        Get.offAllNamed(Routes.DASHBOARD);
      }
    }
  }

  static void display(RemoteMessage message) async {
    try {
      if (message.data['notification_type'] != null) {
        notificationType = message.data['notification_type'].toString();
      }
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        channelDescription:
            'This channel is used for important notifications.', // description
        //color: Color(0xffffff00),
        importance: Importance.max,
        playSound: true,
        enableLights: true,
        priority: Priority.max,
      ));

      if (message.data['notification_type'] != null) {
        await _notificationsPlugin.show(
          int.parse(message.data['notification_type'] ?? id.toString()),
          message.data['notification_tittle'] != null
              ? message.data['notification_tittle']
              : message.data['notification_title'] ?? "Notification Title",
          message.data['notification_description'] != null
              ? message.data['notification_description']
              : "Notification body",
          notificationDetails,
          payload: Routes.NOTIFICATIONS,
        );
      } else {
        await _notificationsPlugin.show(
          int.parse(id.toString()),
          message.notification!.title ?? '',
          message.notification!.body ?? "",
          notificationDetails,
          payload: Routes.NOTIFICATIONS,
        );
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}
