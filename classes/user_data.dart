class UserData {
  String? username;
  String? gender;
  int? workoutsPerWeek;
  int weight = 50;
  int height = 170;
  int goal_weight = 50;
  String? goals;
  String weight_unit = 'kg';
  String length_unit = 'cm';
  DateTime? DOB;
  double? weekly_goal;

  double? bmr;

  Map<String, dynamic> returnUserData() {
    return {
      'gender': gender,
      'workoutsPerWeek': workoutsPerWeek,
      'weight': weight,
      'height': height,
      'goal_weight': goal_weight,
      'goals': goals,
      'weight_unit': weight_unit,
      'length_unit': length_unit,
      'weekly_goal': weekly_goal,
      'current_weight': weight,
      'DOB': DOB,
    };
  }

  void calculateTDEE() {
    if (gender == 'Male') {
      bmr = 10 * weight +
          6.25 * height -
          5 * (DateTime.now().year - DOB!.year) +
          5;
    } else {
      bmr = 10 * weight +
          6.25 * height -
          5 * (DateTime.now().year - DOB!.year) -
          161;
    }
    switch (workoutsPerWeek) {
      case 2:
        bmr = bmr! * 1.2;
      case 4:
        bmr = bmr! * 1.375;
      case 6:
        bmr = bmr! * 1.725;
      case 7:
        bmr = bmr! * 1.9;
    }
  }

  Map<String, dynamic> cutCalculator() {
    calculateTDEE();

    double calorie_deficit = weekly_goal! * 100;
    double calories_a_day = bmr! - calorie_deficit;
    double protein = weight * 2;
    double fats = (calories_a_day / 4) / 9;
    double carbs = (calories_a_day - protein * 4 - fats * 9) / 4;

    return {
      'recommendedCalories': calories_a_day.toInt(),
      'recommendedProtein': protein.toInt(),
      'recommendedCarbs': carbs.toInt(),
      'recommendedFats': fats.toInt(),
    };
  }

  Map<String, dynamic> bulkCalculator() {
    calculateTDEE();

    double calorie_surplus = weekly_goal! * 100;
    double calories_a_day = bmr! + calorie_surplus;
    double protein = weight * 2.2;
    double fats = (calories_a_day / 4) / 9;
    double carbs = (calories_a_day - protein * 4 - fats * 9) / 4;

    return {
      'recommendedCalories': calories_a_day.toInt(),
      'recommendedProtein': protein.toInt(),
      'recommendedCarbs': carbs.toInt(),
      'recommendedFats': fats.toInt(),
    };
  }

  Map<String, dynamic> leanbulkCalculator() {
    calculateTDEE();

    double calorie_surplus = weekly_goal! * 75;
    double calories_a_day = bmr! + calorie_surplus;
    double protein = weight * 2.5;
    double fats = (calories_a_day / 5) / 9;
    double carbs = (calories_a_day - protein * 4 - fats * 9) / 4;
    return {
      'recommendedCalories': calories_a_day.toInt(),
      'recommendedProtein': protein.toInt(),
      'recommendedCarbs': carbs.toInt(),
      'recommendedFats': fats.toInt(),
    };
  }

  Map<String, dynamic> maintainCalculator() {
    calculateTDEE();

    double calorie_surplus = weekly_goal! * 75;
    double calories_a_day = bmr! + calorie_surplus;
    double protein = weight * 1.6;
    double fats = (calories_a_day / 4) / 9;
    double carbs = (calories_a_day - protein * 4 - fats * 9) / 4;

    return {
      'recommendedCalories': calories_a_day.toInt(),
      'recommendedProtein': protein.toInt(),
      'recommendedCarbs': carbs.toInt(),
      'recommendedFats': fats.toInt(),
    };
  }
}
