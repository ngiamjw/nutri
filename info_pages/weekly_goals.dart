import 'package:flutter/material.dart';
import 'package:insta_clone/classes/user.dart';
import 'package:insta_clone/classes/user_data.dart';
import 'package:insta_clone/components/weekly_goals_component.dart';
import 'package:insta_clone/utils/colors.dart';

class WeeklyGoalsPage extends StatefulWidget {
  final UserData user_data;
  final void Function(bool isValid) onValidationChanged;

  WeeklyGoalsPage(
      {super.key, required this.user_data, required this.onValidationChanged});
  @override
  _WeeklyGoalsPageState createState() => _WeeklyGoalsPageState();
}

class _WeeklyGoalsPageState extends State<WeeklyGoalsPage> {
  String? selectedGoal;

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
            "Weekly weight goals",
            style: TextStyle(
                fontSize: 25,
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 150,
          ),
          if (widget.user_data.goals == "Cut")
            Column(
              children: [
                WeekGoalComponent(
                  user_data: widget.user_data,
                  onValidationChanged: widget.onValidationChanged,
                  firstTitle: "Lose 0.2kg a week",
                  SecondTitle: "Lose 0.5kg a week (recommended)",
                  thirdTitle: "Lose 0.8kg a week",
                  fourthTitle: "Lose 1kg a week",
                ),
              ],
            ),
          if (widget.user_data.goals == "Bulk")
            WeekGoalComponent(
              user_data: widget.user_data,
              onValidationChanged: widget.onValidationChanged,
              firstTitle: "Gain 0.2kg a week",
              SecondTitle: "Gain 0.5kg a week (recommended)",
              thirdTitle: "Gain 0.8kg a week",
              fourthTitle: "Gain 1kg a week",
            ),
          if (widget.user_data.goals == "Lean Bulk")
            WeekGoalComponent(
              user_data: widget.user_data,
              onValidationChanged: widget.onValidationChanged,
              firstTitle: "Gain 0.2kg a week (recommended)",
              SecondTitle: "Gain 0.5kg a week",
              thirdTitle: "Gain 0.8kg a week",
              fourthTitle: "Gain 1kg a week",
            )
        ],
      ),
    );
  }
}
