import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:yslcrm/src/routes/app_pages.dart';
import 'package:yslcrm/src/utils/alerts.dart';
import 'package:yslcrm/src/utils/preferences.dart';
import 'package:yslcrm/src/utils/utilities.dart';

import 'fcm_services.dart';

class FCMController extends GetxController {
  @override
  void onInit() async {
    await Firebase.initializeApp();
    await firebaseNotificationMethod();
    super.onInit();
  }

  static Future<void> firebaseNotificationMethod() async {
    try {
      //-----------------Local Notification--------------------------------------------//
      LocalNotificationService.initialize();
      //------------setForegroundNotificationPresentationOption-----------------------//
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      //------------get token--------------------------------------------------//
      FirebaseMessaging.instance.getToken().then((String? token) {
        Preferences.putString(Preferences.fcm_token, token ?? '');
        debugPrint('FCM Token: $token');
      });
      //------------Get Initial Message--------------------------------------------------//
      FirebaseMessaging.instance.getInitialMessage().then((message) async {
        if (message != null) {
          debugPrint('message: $message');
        }
      });
      //---------------------OnMessage--------------------------------------------------//
      FirebaseMessaging.onMessage.listen((message) async {
        debugPrint('message: $message');
        if (message.data['notification_tittle'] != null) {
          debugPrint('notification_type: ${message.data['notification_type']}');
          debugPrint(
              'notification_tittle: ${message.data['notification_tittle']}');
          debugPrint(
              'notification_description: ${message.data['notification_description']}');
        }
        if (message.data['notification_type'] != null) {
          LocalNotificationService.notificationType =
              message.data['notification_type'].toString();
        }
        LocalNotificationService.display(message);
        //sendNotification();
      });
      //-------------------------onMessageOpenedApp----------------------------------------------//
      FirebaseMessaging.onMessageOpenedApp.listen((message) async {
        if (await Preferences.getString(Preferences.user_type) == '1') {
          if (LocalNotificationService.notificationType == '5' ||
              LocalNotificationService.notificationType == '9' ||
              LocalNotificationService.notificationType == '22') {
            Alerts.showDeletImgDialog(
                onYes: () async {
                  Get.back();
                  await Utilities.logOut();
                },
                title: 'Alert',
                contenTStr: 'To see FOS notification you have to logout!');
          } else {
            // Get.toNamed(Routes.NOTIFICATIONS_S);
          }
        } else {
          if (LocalNotificationService.notificationType == '4' ||
              LocalNotificationService.notificationType == '7' ||
              LocalNotificationService.notificationType == '10' ||
              LocalNotificationService.notificationType == '12' ||
              LocalNotificationService.notificationType == '23' ||
              LocalNotificationService.notificationType == '24') {
            Alerts.showDeletImgDialog(
                onYes: () async {
                  Get.back();
                  await Utilities.logOut();
                },
                title: 'Alert',
                contenTStr:
                    'To see supervisor notification you have to logout!');
          } else {
            Get.toNamed(Routes.NOTIFICATIONS);
          }
        }
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  //----------------------------backgroundHandler-------------------------------------------//
  Future<void> backgroundHandler(RemoteMessage message) async {
    /*  print(message.data.toString());
        LocalNotificationService.display(message);
    print(message.notification!.title); */
  }

  ///-------------------------------------------------------------------------------///
  ///                       Awesome Notification
  ///------------------------------------------------------------------------------///
/* 
  static void sendNotification() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 1,
          channelKey: 'test_channel',
          title: 'Title of the notification.',
          body: 'Hello! This is the body of the notification.'),
    );

    AwesomeNotifications().actionStream.listen((event) {
      //Get.to(const Home());
    });
  } */

  @override
  void onClose() {
    super.onClose();
  }
}
