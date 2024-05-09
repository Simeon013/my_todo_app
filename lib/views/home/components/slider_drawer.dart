import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_todo_app/extensions/space_exs.dart';
import 'package:my_todo_app/utils/app_colors.dart';
import 'package:my_todo_app/utils/app_dimensions.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  // Icons
  final List<IconData> icons = [
    CupertinoIcons.home,
    CupertinoIcons.person_fill,
    CupertinoIcons.settings,
    CupertinoIcons.info_circle_fill,
  ];

  // Text
  final List<String> texts = [
    'Accueil',
    'Profil',
    'Paramètres',
    'A propos',
  ];

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppDimensions.height(context) * 0.05,
      ),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: AppColors.pimaryGradientColor,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      )),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/img/dog.png'),
          ),
          8.h,
          Text(
            'Siméon DAOUDA',
            style: textTheme.displayMedium,
          ),
          Text(
            'Développeur Flutter',
            style: textTheme.displaySmall,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: AppDimensions.height(context) * 0.04,
              horizontal: AppDimensions.width(context) * 0.05,
            ),
            width: double.infinity,
            height: 300,
            child: ListView.builder(
                itemCount: icons.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      print(
                        '${texts[index]} clicked',
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(
                        AppDimensions.height(context) * 0.007,
                      ),
                      child: ListTile(
                        leading: Icon(
                          icons[index],
                          color: Colors.white,
                          size: 30,
                        ),
                        title: Text(
                          texts[index],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
