// ignore_for_file: non_constant_identifier_names

import 'package:hive/hive.dart';
import 'package:yslcrm/src/database/key_model.dart';
import 'package:yslcrm/src/database/key_repository.dart';

class Preferences {
  static String login_token = "token";
  static String remember_token = "token";
  static String user_object = "user_object";
  static String fcm_token = "fcm_token";
  static String user_id = "fos_user_id";
  static String user_type = "fos_user_type";
  static String vendor_id = "vendor_id";
  static String defaultCurrency = "defaultCurrency";
  static String user_full_name = "user_full_name";
  static String user_first_name = "user_first_name";
  static String user_last_name = "user_last_name";
  static String login_email_id = "email_id";
  static String login_mobile_no = "mobile_no";
  static String login_avtar = "avtar";
  static String login_address = "address";
  static String login_city = "city";
  static String login_pincode = "pincode";
  static String login_type = "login_type";
  //
  static String productId = "productId";
  static String cartCount = "cartCount";
  static String notifyCount = "notifyCount";
  //
  static String isDoubleUpcomingVisit = 'isDoubleUpcomingVisit';
  static String isNotifyToAddVisit = 'isNotifyToAddVisit';
  static String didLaunchByNotification = 'didLaunchByNotification';
  static String notificationType = "notification_type";

  static Future<String> getString(String key) async {
    var val = await KeyModelRepository().get(key);
    if (val != null) {
      return ((val.value));
    }
    return "";
  }

  static putString(String key, String value) async {
    KeyModelRepository().set(KeyModel(key, value));
  }

  static Future<bool> getBool(String key) async {
    var val = await KeyModelRepository().get(key);
    if (val != null) {
      return ((val.value) == "1" ? true : false);
    }
    return false;
  }

  static putBool(String key, bool value) async {
    String converted = "0";
    if (value) {
      converted = "1";
    }
    KeyModelRepository().set(KeyModel(key, converted));
  }

//list
  static putList(String key, List value) async {
    var box = await Hive.openBox('ListBox');
    box.put(key, value);
  }

  static Future<List> getList(String key) async {
    var box = await Hive.openBox('ListBox');
    return box.get(key);
  }

  //map
  static putMap(String key, Map value) async {
    var box = await Hive.openBox('MapBox');
    box.put(key, value);
  }

  static Future<Map> getMap(String key) async {
    var box = await Hive.openBox('MapBox');
    return box.get(key);
  }

  //Object
  static putObject(String key, Object value) async {
    var box = await Hive.openBox('ObjectsBox');
    box.put(key, value);
  }

  static Future<Object> getObject(String key) async {
    var box = await Hive.openBox('ObjectsBox');
    return box.get(key);
  }
}
