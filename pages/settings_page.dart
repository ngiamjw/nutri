import 'package:flutter/material.dart';
import 'package:insta_clone/settings_pages/account_page.dart';
import 'package:insta_clone/settings_pages/goal_setting/goal_setting_page.dart';
import 'package:insta_clone/settings_pages/nutrition_settings_page.dart';
import 'package:insta_clone/settings_pages/profile_page/profile_page.dart';
import 'package:insta_clone/settings_pages/unit_settings/unit_settings_page.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings", style: TextStyle(color: Colors.white)),
          backgroundColor: Color(0xFF1C1C1E),
          centerTitle: true,
        ),
        backgroundColor: Color(0xFF1C1C1E), // Dark background
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: ListView(
            children: [
              // Account Section Header
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Account",
                  style: TextStyle(
                    color: Color(0xFF8E8E93),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Profile
              GestureDetector(
                onTap: () {
                  // Handle navigation
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
                child: _buildListTile(
                  icon: Icons.person_outline,
                  title: "Profile",
                ),
              ),
              // Account
              GestureDetector(
                onTap: () {
                  // Handle navigation
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AccountSettingsPage()),
                  );
                },
                child: _buildListTile(
                  icon: Icons.lock_outline,
                  title: "Account",
                ),
              ),
              // Notifications
              GestureDetector(
                onTap: () {
                  // Handle navigation
                },
                child: _buildListTile(
                  icon: Icons.notifications_outlined,
                  title: "Notifications",
                ),
              ),

              SizedBox(height: 20), // Space between sections

              // Preferences Section Header
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Preferences",
                  style: TextStyle(
                    color: Color(0xFF8E8E93),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Workouts
              GestureDetector(
                onTap: () {
                  // Handle navigation
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GoalSettingPage()),
                  );
                },
                child: _buildListTile(
                  icon: Icons.fitness_center_outlined,
                  title: "Goals",
                ),
              ),
              // Units
              GestureDetector(
                onTap: () {
                  // Handle navigation
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UnitSettingsPage()),
                  );
                },
                child: _buildListTile(
                  icon: Icons.straighten_outlined,
                  title: "Units",
                ),
              ),
              // Language
              GestureDetector(
                onTap: () {
                  // Handle navigation
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NutritionSettingsPage()),
                  );
                },
                child: _buildListTile(
                  icon: Icons.local_pizza,
                  title: "Nutrition",
                ),
              ),
            ],
          ),
        ));
  }

  // Helper function to build a list tile
  Widget _buildListTile({
    required IconData icon,
    required String title,
    bool proLabel = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (proLabel)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                "PRO",
                style: TextStyle(
                  color: Color(0xFFF7C948),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Icon(Icons.chevron_right, color: Colors.grey, size: 24),
        ],
      ),
    );
  }
}
