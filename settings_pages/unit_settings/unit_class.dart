import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/components/setting_class_tile.dart';
import 'package:insta_clone/database/settings_methods.dart';

class UnitClass {
  SettingsMethods settingsMethods = SettingsMethods();
  void onPressed(BuildContext context, Map<String, dynamic> user_info) {
    settingsMethods.updateUserInfo(
        email: 'ngiamjw@gmail.com', userData: user_info);
    Navigator.pop(context);
  }

  void showLengthPicker(
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
                  title: "Length"),
              Divider(color: Colors.grey.shade800),
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 40,
                  onSelectedItemChanged: (int index) {
                    // Handle the selected value
                    state.setState(() {
                      if (index == 0) {
                        user_info['length_unit'] = 'cm';
                      } else {
                        user_info['gender'] = 'in';
                      }
                    });
                  },
                  children: const [
                    Center(
                        child: Text(
                      'Cm',
                      style: TextStyle(color: Colors.white),
                    )),
                    Center(
                        child: Text('Inch',
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
                  title: "Weight"),
              Divider(color: Colors.grey.shade800),
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 40,
                  onSelectedItemChanged: (int index) {
                    // Handle the selected value
                    state.setState(() {
                      if (index == 0) {
                        user_info['weight_unit'] = 'kg';
                      } else {
                        user_info['weight_unit'] = 'lbs';
                      }
                    });
                  },
                  children: const [
                    Center(
                        child: Text(
                      'Kg',
                      style: TextStyle(color: Colors.white),
                    )),
                    Center(
                        child:
                            Text('Lbs', style: TextStyle(color: Colors.white))),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
