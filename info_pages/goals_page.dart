import 'package:flutter/material.dart';
import 'package:insta_clone/classes/user.dart';
import 'package:insta_clone/classes/user_data.dart';
import 'package:insta_clone/components/my_info_box.dart';
import 'package:insta_clone/utils/colors.dart';

class GoalsPage extends StatefulWidget {
  final UserData user_data;
  final void Function(bool isValid) onValidationChanged;
  final Function onAddWeeklyGoalsPage;

  GoalsPage(
      {super.key,
      required this.user_data,
      required this.onValidationChanged,
      required this.onAddWeeklyGoalsPage});

  @override
  _GoalsPageState createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            "What are your goals for this app",
            style: TextStyle(
                fontSize: 25,
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 150,
          ),
          MyBox(
            title: 'Cut',
            isSelected: widget.user_data.goals == 'Cut',
            onTap: () {
              setState(() {
                widget.user_data.goals = "Cut";
                widget.onValidationChanged(true);
                widget.onAddWeeklyGoalsPage();
              });
            },
          ),
          MyBox(
            title: 'Bulk',
            isSelected: widget.user_data.goals == 'Bulk',
            onTap: () {
              setState(() {
                widget.user_data.goals = 'Bulk';
                widget.onValidationChanged(true);
                widget.onAddWeeklyGoalsPage();
              });
            },
          ),
          MyBox(
            title: 'Lean Bulk',
            isSelected: widget.user_data.goals == 'Lean Bulk',
            onTap: () {
              setState(() {
                widget.user_data.goals = 'Lean Bulk';
                widget.onValidationChanged(true);
                widget.onAddWeeklyGoalsPage();
              });
            },
          ),
          MyBox(
            title: 'Maintain',
            isSelected: widget.user_data.goals == 'Maintain',
            onTap: () {
              setState(() {
                widget.user_data.goals = 'Maintain';
                widget.onValidationChanged(true);
              });
            },
          ),
        ],
      ),
    );
  }
}
