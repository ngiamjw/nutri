import 'package:flutter/material.dart';
import 'package:insta_clone/classes/user.dart';
import 'package:insta_clone/components/setting_tile.dart';
import 'package:insta_clone/providers/user_provider.dart';
import 'package:insta_clone/settings_pages/goal_setting/goal_class.dart';
import 'package:provider/provider.dart';

class GoalSettingPage extends StatefulWidget {
  GoalSettingPage({super.key});

  @override
  State<GoalSettingPage> createState() => _GoalSettingPageState();
}

class _GoalSettingPageState extends State<GoalSettingPage> {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    GoalClass goalClass = GoalClass();
    return Scaffold(
      backgroundColor: Color(0xFF1C1C1E),
      appBar: AppBar(
        backgroundColor: Color(0xFF1C1C1E),
        elevation: 0,
        title: Text(
          'Goals',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: ListView(
          children: [
            SettingsTile(
              title: "Starting Weight",
              value: "${user.user_info['weight']}",
              onTap: () {
                goalClass.showStartingWeightPicker(
                    context, user.user_info, this);
              },
            ),
            SettingsTile(
              title: "Current Weight",
              value: "${user.user_info['current_weight']}",
              onTap: () {
                goalClass.showCurrentWeightPicker(
                    context, user.user_info, this);
              },
            ),
            SettingsTile(
              title: "Goal Weight",
              value: "${user.user_info['goal_weight']}",
              onTap: () {
                goalClass.showGoalWeightPicker(context, user.user_info, this);
              },
            ),
            SettingsTile(
              title: "Weekly Goal",
              value: "${user.user_info['weekly_goal']}",
              onTap: () {
                goalClass.WeeklyGoalPicker(context, user.user_info, this);
              },
            ),
            SettingsTile(
              title: "Activity Level",
              value: "${user.user_info['workoutsPerWeek']}",
              onTap: () {
                goalClass.WorkoutPicker(context, user.user_info, this);
              },
            ),
          ],
        ),
      ),
    );
  }
}
