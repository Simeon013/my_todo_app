import 'package:flutter/material.dart';
import 'package:my_todo_app/extensions/space_exs.dart';
import 'package:my_todo_app/utils/app_colors.dart';
import 'package:my_todo_app/utils/app_dimensions.dart';
import 'package:my_todo_app/views/home/widgets/fab.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // Body
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: AppDimensions.height(context) * 0.05),
              width: double.infinity,
              height: 100,
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  // Progress indicator
                  SizedBox(
                    width: 30,
                    height: 30 ,
                    child: CircularProgressIndicator(
                      value: 1/3,
                      backgroundColor: Colors.grey,
                      valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
                    ),
                  ),
                  25.w,
                ]
              ),
            )
          ]
        ),
      ),

      //FAB
      floatingActionButton: const fab());
  }
}

