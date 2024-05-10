import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_todo_app/extensions/space_exs.dart';
import 'package:my_todo_app/utils/app_colors.dart';
import 'package:my_todo_app/utils/app_dimensions.dart';
import 'package:my_todo_app/utils/app_str.dart';
import 'package:my_todo_app/utils/constants.dart';
import 'package:my_todo_app/views/tasks/components/datetime_selection.dart';
import 'package:my_todo_app/views/tasks/components/rep_textfield.dart';
import 'package:my_todo_app/views/tasks/widgets/app_bar.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        // AppBar
        appBar: const TaskAppBar(),

        // Body
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Top side texts
                _buildTopSideTexts(textTheme),

                // Main task view
                _buildMainTaskView(context, textTheme),

                // Bottom side buttons
                _buildBottomSideButtons(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Top side texts
  Widget _buildTopSideTexts(TextTheme textTheme) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 100,
              child: Divider(
                thickness: 2,
              ),
            ),

            //
            RichText(
                text: TextSpan(
                    text: AppStr.addNewTask,
                    style: textTheme.titleLarge,
                    children: const [
                  TextSpan(
                      text: AppStr.taskString,
                      style: TextStyle(fontWeight: FontWeight.w400))
                ])),

            const SizedBox(
              width: 100,
              child: Divider(
                thickness: 2,
              ),
            ),
          ]),
    );
  }

  // Main task view
  Widget _buildMainTaskView(BuildContext context, TextTheme textTheme) {
    return SizedBox(
      width: double.infinity,
      height: 530,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Padding(
            padding: EdgeInsets.only(
              left: AppDimensions.width(context) * 0.1,
            ),
            child: Text(
              AppStr.titleOfTitleTextField,
              style: textTheme.headlineMedium,
            ),
          ),

          // Task title
          RepTextField(controller: titleController),

          10.h,

          RepTextField(
              controller: descriptionController, isForDescription: true),

          // Time Selection
          DateTimeSelection(
            title: AppStr.date,
            onTap: () {
              showDatePicker(
                context: context,
                initialEntryMode: DatePickerEntryMode.input,
                firstDate: DateTime(2000, 1, 1),
                lastDate: DateTime(2100, 1, 1),
              );
            },
          ),

          DateTimeSelection(
            title: AppStr.time,
            onTap: () {
              showTimePicker(
                context: context,
                initialEntryMode: TimePickerEntryMode.input,
                initialTime: const TimeOfDay(hour: 00, minute: 00),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildBottomSideButtons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: AppDimensions.height(context) * 0.01,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Delete current task button
          MaterialButton(
            onPressed: () {},
            minWidth: 150,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            height: AppDimensions.height(context) * 0.06,
            child: Row(
              children: [
                const Icon(
                  Icons.close,
                  color: AppColors.primaryColor,
                ),
                5.w,
                const Text(
                  AppStr.deleteCurrentTask,
                  style: TextStyle(color: AppColors.primaryColor),
                ),
              ],
            ),
          ),

          // Save or update current task button
          MaterialButton(
            onPressed: () {
              // Save or update current task
              // emptyWarning(context);
              updateWarning(context);
            },
            minWidth: 150,
            color: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            height: AppDimensions.height(context) * 0.06,
            child: const Text(
              AppStr.addTaskString,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
