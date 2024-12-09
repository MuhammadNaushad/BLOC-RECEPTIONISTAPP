import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class KeyModel {
  static final String boxName = 'key_value';

  @HiveField(0)
  String key;
  @HiveField(1)
  String value;

  KeyModel(this.key, this.value);
}
