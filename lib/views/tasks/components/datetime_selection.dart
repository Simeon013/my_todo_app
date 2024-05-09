import 'package:flutter/material.dart';
import 'package:my_todo_app/utils/app_dimensions.dart';

class DateTimeSelection extends StatelessWidget {
  const DateTimeSelection({
    super.key,
    required this.onTap,
    required this.title,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.fromLTRB(
          AppDimensions.width(context) * 0.05,
          AppDimensions.height(context) * 0.02,
          AppDimensions.width(context) * 0.05,
          0,
        ),
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: AppDimensions.width(context) * 0.03,
              ),
              child: Text(
                title,
                style: textTheme.headlineSmall,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                right: AppDimensions.width(context) * 0.03,
              ),
              width: 80,
              height: 35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade100),
              child: Center(
                // Text will show date & time
                child: Text(
                  title,
                  style: textTheme.titleSmall,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
