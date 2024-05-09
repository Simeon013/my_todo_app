import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_todo_app/utils/app_dimensions.dart';

class TaskAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TaskAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 150,
      child: Padding(
        padding: EdgeInsets.only(
          left: AppDimensions.width(context) * 0.03,
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.arrow_back_ios_new_outlined)
            ),
          ],
        ),
      ),
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(150); // Retourne la taille préférée
}
