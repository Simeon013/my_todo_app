import 'package:flutter/material.dart';
import 'package:my_todo_app/utils/app_colors.dart';
import 'package:my_todo_app/utils/app_dimensions.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to task view
      },
      child: AnimatedContainer(
        margin: EdgeInsets.symmetric(
          horizontal: AppDimensions.width(context) * 0.02,
          vertical: AppDimensions.height(context) * 0.007,
        ),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              offset: const Offset(0, 4),
              blurRadius: 10,
            )
          ]
        ),
        duration: const Duration(milliseconds: 600),
        child: ListTile(
      
          // Check Icon
          leading: GestureDetector(
            onTap: () {
              // Check or uncheck task
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey,
                  width: .8
                )
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ),
      
          // Task title
          title: Padding(
            padding: EdgeInsets.only(
              bottom: AppDimensions.height(context) * 0.005,
              top: AppDimensions.height(context) * 0.003,
            ),
            child: const Text(
              'Done',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                // decoration: TextDecoration.lineThrough
              ),
            ),
          ),
      
          // Task description
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Descriptions',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w300,
                  // decoration: TextDecoration.lineThrough
                ),
              ),
      
              // Date of the task
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: AppDimensions.height(context) * 0.001,
                    top: AppDimensions.height(context) * 0.001,
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '13:13',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey
                        ),
                      ),
                      Text(
                        '13/12/2024',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
