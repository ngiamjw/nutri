import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/classes/user.dart';
import 'package:insta_clone/components/setting_tile.dart';
import 'package:insta_clone/providers/user_provider.dart';
import 'package:insta_clone/settings_pages/account_page.dart';
import 'package:insta_clone/settings_pages/profile_page/profile_class.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  profileClass profileclass = profileClass();

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      backgroundColor: Color(0xFF1C1C1E),
      appBar: AppBar(
        backgroundColor: Color(0xFF1C1C1E),
        elevation: 0,
        title: Text(
          'Profile',
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
            // Profile Section
            SettingsTile(
              title: "User Name",
              value: "JWNgiam",
              onTap: () {
                // Handle navigation
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AccountSettingsPage()),
                );
              },
            ),
            SettingsTile(
              title: "Height",
              value:
                  "${user.user_info['height']} ${user.user_info['length_unit']}",
              onTap: () {
                // Handle navigation
                profileclass.showHeightPicker(context, user.user_info, this);
              },
            ),
            SettingsTile(
              title: "Weight",
              value:
                  "${user.user_info['weight']}${user.user_info['weight_unit']}",
              onTap: () {
                // Handle navigation
                profileclass.showWeightPicker(context, user.user_info, this);
              },
            ),
            SettingsTile(
                title: "Sex",
                value: "${user.user_info['gender']}",
                onTap: () =>
                    profileclass.showSexPicker(context, user.user_info, this)),
            SettingsTile(
                title: "Date of Birth",
                value: "14 Nov 2004",
                onTap: () =>
                    profileclass.showDatePicker(context, user.user_info, this)),
            SettingsTile(
              title: "Email Address",
              value: "ngiamjw@gmail.com",
              onTap: () {
                // Handle navigation
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AccountSettingsPage()),
                );
              },
            ),
            SettingsTile(
              title: "Workouts per week",
              value: "${user.user_info['workoutsPerWeek']}",
              onTap: () {
                // Handle navigation
                profileclass.WorkoutPicker(context, user.user_info, this);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to get month name
}
