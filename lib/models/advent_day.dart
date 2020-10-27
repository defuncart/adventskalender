import 'package:adventskalender/configs/hive_adapter_type.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

@HiveType(typeId: HiveAdapterType.adventDay)
class AdventDay {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final String value1;

  @HiveField(3)
  final String value2;

  const AdventDay({
    @required this.title,
    @required this.description,
    this.value1,
    this.value2,
  });

  @override
  String toString() => '{title $title, description: $description, value1: $value1, value2: $value2}';
}

class AdventDayAdapter extends TypeAdapter<AdventDay> {
  @override
  final typeId = 0;

  @override
  AdventDay read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdventDay(
      title: fields[0] as String,
      description: fields[1] as String,
      value1: fields[2] as String,
      value2: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AdventDay obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.value1)
      ..writeByte(3)
      ..write(obj.value2);
  }
}
