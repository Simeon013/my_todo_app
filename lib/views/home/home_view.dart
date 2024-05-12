import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:my_todo_app/extensions/space_exs.dart';
import 'package:my_todo_app/main.dart';
import 'package:my_todo_app/models/task.dart';
import 'package:my_todo_app/utils/app_colors.dart';
import 'package:my_todo_app/utils/app_dimensions.dart';
import 'package:my_todo_app/utils/app_str.dart';
import 'package:my_todo_app/utils/constants.dart';
import 'package:my_todo_app/views/home/components/app_bar.dart';
import 'package:my_todo_app/views/home/components/fab.dart';
import 'package:my_todo_app/views/home/components/slider_drawer.dart';
import 'package:my_todo_app/views/home/widgets/task_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  GlobalKey<SliderDrawerState> drawerKey = GlobalKey<SliderDrawerState>();

  // Check value circle indiactor
  dynamic valueOfIndicator(List<Task> task) {
    if (task.isNotEmpty) {
      return task.length;
    } else {
      return 3;
    }
  }

  // Check done tasks
  int doneTasks(List<Task> tasks) {
    int i = 0;
    for (Task doneTask in tasks) {
      if (doneTask.isCompleted) {
        i++;
      }
    }
    return i;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    final base = BaseWidget.of(context);

    return ValueListenableBuilder(
        valueListenable: base.dataStore.listenToTasks(),
        builder: (ctx, Box<Task> box, Widget? child) {
          var tasks = box.values.toList();

          tasks.sort((a, b) => a.createdAtDate.compareTo(b.createdAtDate));
          return Scaffold(
              backgroundColor: Colors.white,

              // Body
              // body: _buildHomeBody(context, textTheme),
              body: SliderDrawer(
                key: drawerKey,
                isDraggable: false,
                animationDuration: 1000,

                // Drawer
                slider: CustomDrawer(),

                appBar: HomeAppBar(
                  drawerKey: drawerKey,
                ),

                // Main Body
                child: _buildHomeBody(context, textTheme, base, tasks),
              ),

              //FAB
              floatingActionButton: const fab());
        });
  }

  // Home Body
  Widget _buildHomeBody(BuildContext context, TextTheme textTheme,
      BaseWidget base, List<Task> tasks) {
    return SizedBox(
      width: double.infinity,
      height: AppDimensions.height(context),
      child: Column(children: [
        // Custom app bar
        Container(
          margin: EdgeInsets.only(top: AppDimensions.height(context) * 0.05),
          width: double.infinity,
          height: 100,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            // Progress indicator
            SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(
                value: doneTasks(tasks) / valueOfIndicator(tasks),
                backgroundColor: Colors.grey,
                valueColor: const AlwaysStoppedAnimation(AppColors.primaryColor),
              ),
            ),

            // Space
            25.w,

            // Top level Task info
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStr.mainTitle,
                  style: textTheme.displayLarge,
                ),
                3.h,
                Text(
                  '${doneTasks(tasks)} / ${valueOfIndicator(tasks)} tasks éffectuées',
                  style: textTheme.titleMedium,
                )
              ],
            )
          ]),
        ),

        // Divider
        Padding(
          padding: EdgeInsets.only(top: AppDimensions.height(context) * 0.02),
          child: const Divider(
            thickness: 2,
            indent: 100,
          ),
        ),

        // Task list
        Expanded(
            // width: double.infinity,
            // height: AppDimensions.height(context) * 0.7155,
            child: tasks.isNotEmpty

                // List of tasks
                ? ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      var task = tasks[index];
                      return Dismissible(
                          direction: DismissDirection.horizontal,
                          onDismissed: (_) {
                            // remove task from DB
                            base.dataStore.deleteTask(task);
                          },
                          background: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.delete_outline,
                                color: Colors.grey,
                              ),
                              8.w,
                              const Text(
                                AppStr.deletedTask,
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          key: Key(
                            task.id,
                          ),
                          child: TaskWidget(
                            task: task,
                          ));
                    })

                // Empty list
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeIn(
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Lottie.asset(
                            lottieURL,
                            animate: tasks.isNotEmpty ? false : true,
                            repeat: tasks.isNotEmpty ? true : false,
                            // width: AppDimensions.width(context) * 0.5,
                          ),
                        ),
                      ),
                      FadeInUp(
                        from: 30,
                        child: const Text(
                          AppStr.doneAllTask,
                        ),
                      )
                    ],
                  ))
      ]),
    );
  }
}
