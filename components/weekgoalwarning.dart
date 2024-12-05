import 'package:flutter/material.dart';

class WeekGoalWarning extends StatelessWidget {
  final String title;
  final double fontsize;
  const WeekGoalWarning(
      {super.key, required this.fontsize, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(100, 10, 150, 243),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: Colors.grey.shade50,
            fontSize: fontsize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
