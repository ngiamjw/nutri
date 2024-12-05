import 'package:flutter/material.dart';
import 'package:insta_clone/classes/user.dart';
import 'package:insta_clone/classes/user_data.dart';
import 'package:insta_clone/components/my_info_box.dart';
import 'package:insta_clone/utils/colors.dart';

class WorkoutInfoPage extends StatefulWidget {
  final UserData user_data;
  final void Function(bool isValid) onValidationChanged;

  WorkoutInfoPage(
      {super.key, required this.user_data, required this.onValidationChanged});
  @override
  _WorkoutInfoPageState createState() => _WorkoutInfoPageState();
}

class _WorkoutInfoPageState extends State<WorkoutInfoPage> {
  String? selectedWorkout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            "How active are you?",
            style: TextStyle(
                fontSize: 25,
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 150,
          ),
          MyBox(
            title: '1-2 Days',
            isSelected: widget.user_data.workoutsPerWeek == 2,
            onTap: () {
              setState(() {
                widget.user_data.workoutsPerWeek = 2;
                widget.onValidationChanged(true);
              });
            },
          ),
          MyBox(
            title: '3-4 Days',
            isSelected: widget.user_data.workoutsPerWeek == 4,
            onTap: () {
              setState(() {
                widget.user_data.workoutsPerWeek = 4;
                widget.onValidationChanged(true);
              });
            },
          ),
          MyBox(
            title: '5-6 Days',
            isSelected: widget.user_data.workoutsPerWeek == 6,
            onTap: () {
              setState(() {
                widget.user_data.workoutsPerWeek = 6;
                widget.onValidationChanged(true);
              });
            },
          ),
          MyBox(
            title: 'All Days of the Week',
            isSelected: widget.user_data.workoutsPerWeek == 7,
            onTap: () {
              setState(() {
                widget.user_data.workoutsPerWeek = 7;
                widget.onValidationChanged(true);
              });
            },
          ),
        ],
      ),
    );
  }
}
