import 'package:flutter/material.dart';
import 'package:my_todo_app/utils/app_dimensions.dart';
import 'package:my_todo_app/utils/app_str.dart';

class RepTextField extends StatelessWidget {
  const RepTextField({
    super.key,
    required this.controller, 
    this.isForDescription = false, 
    required this.onFieldSubmiited, 
    required this.onChanged,
  });

  final TextEditingController? controller;
  final bool isForDescription;
  final Function(String)? onFieldSubmiited;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: AppDimensions.width(context) * 0.05,
      ),
      child: ListTile(
        title: TextFormField(
          controller: controller,
          maxLines: !isForDescription ? 6 : null,
          cursorHeight: !isForDescription ? 60 : null,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            border: isForDescription ? InputBorder.none : null,
            counter: Container(),
            hintText: isForDescription ? AppStr.addNote : null,
            prefixIcon: isForDescription
              ? const Icon(
                  Icons.bookmark_border,
                  color: Colors.grey,
              )
              : null,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300)),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300))),
          onFieldSubmitted: onFieldSubmiited,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
