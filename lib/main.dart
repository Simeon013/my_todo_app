import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:my_todo_app/data/hive_data_store.dart';
import 'package:my_todo_app/models/task.dart';
import 'package:my_todo_app/views/home/home_view.dart';

Future<void> main() async {
  // Initiative DB before run app
  await Hive.initFlutter();

  // Enregistrez votre adaptateur TimeOfDayAdapter ici
  Hive.registerAdapter(TimeOfDayAdapter());

  // Register adapter
  Hive.registerAdapter<Task>(TaskAdapter());

  // Open box
  Box box = await Hive.openBox<Task>(HiveDataStore.boxName);

  // Delete data from previous day
  final now = DateTime.now();
  for (var task in box.values) {
    if (task.createdAtDate.difference(now).inDays != 0) {
      task.delete();
    } else {
      // Do nothing
    }
  }


  runApp(BaseWidget(child: const MyApp()));
}

class BaseWidget extends InheritedWidget {
  BaseWidget({super.key, required this.child}) : super(child: child);
  // BaseWidget(this.child, {super.key, required this.child}) : super(key: key, child: child);

  final HiveDataStore dataStore = HiveDataStore();
  final Widget child;

  static BaseWidget of(BuildContext context) {
    // return context.dependOnInheritedWidgetOfExactType<BaseWidget>()!;
    final base = context.dependOnInheritedWidgetOfExactType<BaseWidget>();
    if (base != null) {
      return base;
    } else {
      throw StateError('No BaseWidget found in context');
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Todo App',
      theme: ThemeData(
          textTheme: const TextTheme(
              displayLarge: TextStyle(
                  color: Colors.black,
                  fontSize: 45,
                  fontWeight: FontWeight.bold),
              titleMedium: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w300),
              displayMedium: TextStyle(color: Colors.white, fontSize: 21),
              displaySmall: TextStyle(
                  color: Color.fromARGB(255, 234, 234, 234),
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
              headlineMedium: TextStyle(color: Colors.grey, fontSize: 17),
              headlineSmall: TextStyle(color: Colors.grey, fontSize: 16),
              titleSmall:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
              titleLarge: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 40))),
      home: const HomeView(),
      // home: const TaskView(),
    );
  }
}

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
