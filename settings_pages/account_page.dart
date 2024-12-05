import 'package:flutter/material.dart';
import 'package:insta_clone/components/setting_tile.dart';

class AccountSettingsPage extends StatelessWidget {
  AccountSettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1C1E),
      appBar: AppBar(
        backgroundColor: Color(0xFF1C1C1E),
        elevation: 0,
        title: Text(
          'Account Settings',
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
              title: "Change Username",
              icon: Icons.person_outline,
              onTap: () {
                // Handle navigation
              },
            ),
            SettingsTile(
              title: "Change Email",
              icon: Icons.email_outlined,
              onTap: () {
                // Handle navigation
              },
            ),
            SettingsTile(
              title: "Update Password",
              icon: Icons.lock_outline,
              onTap: () {
                // Handle navigation
              },
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // Handle delete account action
              },
              child: Text(
                "Delete Account",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
