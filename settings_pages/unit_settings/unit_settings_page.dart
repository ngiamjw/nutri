import 'package:flutter/material.dart';
import 'package:insta_clone/classes/user.dart';
import 'package:insta_clone/components/setting_tile.dart';
import 'package:insta_clone/providers/user_provider.dart';
import 'package:insta_clone/settings_pages/unit_settings/unit_class.dart';
import 'package:provider/provider.dart';

class UnitSettingsPage extends StatefulWidget {
  UnitSettingsPage({super.key});

  @override
  State<UnitSettingsPage> createState() => _UnitSettingsPageState();
}

class _UnitSettingsPageState extends State<UnitSettingsPage> {
  @override
  Widget build(BuildContext context) {
    UnitClass unitclass = UnitClass();
    final User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      backgroundColor: Color(0xFF1C1C1E), // Dark background color
      appBar: AppBar(
        backgroundColor: Color(0xFF1C1C1E),
        elevation: 0,
        title: Text(
          'Units',
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
            // Length Units Tile
            SettingsTile(
              title: "Length",
              value: user.user_info['length_unit'],
              onTap: () {
                // Handle navigation for Length units settings
                unitclass.showLengthPicker(context, user.user_info, this);
              },
            ),
            // Weight Units Tile
            SettingsTile(
              title: "Weight",
              value: user.user_info['weight_unit'],
              onTap: () {
                // Handle navigation for Weight units settings
                unitclass.showWeightPicker(context, user.user_info, this);
              },
            ),
          ],
        ),
      ),
    );
  }
}
