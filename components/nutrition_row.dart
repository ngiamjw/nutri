import 'package:flutter/material.dart';

class NutritionRow extends StatelessWidget {
  final int calories;
  final int protein;
  final int carbs;
  final int fats;
  const NutritionRow(
      {super.key,
      required this.calories,
      required this.carbs,
      required this.fats,
      required this.protein});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Time of food intake
        Icon(
          Icons.opacity,
          color: Colors.green.shade500,
          size: 17,
        ),
        Text('$calories g',
            style: TextStyle(color: Colors.white, fontSize: 17)),
        SizedBox(
          width: 10,
        ),
        // Macronutrients: Protein, Carbs, Fats
        Icon(
          Icons.fitness_center,
          color: Colors.red.shade400,
          size: 17,
        ),
        Text(
          '$protein g',
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
        Text('$carbs g', style: TextStyle(color: Colors.white, fontSize: 20)),
        SizedBox(
          width: 10,
        ),
        Icon(
          Icons.opacity,
          color: Colors.green.shade500,
          size: 17,
        ),
        Text('$fats g', style: TextStyle(color: Colors.white, fontSize: 17)),
      ],
    );
  }
}
