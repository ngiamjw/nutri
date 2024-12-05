import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:insta_clone/camera/image_display_input.dart';
import 'package:insta_clone/database/firestore_methods.dart';
import 'package:insta_clone/providers/user_provider.dart';
import 'package:insta_clone/responsive/mobile_screen_layout.dart';
import 'package:insta_clone/responsive/responsive_layout.dart';
import 'package:insta_clone/responsive/web_screen_layout.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:intl/intl.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class ImageDetailsPage extends StatefulWidget {
  final Uint8List image;
  final Map<String, dynamic> response;
  final int daily_calories;
  final int daily_protein;
  final int daily_carbs;
  final int daily_fats;

  ImageDetailsPage({
    required this.image,
    required this.response,
    required this.daily_calories,
    required this.daily_carbs,
    required this.daily_fats,
    required this.daily_protein,
  });

  @override
  State<ImageDetailsPage> createState() => _ImageDetailsPageState();
}

class _ImageDetailsPageState extends State<ImageDetailsPage> {
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    TextEditingController namecontroller =
        TextEditingController(text: widget.response['name']);
    TextEditingController caloriecontroller =
        TextEditingController(text: widget.response['calories'].toString());
    TextEditingController proteincontroller =
        TextEditingController(text: widget.response['protein'].toString());
    TextEditingController carbcontroller =
        TextEditingController(text: widget.response['carbs'].toString());
    TextEditingController fatcontroller =
        TextEditingController(text: widget.response['fats'].toString());
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    FireStoreMethods fireStoreMethods = FireStoreMethods();
    return isloading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            backgroundColor: mobileBackgroundColor,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: mobileBackgroundColor,
              title:
                  Text('Image Details', style: TextStyle(color: Colors.white)),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Image at the top
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Container(
                      height: 250,
                      width: 250,
                      color: Colors.grey[300], // In case the image doesn't load
                      child: widget.image != null
                          ? Image.memory(
                              widget.image, // Uint8List data
                              fit: BoxFit.cover,
                            )
                          : SizedBox.shrink(),
                    ),
                  ),
                  SizedBox(height: 50),

                  // Dish Name
                  Padding(
                    padding: const EdgeInsets.only(left: 65),
                    child: Row(
                      children: [
                        Text("Dish:",
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                        SizedBox(width: 10),
                        SizedBox(
                          width: 200,
                          child: TextField(
                            controller: namecontroller,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            decoration: InputDecoration(
                              hintText: 'Enter dish name',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),

                  // Calories and Protein Row
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Row(
                      children: [
                        ImageDisplayInput(
                          title: "Calories",
                          mycontroller: caloriecontroller,
                        ),
                        SizedBox(width: 20),
                        ImageDisplayInput(
                          title: "Protein",
                          mycontroller: proteincontroller,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 40),

                  // Carbs and Fats Row
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Row(
                      children: [
                        ImageDisplayInput(
                          title: "Carbs",
                          mycontroller: carbcontroller,
                        ),
                        SizedBox(width: 43),
                        ImageDisplayInput(
                          title: "Fats",
                          mycontroller: fatcontroller,
                        )
                      ],
                    ),
                  ),

                  Spacer(),

                  // Bottom Buttons (Retake & Upload)
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade500,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Text("Retake",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              // Add your "Upload" functionality here
                              setState(() {
                                isloading = true;
                              });
                              await fireStoreMethods.uploadPost(
                                "test",
                                widget.image,
                                userProvider.getUser.uid,
                                userProvider.getUser.username,
                                userProvider.getUser.photoUrl,
                                namecontroller.text,
                                int.parse(caloriecontroller.text),
                                int.parse(proteincontroller.text),
                                int.parse(carbcontroller.text),
                                int.parse(fatcontroller.text),
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResponsiveLayout(
                                        mobileScreenLayout:
                                            MobileScreenLayout(),
                                        webScreenLayout: WebScreenLayout())),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade500,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Text("Upload",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
