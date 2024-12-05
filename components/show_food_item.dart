import 'package:flutter/material.dart';
import 'package:insta_clone/utils/colors.dart';

class ShowFoodItem extends StatelessWidget {
  final String foodName;
  final int calories;
  final int protein;
  final int carbs;
  final int fats;
  final String imageUrl;
  final String formattedTime;
  const ShowFoodItem(
      {super.key,
      required this.calories,
      required this.carbs,
      required this.fats,
      required this.foodName,
      required this.formattedTime,
      required this.protein,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: cardBackground,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Row(
          children: [
            // Image on the left side of the box
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: SizedBox(
                height: 100,
                width: 100,
                child: Image.network(
                  imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 16),
            // Information next to the image
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Food Name and Calories
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 200,
                        height: 25,
                        child: Text(
                          foodName,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Text(
                        formattedTime,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.local_fire_department,
                        color: Colors.orange.shade400,
                        size: 20,
                      ),
                      Text(
                        ' $calories',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      // Time of food intake

                      SizedBox(height: 8),
                      // Macronutrients: Protein, Carbs, Fats
                      Icon(
                        Icons.fitness_center,
                        color: Colors.red.shade400,
                        size: 17,
                      ),
                      Text(
                        ' $protein g',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.bakery_dining,
                        color: Colors.blue.shade500,
                        size: 17,
                      ),
                      Text(' $carbs g',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.opacity,
                        color: Colors.green.shade500,
                        size: 17,
                      ),
                      Text(' $fats g',
                          style: TextStyle(color: Colors.white, fontSize: 17)),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
