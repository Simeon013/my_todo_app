import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_todo_app/utils/app_colors.dart';
import 'package:my_todo_app/views/tasks/task_view.dart';

class fab extends StatelessWidget {
  const fab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        print('Task view');
        // Navigate to task view
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => const TaskView(
            titleController: null,
            descriptionController: null,
            task: null
          )),
        );
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
