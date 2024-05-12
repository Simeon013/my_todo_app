import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_todo_app/models/task.dart';

// All [CRUD] operations
class HiveDataStore {
  // Box Name - String
  static const boxName = 'taskBox';

  //  Our current box with all the saved data inside - Box<Task>
  final Box<Task> box = Hive.box<Task>(boxName);

  // Add new task to box
  Future<void> addTask(Task task) async {
    // await box.add(task);
    await box.put(task.id, task);
  }

  // Show task
  Future<Task?> getTask(String id) async {
    return box.get(id);
  }

  // Update task
  Future updateTask(Task task) async {
    // await box.put(task.id, task);
    await task.save();
  }

  // Delete task
  Future deleteTask(Task task) async {
    await task.delete();
  }

  // Listen for changes
  ValueListenable<Box<Task>> listenToTasks() => box.listenable();
}
