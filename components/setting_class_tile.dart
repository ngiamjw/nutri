import 'package:flutter/material.dart';

class SettingClassTile extends StatelessWidget {
  void Function()? onPressed;
  final String title;
  SettingClassTile({super.key, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        IconButton(
          icon: Icon(Icons.check, color: Colors.white),
          onPressed: onPressed,
        ),
      ],
    );
  }
}
