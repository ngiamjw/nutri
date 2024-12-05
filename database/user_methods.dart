import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addUserData(
      {required Map<String, dynamic> recommendedNutrition,
      required Map<String, dynamic> userData}) {
    // Use the email as the document ID
    User currentUser = _auth.currentUser!;
    return _firestore.collection('users').doc(currentUser.uid).update({
      'recommendedNutrition': recommendedNutrition,
      'user_info': userData,
    });
  }
}
