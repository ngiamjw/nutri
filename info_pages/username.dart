import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:insta_clone/auth/auth_methods.dart';
import 'package:insta_clone/classes/user.dart';
import 'package:insta_clone/classes/user_data.dart';
import 'package:insta_clone/components/my_info_box.dart';
import 'package:insta_clone/components/weekgoalwarning.dart';
import 'package:insta_clone/database/check_methods.dart';
import 'package:insta_clone/providers/user_provider.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:provider/provider.dart';

class UserName extends StatefulWidget {
  final UserData user_data;
  final void Function(bool isValid) onValidationChanged;

  UserName(
      {super.key, required this.user_data, required this.onValidationChanged});

  @override
  _UserNameState createState() => _UserNameState();
}

class _UserNameState extends State<UserName> {
  bool username_exists = false;
  CheckMethods checkMethods = CheckMethods();
  AuthMethods authMethods = AuthMethods();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void onInputSubmitted(String input) async {
    print(input);
    bool usernameExists = await checkMethods.doesUsernameExist(input);
    if (usernameExists) {
      print("username exists");
      setState(() {
        username_exists = true;
      });
    } else {
      widget.onValidationChanged(true);
      widget.user_data.username = input;
      await authMethods.updateUsername(_auth.currentUser!.uid, input);
    }
    // Call your function here
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller =
        TextEditingController(text: widget.user_data.username);
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Center(
            child: Container(
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: Colors.blue.shade500, width: 1),
              ),
              child: Center(
                child: TextField(
                  controller: controller,
                  onSubmitted: onInputSubmitted,
                  style: TextStyle(fontSize: 25),
                  decoration: InputDecoration(
                    hintText: "Username",
                    border: InputBorder.none, // Removes default underline
                  ),
                ),
              ),
            ),
          ),
          if (username_exists)
            WeekGoalWarning(fontsize: 15, title: "Username Exists"),
        ],
      ),
    );
  }
}
