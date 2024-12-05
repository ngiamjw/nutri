import 'package:flutter/material.dart';
import 'package:insta_clone/components/setting_tile.dart';

class NutritionSettingsPage extends StatelessWidget {
  NutritionSettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1C1E), // Dark background color
      appBar: AppBar(
        backgroundColor: Color(0xFF1C1C1E),
        elevation: 0,
        title: Text(
          'Nutrition Settings',
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
            // Calories Tile
            SettingsTile(
              title: "Calories",
              value: "2000 kcal",
              onTap: () {
                // Handle navigation for Calories settings
              },
            ),
            // Protein Tile
            SettingsTile(
              title: "Protein",
              value: "150 g",
              onTap: () {
                // Handle navigation for Protein settings
              },
            ),
            // Carbs Tile
            SettingsTile(
              title: "Carbs",
              value: "250 g",
              onTap: () {
                // Handle navigation for Carbs settings
              },
            ),
            // Fats Tile
            SettingsTile(
              title: "Fats",
              value: "70 g",
              onTap: () {
                // Handle navigation for Fats settings
              },
            ),
          ],
        ),
      ),
    );
  }
}
