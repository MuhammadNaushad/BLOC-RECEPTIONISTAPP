import 'package:hive/hive.dart';

import 'key_model.dart';

class KeyModelAdapter extends TypeAdapter<KeyModel> {
  @override
  final typeId = 1;

  @override
  KeyModel read(BinaryReader reader) {
    var numOffFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOffFields; i++) reader.readByte(): reader.read(),
    };
    return KeyModel(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, KeyModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KeyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
