import 'package:flutter/material.dart';
import 'package:my_todo_app/utils/app_colors.dart';

class fab extends StatelessWidget {
  const fab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        print('Task view');
      },
      elevation: 10,
      child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Center(
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
          )),
    );
  }
}
