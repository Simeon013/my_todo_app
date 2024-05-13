import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_todo_app/extensions/space_exs.dart';
import 'package:my_todo_app/main.dart';
import 'package:my_todo_app/models/task.dart';
import 'package:my_todo_app/utils/app_colors.dart';
import 'package:my_todo_app/utils/app_dimensions.dart';
import 'package:my_todo_app/utils/app_str.dart';
import 'package:my_todo_app/utils/constants.dart';
import 'package:my_todo_app/views/tasks/components/datetime_selection.dart';
import 'package:my_todo_app/views/tasks/components/rep_textfield.dart';
import 'package:my_todo_app/views/tasks/widgets/app_bar.dart';

class TaskView extends StatefulWidget {
  const TaskView(
      {super.key,
      required this.titleController,
      required this.descriptionController,
      required this.task});

  final TextEditingController? titleController;
  final TextEditingController? descriptionController;
  final Task? task;

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  var title;
  var subtitle;
  // DateTime? date;
  // DateTime? time;

  DateTime? selectedDate;

  void _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendar,
      firstDate: DateTime(2000, 1, 1),
      lastDate: DateTime(2099, 10, 31),
      initialDate: widget.task?.createdAtDate == null
          ? DateTime.now()
          : widget.task!.createdAtDate,
    );

    if (pickedDate != null) {
      setState(() {
        if (widget.task?.createdAtDate == null) {
          selectedDate = pickedDate;
        } else {
          selectedDate = widget.task?.createdAtDate;
          // widget.task!.createdAtDate = pickedDate;
        }
      });

      // Faire quelque chose avec la date sélectionnée
      // print('Date sélectionnée : $selectedDate');
    }
  }

  // Formater la date sélectionnée
  String formattedDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  TimeOfDay? selectedTime;

  void _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.dial,
      initialTime: widget.task?.createdAtTime == null
          ? TimeOfDay.now()
          : widget.task!.createdAtTime,
    );

    if (pickedTime != null) {
      setState(() {
        if (widget.task?.createdAtTime == null) {
          selectedTime = pickedTime;
        } else {
          selectedTime = widget.task?.createdAtTime;
          // widget.task!.createdAtTime = pickedTime;
        }
      });

      // Faire quelque chose avec l'heure sélectionnée
      if (kDebugMode) {
        print('Heure sélectionnée : $selectedTime');
      }
    }
  }

  // Formater l'heure sélectionnée
  String formattedTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  bool isTaskAlreayExist() {
    if (widget.titleController?.text == null &&
        widget.descriptionController == null) {
      return false;
    } else {
      return true;
    }
  }

  // Main function to create or update task
  dynamic submitTask() {
    // Here we update
    if (widget.titleController?.text != null &&
        widget.descriptionController?.text != null) {
      try {
        title = widget.task!.title;
        subtitle = widget.task!.subtitle;
        // widget.titleController!.text = title;
        // widget.descriptionController!.text = subtitle;


        widget.task?.save();

        Navigator.pop(context);
      } catch (e) {
        updateWarning(context);
      }
    }

    // Here we create new task
    else {
      if (title != null && subtitle != null) {
        var task = Task.create(
            title: title,
            subtitle: subtitle,
            createdAtDate: selectedDate,
            createdAtTime: selectedTime);

        // we are adding task to database
        BaseWidget.of(context).dataStore.addTask(task);

        Navigator.pop(context);
      } else {
        // Warning
        emptyWarning(context);
      }
    }
  }

  dynamic deleteTask() {
    return widget.task?.delete();
  }

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
              width: 80,
              child: Divider(
                thickness: 2,
              ),
            ),

            //
            RichText(
                text: TextSpan(
                    text: isTaskAlreayExist()
                        ? AppStr.updateCurrentTask
                        : AppStr.addNewTask,
                    style: textTheme.titleLarge,
                    children: const [
                  TextSpan(
                      text: AppStr.taskString,
                      style: TextStyle(fontWeight: FontWeight.w400))
                ])),

            const SizedBox(
              width: 80,
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
          RepTextField(
            controller: widget.titleController,
            onChanged: (String inputTitle) {
              title = inputTitle;
            },
            onFieldSubmiited: (String inputTitle) {
              title = inputTitle;
            },
          ),

          10.h,

          RepTextField(
            controller: widget.descriptionController,
            isForDescription: true,
            onChanged: (String inputSubtitle) {
              subtitle = inputSubtitle;
            },
            onFieldSubmiited: (String inputSubtitle) {
              subtitle = inputSubtitle;
            },
          ),

          // Date Selection
          DateTimeSelection(
            title: AppStr.date,
            onTap: () {
              _selectDate(context);
            },
            time: selectedDate != null
                ? formattedDate(selectedDate!)
                : formattedDate(widget.task?.createdAtDate == null
                    ? DateTime.now()
                    : widget.task!.createdAtDate),
          ),

          // Time Selection
          DateTimeSelection(
            title: AppStr.time,
            onTap: () {
              _selectTime(context);
            },
            time: selectedTime != null
                ? formattedTime(selectedTime!)
                : formattedTime(widget.task?.createdAtTime == null
                    ? TimeOfDay.now()
                    : widget.task!.createdAtTime),
            isTime: true,
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
        mainAxisAlignment: isTaskAlreayExist()
            ? MainAxisAlignment.spaceEvenly
            : MainAxisAlignment.center,
        children: [
          !isTaskAlreayExist()
              ? Container()
              // Delete current task button
              : MaterialButton(
                  onPressed: () {
                    // Delete current task logic
                    deleteTask();
                    Navigator.pop(context);
                  },
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
              // Save or update task
              submitTask();
            },
            minWidth: 150,
            color: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            height: AppDimensions.height(context) * 0.06,
            child: Text(
              isTaskAlreayExist()
                  ? AppStr.updateTaskString
                  : AppStr.addTaskString,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
