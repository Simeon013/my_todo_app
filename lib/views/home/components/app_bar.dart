import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:my_todo_app/main.dart';
import 'package:my_todo_app/utils/app_dimensions.dart';
import 'package:my_todo_app/utils/constants.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({super.key, required this.drawerKey});

  final GlobalKey<SliderDrawerState> drawerKey;

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController animateController;
  bool isMenuOpen = false;

  @override
  void initState() {
    animateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    super.initState();
  }

  @override
  void dispose() {
    animateController.dispose();
    super.dispose();
  }

  // OnToggleMenu
  void toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
      if (isMenuOpen) {
        animateController.forward();
        widget.drawerKey.currentState?.openSlider();
      } else {
        animateController.reverse();
        widget.drawerKey.currentState?.closeSlider();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var base = BaseWidget.of(context).dataStore.box;
    return SizedBox(
      width: double.infinity,
      height: 130,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Menu Icon
            Padding(
              padding:
                  EdgeInsets.only(left: AppDimensions.width(context) * 0.02),
              child: IconButton(
                  onPressed: toggleMenu,
                  icon: AnimatedIcon(
                    icon: AnimatedIcons.menu_close,
                    progress: animateController,
                    size: 40,
                  )),
            ),

            // Delete all tasks icon
            Padding(
              padding:
                  EdgeInsets.only(right: AppDimensions.width(context) * 0.02),
              child: IconButton(
                  onPressed: () {
                    // Delete all tasks
                    base.isEmpty
                    ? noTaskWarning(context)
                    : deleteAllTasks(context);
                  },
                  icon: const Icon(
                    CupertinoIcons.trash_circle_fill,
                    size: 40,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
