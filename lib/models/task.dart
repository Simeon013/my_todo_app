import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  Task({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.createdAtTime,
    required this.createdAtDate,
    required this.isCompleted,
    // required this.isCompleted,
  });

  @HiveField(0) // Unique ID
  final String id;
  @HiveField(1) // Title
  String title;
  @HiveField(2) // Subtitle
  String subtitle;
  @HiveField(3) // Created At Time
  TimeOfDay createdAtTime;
  @HiveField(4) // Created At Date
  DateTime createdAtDate;
  @HiveField(5) // Is Completed
  bool isCompleted;

  // Create a new task
  factory Task.create({
    required String? title,
    required String? subtitle,
    TimeOfDay? createdAtTime,
    DateTime? createdAtDate,
  }) {
    return Task(
      id: const Uuid().v1(),
      title: title ?? '',
      subtitle: subtitle ?? '',
      createdAtTime: createdAtTime ?? TimeOfDay.now(),
      createdAtDate: createdAtDate ?? DateTime.now(),
      isCompleted: false,
    );
  }

}
