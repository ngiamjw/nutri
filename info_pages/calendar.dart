import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/date_picker_theme.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';
import 'package:insta_clone/classes/user.dart';
import 'package:insta_clone/classes/user_data.dart';
import 'package:insta_clone/utils/colors.dart';

class CalendarPage extends StatefulWidget {
  final UserData user_data;
  final void Function(bool isValid) onValidationChanged;

  CalendarPage(
      {super.key, required this.user_data, required this.onValidationChanged});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mobileBackgroundColor,
        body: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              "How old are you?",
              style: TextStyle(
                  fontSize: 25,
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 150,
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: DatePickerWidget(
                  looping: false, // default is not looping
                  firstDate: DateTime(1970, 01, 01),
                  lastDate: DateTime.now(),
                  initialDate: DateTime.now(),
                  dateFormat: "dd-MMM-yyyy",
                  locale: DatePicker.localeFromString('en'),
                  onChange: (DateTime newDate, _) {
                    widget.user_data.DOB = newDate;
                    widget.onValidationChanged(true);
                  },
                  pickerTheme: DateTimePickerTheme(
                    backgroundColor: Colors.transparent,
                    itemTextStyle: TextStyle(color: Colors.white, fontSize: 19),
                    dividerColor: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
