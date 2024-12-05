import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insta_clone/classes/user.dart';
import 'package:insta_clone/components/show_food_item.dart';
import 'package:insta_clone/database/firestore_methods.dart';
import 'package:insta_clone/providers/user_provider.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:insta_clone/utils/global_variable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NutritionPage extends StatefulWidget {
  const NutritionPage({super.key});

  @override
  State<NutritionPage> createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  FireStoreMethods fireStoreMethods = FireStoreMethods();
  int width = 600;
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    print(user);
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      appBar: width > webScreenSize
          ? null
          : AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: mobileBackgroundColor,
              centerTitle: false,
              title: SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 32,
              ),
              actions: [
                Container(
                  width: 80,
                  height: 40,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  decoration: BoxDecoration(
                    color: Color(0xFF2C2C2E),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.local_fire_department, // Fire icon
                          color: Colors.orange,
                          size: 20,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '${user.streak}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                )
              ],
            ),
      body: FutureBuilder<Map<String, dynamic>>(
          future: fireStoreMethods.fetchDailyIntakeForDate(
              DateFormat('ddMMyyyy').format(DateTime.now())),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            // Data successfully fetched
            final data = snapshot.data!;
            double cal_percent = (data['caloriesConsumed'] /
                    user.recommendedNutrition['recommendedCalories']) *
                100;
            double protein_percent = (data['proteinConsumed'] /
                    user.recommendedNutrition['recommendedProtein']) *
                100;
            double fats_percent = (data['fatsConsumed'] /
                    user.recommendedNutrition['recommendedFats']) *
                100;
            double carbs_percent = (data['carbsConsumed'] /
                    user.recommendedNutrition['recommendedCarbs']) *
                100;

            return ListView(
              padding: EdgeInsets.all(16), // Space for the ElevatedButton
              children: [
                // First Box
                Container(
                  height: 145,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFF2C2C2E),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, top: 9),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "${user.recommendedNutrition['recommendedCalories'] - data['caloriesConsumed']}",
                                  style: TextStyle(
                                      fontSize: 45,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFFFFFFF))),
                              Text("Calories left",
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xFF8E8E93))),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 25),
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              PieChart(
                                PieChartData(
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 50,
                                  startDegreeOffset: 270,
                                  sections: [
                                    PieChartSectionData(
                                      value: cal_percent, // Completed portion
                                      color: Colors.green,
                                      title: "",
                                      radius: 7,
                                      showTitle: true,
                                    ),
                                    PieChartSectionData(
                                      value: 100 -
                                          cal_percent, // Remaining portion
                                      color: Colors.grey,
                                      title: "",
                                      radius: 7,
                                      showTitle: true,
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons
                                    .local_fire_department, // Icon for Calories
                                color: cal_percent > 100
                                    ? Colors.orange.shade400
                                    : Colors.grey.shade400,
                                size:
                                    40, // Adjust the size as per your preference
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),

                // Smaller Boxes
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSmallBox(
                      "${user.recommendedNutrition['recommendedProtein'] - data['proteinConsumed']}g",
                      "Protein left",
                      protein_percent,
                      Icon(
                        Icons.fitness_center, // Icon for Calories
                        color: Colors.red.shade400,
                        size: 22, // Adjust the size as per your preference
                      ),
                    ),
                    _buildSmallBox(
                      "${user.recommendedNutrition['recommendedCarbs'] - data['carbsConsumed']}g",
                      "Carbs left",
                      carbs_percent,
                      Icon(
                        Icons.bakery_dining, // Icon for Calories
                        color: Colors.blue.shade400,
                        size: 25, // Adjust the size as per your preference
                      ),
                    ),
                    _buildSmallBox(
                      "${user.recommendedNutrition['recommendedFats'] - data['fatsConsumed']}g",
                      "Fats left",
                      fats_percent,
                      Icon(
                        Icons.opacity, // Icon for Calories
                        color: Colors.green.shade400,
                        size: 23, // Adjust the size as per your preference
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // Uploaded Today
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Uploaded today",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
                // ListView.builder for dynamic content
                SizedBox(
                  height: 20,
                ),

                data['posts'].length == 0
                    ? SizedBox(
                        height: 300,
                        child: Center(
                          child: Text(
                            'no data uploaded tday',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: data['posts'].length,
                        itemBuilder: (context, index) {
                          final foodItem = data['posts'][index];
                          String foodName = foodItem['dishname'];
                          String imageUrl = foodItem['postUrl'];
                          int calories = foodItem['calories'];
                          int protein = foodItem['protein'];
                          int carbs = foodItem['carbs'];
                          int fats = foodItem['fats'];
                          Timestamp timestamp = foodItem['datePublished'];
                          String formattedTime =
                              DateFormat('h:mm a').format(timestamp.toDate());

                          return ShowFoodItem(
                            calories: calories,
                            carbs: carbs,
                            fats: fats,
                            foodName: foodName,
                            formattedTime: formattedTime,
                            protein: protein,
                            imageUrl: imageUrl,
                          );
                        },
                      ),
              ],
            );
          }),
    );
  }

  Widget _buildSmallBox(
      String value, String label, double percentage, Widget icon) {
    return Container(
        width: 115,
        height: 145,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: cardBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align text to the left within Column
          children: [
            Padding(
              padding: EdgeInsets.only(left: 7, top: 2, bottom: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          value,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          label,
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
                height: 8), // Add some spacing between text and chart if needed
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      PieChart(
                        PieChartData(
                          sectionsSpace: 0,
                          centerSpaceRadius: 30,
                          startDegreeOffset: 270,
                          sections: [
                            PieChartSectionData(
                              value: percentage, // Completed portion
                              color: Colors.green,
                              title: "",
                              radius: 5,
                              showTitle: true,
                            ),
                            PieChartSectionData(
                              value: 100 - percentage, // Remaining portion
                              color: Colors.grey,
                              title: "",
                              radius: 5,
                              showTitle: true,
                            ),
                          ],
                        ),
                      ),
                      icon,
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
