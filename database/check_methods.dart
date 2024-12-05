import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CheckMethods {
  final CollectionReference _firestore =
      FirebaseFirestore.instance.collection('users');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addDailyIntake(String date) async {
    final dailyIntakeRef = _firestore
        .doc(_auth.currentUser!.uid)
        .collection('dailyIntake')
        .doc(date);
    final snapshot = await dailyIntakeRef.get();

    if (!snapshot.exists) {
      // Add daily intake if the document does not exist
      await dailyIntakeRef.set({
        'date': date,
        'caloriesConsumed': 0,
        'proteinConsumed': 0,
        'carbsConsumed': 0,
        'fatsConsumed': 0,
        'postId': []
      });

      print("Daily intake added successfully for $date");
    } else {
      print("Daily intake for $date already exists. No changes made.");
    }
  }

  Future<bool> doesUsernameExist(String username) async {
    try {
      // Reference to the 'users' collection
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: username)
          .limit(1) // Limit to 1 for efficiency
          .get();

      // Check if any documents were returned
      return result.docs.isNotEmpty;
    } catch (e) {
      print('Error checking username: $e');
      return false;
    }
  }
}
