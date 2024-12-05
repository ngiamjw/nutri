import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/components/setting_class_tile.dart';
import 'package:insta_clone/database/settings_methods.dart';

class GoalClass {
  SettingsMethods settingsMethods = SettingsMethods();
  void onPressed(BuildContext context, Map<String, dynamic> user_info) {
    settingsMethods.updateUserInfo(
        email: 'ngiamjw@gmail.com', userData: user_info);
    Navigator.pop(context);
  }

  void showStartingWeightPicker(
      BuildContext context, Map<String, dynamic> user_info, State state) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Color(0xFF1C1C1E),
          height: 300,
          child: Column(
            children: [
              // Picker Header with close and confirm buttons
              SettingClassTile(
                  onPressed: () {
                    onPressed(context, user_info);
                  },
                  title: 'Starting weight'),
              Divider(color: Colors.grey.shade800),
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 40,
                  onSelectedItemChanged: (int index) {
                    // Handle the selected value
                    state.setState(() {
                      user_info['weight'] = (index + 50);
                    });
                  },
                  children: List<Widget>.generate(101, (int index) {
                    return Center(
                      child: Text(
                        '${50 + index}',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void WeeklyGoalPicker(
      BuildContext context, Map<String, dynamic> user_info, State state) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Color(0xFF1C1C1E),
          height: 300,
          child: Column(
            children: [
              // Picker Header with close and confirm buttons
              SettingClassTile(
                  onPressed: () {
                    onPressed(context, user_info);
                  },
                  title: 'Weekly goal'),
              Divider(color: Colors.grey.shade800),
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 40,
                  onSelectedItemChanged: (int index) {
                    // Handle the selected value
                    state.setState(() {
                      if (index == 0) {
                        user_info['weekly_goal'] = 0.2;
                      } else if (index == 1) {
                        user_info['weekly_goal'] = 0.5;
                      } else if (index == 2) {
                        user_info['weekly_goal'] = 0.8;
                      } else {
                        user_info['weekly_goal'] = 1.0;
                      }
                    });
                  },
                  children: const [
                    Center(
                        child: Text(
                      '0.2kg',
                      style: TextStyle(color: Colors.white),
                    )),
                    Center(
                        child: Text('0.5kg',
                            style: TextStyle(color: Colors.white))),
                    Center(
                        child: Text(
                      '0.8kg',
                      style: TextStyle(color: Colors.white),
                    )),
                    Center(
                        child: Text(
                      '1kg',
                      style: TextStyle(color: Colors.white),
                    )),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void WorkoutPicker(
      BuildContext context, Map<String, dynamic> user_info, State state) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Color(0xFF1C1C1E),
          height: 300,
          child: Column(
            children: [
              // Picker Header with close and confirm buttons
              SettingClassTile(
                  onPressed: () {
                    onPressed(context, user_info);
                  },
                  title: 'Workouts per week'),
              Divider(color: Colors.grey.shade800),
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 40,
                  onSelectedItemChanged: (int index) {
                    state.setState(() {
                      if (index == 0) {
                        user_info['workoutsPerWeek'] = 2;
                      } else if (index == 1) {
                        user_info['workoutsPerWeek'] = 4;
                      } else if (index == 2) {
                        user_info['workoutsPerWeek'] = 6;
                      } else {
                        user_info['workoutsPerWeek'] = 7;
                      }
                    });
                  },
                  children: const [
                    Center(
                        child: Text(
                      '1-2 times a week',
                      style: TextStyle(color: Colors.white),
                    )),
                    Center(
                        child: Text('3-4 times a week',
                            style: TextStyle(color: Colors.white))),
                    Center(
                        child: Text(
                      '5-6 times a week',
                      style: TextStyle(color: Colors.white),
                    )),
                    Center(
                        child: Text(
                      'Every day',
                      style: TextStyle(color: Colors.white),
                    )),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showCurrentWeightPicker(
      BuildContext context, Map<String, dynamic> user_info, State state) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Color(0xFF1C1C1E),
          height: 300,
          child: Column(
            children: [
              // Picker Header with close and confirm buttons
              SettingClassTile(
                  onPressed: () {
                    onPressed(context, user_info);
                  },
                  title: 'Current weight'),
              Divider(color: Colors.grey.shade800),
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 40,
                  onSelectedItemChanged: (int index) {
                    // Handle the selected value
                    state.setState(() {
                      user_info['current_weight'] = (index + 50);
                    });
                  },
                  children: List<Widget>.generate(101, (int index) {
                    return Center(
                      child: Text(
                        '${50 + index}',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showGoalWeightPicker(
      BuildContext context, Map<String, dynamic> user_info, State state) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Color(0xFF1C1C1E),
          height: 300,
          child: Column(
            children: [
              // Picker Header with close and confirm buttons
              SettingClassTile(
                  onPressed: () {
                    onPressed(context, user_info);
                  },
                  title: 'Goal weight'),
              Divider(color: Colors.grey.shade800),
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 40,
                  onSelectedItemChanged: (int index) {
                    // Handle the selected value
                    state.setState(() {
                      user_info['goal_weight'] = (index + 50);
                    });
                  },
                  children: List<Widget>.generate(101, (int index) {
                    return Center(
                      child: Text(
                        '${50 + index}',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
