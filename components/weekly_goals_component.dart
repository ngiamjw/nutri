import 'package:flutter/material.dart';
import 'package:insta_clone/classes/user.dart';
import 'package:insta_clone/classes/user_data.dart';
import 'package:insta_clone/components/my_info_box.dart';
import 'package:insta_clone/components/weekgoalwarning.dart';

class WeekGoalComponent extends StatefulWidget {
  final UserData user_data;
  final void Function(bool isValid) onValidationChanged;
  final String firstTitle;
  final String SecondTitle;
  final String thirdTitle;
  final String fourthTitle;
  const WeekGoalComponent(
      {super.key,
      required this.user_data,
      required this.onValidationChanged,
      required this.SecondTitle,
      required this.firstTitle,
      required this.fourthTitle,
      required this.thirdTitle});

  @override
  State<WeekGoalComponent> createState() => _WeekGoalComponentState();
}

class _WeekGoalComponentState extends State<WeekGoalComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyBox(
          title: widget.firstTitle,
          isSelected: widget.user_data.weekly_goal == 0.2,
          onTap: () {
            setState(() {
              widget.user_data.weekly_goal = 0.2;
              widget.onValidationChanged(true);
              print(widget.user_data.weekly_goal);
            });
          },
        ),
        MyBox(
          title: widget.SecondTitle,
          isSelected: widget.user_data.weekly_goal == 0.5,
          onTap: () {
            setState(() {
              widget.user_data.weekly_goal = 0.5;
              widget.onValidationChanged(true);
            });
          },
        ),
        MyBox(
          title: widget.thirdTitle,
          isSelected: widget.user_data.weekly_goal == 0.8,
          onTap: () {
            setState(() {
              widget.user_data.weekly_goal = 0.8;
              widget.onValidationChanged(true);
            });
          },
        ),
        MyBox(
          title: widget.fourthTitle,
          isSelected: widget.user_data.weekly_goal == 1.0,
          onTap: () {
            setState(() {
              widget.user_data.weekly_goal = 1.0;
              widget.onValidationChanged(true);
              print("Weekly Goal: '${widget.user_data.weekly_goal}'");
            });
          },
        ),
        SizedBox(
          height: 60,
        ),
        if (widget.user_data.weekly_goal == 0.2 &&
            (widget.user_data.goals == 'Cut' ||
                widget.user_data.goals == 'Bulk'))
          WeekGoalWarning(
            fontsize: 15,
            title: "Slow and Steady",
          ),
        if (widget.user_data.weekly_goal == 1.0 &&
            widget.user_data.goals == 'Bulk')
          WeekGoalWarning(
            fontsize: 14,
            title: "Might lead to higher than average fat accumulation",
          ),
        if (widget.user_data.weekly_goal == 1.0 &&
            widget.user_data.goals == 'Cut')
          WeekGoalWarning(
            fontsize: 14,
            title: "Might cause you to feel lethargic",
          ),
        if ((widget.user_data.weekly_goal == 1.0 ||
                widget.user_data.weekly_goal == 0.8) &&
            widget.user_data.goals == 'Lean Bulk')
          WeekGoalWarning(
            fontsize: 14,
            title: "Might lead to higher than average fat accumulation",
          ),
      ],
    );
  }
}
