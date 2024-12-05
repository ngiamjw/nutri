import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/components/setting_class_tile.dart';
import 'package:insta_clone/database/settings_methods.dart';

class profileClass {
  SettingsMethods settingsMethods = SettingsMethods();
  void onPressed(BuildContext context, Map<String, dynamic> user_info) {
    settingsMethods.updateUserInfo(
        email: 'ngiamjw@gmail.com', userData: user_info);
    Navigator.pop(context);
  }

  void showSexPicker(
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
                  title: 'Gender'),
              Divider(color: Colors.grey.shade800),
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 40,
                  onSelectedItemChanged: (int index) {
                    // Handle the selected value
                    state.setState(() {
                      if (index == 0) {
                        user_info['gender'] = 'Male';
                      } else {
                        user_info['gender'] = 'Female';
                      }
                    });
                  },
                  children: const [
                    Center(
                        child: Text(
                      'Male',
                      style: TextStyle(color: Colors.white),
                    )),
                    Center(
                        child: Text('Female',
                            style: TextStyle(color: Colors.white))),
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
                    // Handle the selected value
                    state.setState(() {
                      if (index == 0) {
                        user_info['workoutsPerWeek'] = '2';
                      } else if (index == 1) {
                        user_info['workoutsPerWeek'] = '4';
                      } else if (index == 2) {
                        user_info['workoutsPerWeek'] = '6';
                      } else {
                        user_info['workoutsPerWeek'] = '7';
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

  void showHeightPicker(
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
                  title: 'Height'),
              Divider(color: Colors.grey.shade800),
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 40,
                  onSelectedItemChanged: (int index) {
                    // Handle the selected value
                    state.setState(() {
                      user_info['height'] = (index + 140);
                    });
                  },
                  children: List<Widget>.generate(101, (int index) {
                    return Center(
                      child: Text(
                        '${140 + index}',
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

  void showWeightPicker(
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
                  title: 'Weight'),
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

  String _getMonthName(int month) {
    List<String> months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return months[month - 1];
  }

  DateTime selectedDate = DateTime.now();

  // Function to show date picker
  void showDatePicker(
      BuildContext context, Map<String, dynamic> user_info, State state) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        DateTime tempSelectedDate = selectedDate;

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
                  title: 'Date of birth'),
              Divider(color: Colors.grey.shade800),
              Expanded(
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: TextStyle(
                        color: Colors.white, // Change the text color here
                        fontSize: 20,
                      ),
                    ),
                  ),
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: selectedDate,
                    minimumYear: 1900,
                    maximumYear: DateTime.now().year,
                    backgroundColor: Color(0xFF1C1C1E), // Set background color
                    onDateTimeChanged: (DateTime newDate) {
                      state.setState(() {
                        user_info['DOB'] = newDate;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
