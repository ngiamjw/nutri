import 'package:flutter/material.dart';
import 'package:insta_clone/classes/user.dart';
import 'package:insta_clone/classes/user_data.dart';
import 'package:insta_clone/components/my_info_box.dart';
import 'package:insta_clone/utils/colors.dart';

class HeightWeightGoalPage extends StatefulWidget {
  final UserData user_data;
  final void Function(bool isValid) onValidationChanged;

  HeightWeightGoalPage(
      {super.key, required this.user_data, required this.onValidationChanged});
  @override
  _HeightWeightGoalPageState createState() => _HeightWeightGoalPageState();
}

class _HeightWeightGoalPageState extends State<HeightWeightGoalPage> {
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
            "A few more important questions",
            style: TextStyle(
                fontSize: 25,
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 70,
          ),
          Text(
            'How tall are you?',
            style: TextStyle(
                fontSize: 15,
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.bold),
          ),
          MyBox(
              title: widget.user_data.length_unit == 'cm'
                  ? '${widget.user_data.height} ${widget.user_data.length_unit}'
                  : '${(widget.user_data.height ~/ 30.48).toInt()}ft ${((widget.user_data.height % 30.48) ~/ 2.54).round()}in',
              isSelected: false,
              onTap: () {
                _showSliderBottomSheet(
                    'Height',
                    widget.user_data.height.toDouble(),
                    widget.user_data.length_unit, (value, unit) {
                  setState(() {
                    widget.user_data.height = value.toInt();
                    widget.user_data.length_unit = unit;
                  });
                });
              }),
          SizedBox(
            height: 30,
          ),
          Text(
            'How much do you weigh?',
            style: TextStyle(
                fontSize: 15,
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.bold),
          ),
          MyBox(
              title: widget.user_data.weight_unit == 'kg'
                  ? '${widget.user_data.weight} ${widget.user_data.weight_unit}'
                  : '${(widget.user_data.weight / 0.453).toInt()} ${widget.user_data.weight_unit}',
              isSelected: false,
              onTap: () {
                _showSliderBottomSheet(
                    'Weight',
                    widget.user_data.weight.toDouble(),
                    widget.user_data.weight_unit, (value, unit) {
                  setState(() {
                    widget.user_data.weight = value.toInt();
                    widget.user_data.weight_unit = unit;
                  });
                });
              }),
          SizedBox(
            height: 30,
          ),
          Text(
            'What\'s your ideal weight',
            style: TextStyle(
                fontSize: 15,
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.bold),
          ),
          MyBox(
              title: widget.user_data.weight_unit == 'kg'
                  ? '${widget.user_data.goal_weight} ${widget.user_data.weight_unit}'
                  : '${(widget.user_data.goal_weight / 0.453).toInt()} ${widget.user_data.weight_unit}',
              isSelected: false,
              onTap: () {
                _showSliderBottomSheet(
                    'Goal Weight',
                    widget.user_data.goal_weight.toDouble(),
                    widget.user_data.weight_unit, (value, unit) {
                  setState(() {
                    widget.user_data.goal_weight = value.toInt();
                  });
                });
              }),
        ],
      ),
    );
  }

  void _showSliderBottomSheet(
    String title,
    double initialValue,
    String currentUnit,
    Function(double, String) onSave,
  ) {
    double tempValue = initialValue;
    String tempUnit = currentUnit;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              color: Colors.black,
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        'Your $title',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      IconButton(
                        icon: Icon(Icons.check, color: Colors.white),
                        onPressed: () {
                          onSave(tempValue, tempUnit);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (title != 'Goal Weight') ...[
                        TextButton(
                          onPressed: () {
                            setState(() {
                              tempUnit = title == 'Height'
                                  ? 'cm'
                                  : 'kg'; // Reset value to default if unit changes
                            });
                          },
                          child: Text(
                            title == 'Height' ? 'Centimeters' : 'Kilograms',
                            style: TextStyle(
                              color:
                                  tempUnit == (title == 'Height' ? 'cm' : 'kg')
                                      ? Colors.blue
                                      : Colors.grey,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              tempUnit = title == 'Height'
                                  ? 'ft'
                                  : 'lbs'; // Reset value to default if unit changes
                            });
                          },
                          child: Text(
                            title == 'Height' ? 'Feet/Inches' : 'Pounds',
                            style: TextStyle(
                              color:
                                  tempUnit == (title == 'Height' ? 'ft' : 'lbs')
                                      ? Colors.blue
                                      : Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (currentUnit == 'kg' || currentUnit == 'lbs')
                    Slider(
                      value: tempValue,
                      activeColor: Colors.blue.shade500,
                      min: 50,
                      max: 150,
                      divisions: ((tempUnit == 'kg') ? 100 : 220),
                      label: tempUnit == 'kg'
                          ? '${tempValue.toInt()} $tempUnit'
                          : '${(tempValue / 0.453).toInt()} $tempUnit',
                      onChanged: (double value) {
                        setState(() {
                          tempValue = value;
                        });
                      },
                    ),
                  if (currentUnit == 'cm' || currentUnit == 'ft')
                    Slider(
                      value: tempValue,
                      activeColor: Colors.blue.shade500,
                      min: 130,
                      max: 250,
                      divisions: (120),
                      label: tempUnit == 'ft'
                          ? '${(tempValue ~/ 30.48).toInt()}ft ${((tempValue % 30.48) ~/ 2.54).round()}in'
                          : '${tempValue.toInt()} $tempUnit',
                      onChanged: (double value) {
                        setState(() {
                          tempValue = value;
                        });
                      },
                    ),
                  SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
