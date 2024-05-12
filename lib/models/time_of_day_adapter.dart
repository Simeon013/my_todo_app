import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

class TimeOfDayAdapter extends TypeAdapter<TimeOfDay> {
  @override
  final typeId = 1; // Unique ID for this type in Hive

  @override
  TimeOfDay read(BinaryReader reader) {
    // Read the hour and minute from binary and create a TimeOfDay object
    final hour = reader.readInt();
    final minute = reader.readInt();
    return TimeOfDay(hour: hour, minute: minute);
  }

  @override
  void write(BinaryWriter writer, TimeOfDay obj) {
    // Write the hour and minute of the TimeOfDay object to binary
    writer.writeInt(obj.hour);
    writer.writeInt(obj.minute);
  }
}
