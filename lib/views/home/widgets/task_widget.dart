import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_todo_app/models/task.dart';
import 'package:my_todo_app/utils/app_colors.dart';
import 'package:my_todo_app/utils/app_dimensions.dart';
import 'package:my_todo_app/views/tasks/task_view.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({
    super.key,
    required this.task,
  });

  final Task task;

  // const TaskWidget({super.key, required this.task});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  TextEditingController textEditingControllerForTittle =
      TextEditingController();
  TextEditingController textEditingControllerForSubtitle =
      TextEditingController();

  @override
  void initState() {
    textEditingControllerForTittle.text = widget.task.title;
    textEditingControllerForSubtitle.text = widget.task.subtitle;
    super.initState();
  }

  @override
  void dispose() {
    textEditingControllerForTittle.dispose();
    textEditingControllerForSubtitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to task view
        Navigator.push(
          context,
          // MaterialPageRoute(
          //   builder: (context) => TaskView(
          //     titleController: textEditingControllerForTittle,
          //     descriptionController: textEditingControllerForSubtitle,
          //     task: widget.task,
          //   ),
          // ),
          CupertinoPageRoute(
            builder: (ctx) => TaskView(
              titleController: textEditingControllerForTittle, 
              descriptionController: textEditingControllerForSubtitle, 
              task: widget.task
            )
          )
        );
      },
      child: AnimatedContainer(
        margin: EdgeInsets.symmetric(
          horizontal: AppDimensions.width(context) * 0.03,
          vertical: AppDimensions.height(context) * 0.01,
        ),
        decoration: BoxDecoration(
            color: widget.task.isCompleted
                ? AppColors.primaryColor.withOpacity(0.5)
                : Colors.white,
            // color: const Color.fromARGB(154, 199, 144, 229),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.1),
                offset: const Offset(0, 4),
                blurRadius: 10,
              )
            ]),
        duration: const Duration(milliseconds: 600),
        child: Column(
          children: [
            ListTile(
              // Check Icon
              leading: GestureDetector(
                onTap: () {
                  // Check or uncheck task
                  widget.task.isCompleted = !widget.task.isCompleted;
                  widget.task.save();
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  decoration: BoxDecoration(
                      color: widget.task.isCompleted
                          ? AppColors.primaryColor
                          : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey, width: .8)),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
              ),

              // Task title
              title: Padding(
                padding: const EdgeInsets.only(
                    // bottom: 5,
                    // top: 3,
                    ),
                child: Text(
                  textEditingControllerForTittle.text,
                  style: TextStyle(
                    color: widget.task.isCompleted
                        ? AppColors.primaryColor
                        : Colors.black,
                    fontWeight: FontWeight.w500,
                    decoration: widget.task.isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
              ),

              // Task description
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    textEditingControllerForSubtitle.text,
                    style: TextStyle(
                      // color: Colors.grey,
                      color: widget.task.isCompleted
                          ? AppColors.primaryColor.withOpacity(0.5)
                          : Colors.grey,
                      fontWeight: FontWeight.w300,
                      decoration: widget.task.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),

                  // Date of the task
                ],
              ),
            ),

            // Date of the task
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: AppDimensions.height(context) * 0.005,
                  // top: AppDimensions.height(context) * 0.001,
                  right: AppDimensions.width(context) * 0.03,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      // Time for createdTime
                      DateFormat.Hm().format(DateTime(
                          2022,
                          1,
                          1,
                          widget.task.createdAtTime.hour,
                          widget.task.createdAtTime.minute)),
                      // '${widget.task.createdAtDate.hour.toString().padLeft(2, '0')}:${widget.task.createdAtDate.minute.toString().padLeft(2, '0')}',
                      style: TextStyle(
                        fontSize: 10,
                        color: widget.task.isCompleted
                            ? Colors.white
                            : Colors.grey,
                      ),
                    ),
                    Text(
                      DateFormat('dd MMM').format(widget.task.createdAtDate),
                      style: TextStyle(
                        fontSize: 12,
                        color: widget.task.isCompleted
                            ? Colors.white
                            : Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
