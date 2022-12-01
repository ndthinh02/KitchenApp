import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  IconData circleAvatar;
  String text;
  Color? color;
  Color? colorText;
  VoidCallback onPress;

  CategoryWidget(
      {super.key,
      this.color,
      required this.colorText,
      required this.circleAvatar,
      required this.text,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          CircleAvatar(
            foregroundColor: Colors.black,
            backgroundColor: color,
            radius: 30,
            child: Icon(circleAvatar),
          ),
          const SizedBox(height: 10),
          Text(
            text,
            style: TextStyle(color: colorText),
          ),
        ],
      ),
    ]);
  }
}
