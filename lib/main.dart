import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_todo_app/views/home/home_view.dart';

Future<void> main() async{
  runApp(const MyApp());
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
            fontWeight: FontWeight.bold
          ),
          titleMedium: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w300
          ),
          displayMedium: TextStyle(
            color: Colors.white,
            fontSize: 21
          ),
          displaySmall: TextStyle(
            color: Color.fromARGB(255, 234, 234, 234),
            fontSize: 14,
            fontWeight: FontWeight.w400
          ),
          headlineMedium: TextStyle(
            color: Colors.grey,
            fontSize: 17
          ),
          headlineSmall: TextStyle(
            color: Colors.grey,
            fontSize: 16
          ),
          titleSmall: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500
          ),
          titleLarge: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w300,
            fontSize: 40
          )
        )
      ),
      home: const HomeView(),
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