import 'package:hive/hive.dart';

import 'key_model.dart';

class KeyModelRepository {
  Future<KeyModel?> get(String key) async {
    // ignore: non_constant_identifier_names
    Box<KeyModel> KeyBox = Hive.box<KeyModel>(KeyModel.boxName);
    if (!KeyBox.isOpen) {
      KeyBox = await Hive.openBox(KeyModel.boxName);
      if (!KeyBox.isOpen) {
        throw Exception("${KeyModel.boxName} box is not open");
      }
    }
    return KeyBox.get(key, defaultValue: null);
  }

  Future<void> set(KeyModel user) async {
    // ignore: non_constant_identifier_names
    Box<KeyModel> KeyBox = Hive.box<KeyModel>(KeyModel.boxName);
    if (!KeyBox.isOpen) {
      KeyBox = await Hive.openBox(KeyModel.boxName);
      if (!KeyBox.isOpen) {
        throw Exception("${KeyModel.boxName} box is not open");
      }
    }
    await KeyBox.put(user.key, user);
  }

  /*Future<KeyModel> get(String key) async {
    Box<KeyModel> keyBox = await Hive.openBox(KeyModel.boxName);
    KeyModel keyM = keyBox.get(key, defaultValue: null);
    keyBox.close();
    return keyM;
  }

  Future<void> set(KeyModel user) async {
    Box<KeyModel> keyBox = await Hive.openBox(KeyModel.boxName);
    await keyBox.put(user.key, user);
    keyBox.close();
  }*/
}
