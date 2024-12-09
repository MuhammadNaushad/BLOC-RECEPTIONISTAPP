import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yslcrm/src/utils/preferences.dart';

class LifeCycleController extends SuperController {
  String? notificationTypeId;
  LifeCycleController({this.notificationTypeId}) {
    valueAssing(notifyId: notificationTypeId);
  }

  void valueAssing({notifyId = ""}) async {
    print(Preferences.putString(Preferences.notificationType, notifyId));
    notificationTypeId =
        await Preferences.getString(Preferences.notificationType);
    print(notificationTypeId);
  }

  @override
  void onDetached() {
    print("onDetached");
  }

  @override
  void onInactive() {
    print("onInactive");
  }

  @override
  void onPaused() {
    print("onPaused");
  }

  @override
  void onResumed() async {
    print("onResumed");
    notificationTypeId =
        await Preferences.getString(Preferences.notificationType);
    print(notificationTypeId);
  }

  @override
  void onHidden() {
    // TODO: implement onHidden
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //MyClass("a");
  try {
    Util.utils();
    var sp = await Util.utils();
    final ob = User("Naushad", "28");
    final map = {"name": "nasu"};
    final encodedObj = jsonEncode(ob);
    sp.setString("model", encodedObj);
    debugPrint(
        User.fromJson(jsonDecode(sp.getString("model")!)).name.toString());

    /* debugPrint(sp.getString("model"));
    final decoded = sp.getString("model");

    final decodedObj = jsonDecode(decoded!); */
    /* await initializeHive();
    await Preferences.putObject("a", ob);
    User ab = await Preferences.getObject("a") as User;
    debugPrint(ab.name.toString()); */
  } catch (e) {
    print(e);
  }
}

class MyClass {
  String? base = "value";
  MyClass() {
    print("contructor $base");
    base = "changed value";
  }
  /*  factory MyClass.a(base) {
    print("My $base");
    return MyClass(base);
  } */

  static void just() {
    print("static method is called");
  }
}

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? age;
  User(this.name, this.age);
  Map toJson() => {"name": name, "age": age};
  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    age = json['age'];
  }
}

class Util {
  static var _instance;
  Util() {
    utils();
  }
  static Future<SharedPreferences> utils() async {
    _instance = await SharedPreferences.getInstance();
    return _instance!;
  }
}

class Prefs {
  static SharedPreferences? _prefs;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs!;
  }

  //sets
  static Future<bool> setBool(String key, bool value) async =>
      await _prefs!.setBool(key, value);

  static Future<bool> setDouble(String key, double value) async =>
      await _prefs!.setDouble(key, value);

  static Future<bool> setInt(String key, int value) async =>
      await _prefs!.setInt(key, value);

  static Future<bool> setString(String key, String value) async =>
      await _prefs!.setString(key, value);

  static Future<bool> setStringList(String key, List<String> value) async =>
      await _prefs!.setStringList(key, value);

  //gets
  static bool getBool(String key) => _prefs!.getBool(key)!;

  static double getDouble(String key) => _prefs!.getDouble(key)!;

  static int getInt(String key) => _prefs!.getInt(key)!;

  static String getString(String key) => _prefs!.getString(key)!;

  static List<String> getStringList(String key) => _prefs!.getStringList(key)!;

  //deletes..
  static Future<bool> remove(String key) async => await _prefs!.remove(key);

  static Future<bool> clear() async => await _prefs!.clear();
}

/* mixin Mobile {
  String? str;
}

class Redmi with Mobile, Realme {
  @override
  String? str;

  @override
  String? strs;

  /* final realmeObj = Realme();
  final mobileObj = Mobile(); */
}

abstract class Realme {
  String? strs;
  //Realme();
} */
