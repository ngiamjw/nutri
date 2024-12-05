import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsMethods {
  final CollectionReference _firestore =
      FirebaseFirestore.instance.collection('users');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> updateUserInfo(
      {required String email, required Map<String, dynamic> userData}) {
    // Use the email as the document ID
    return _firestore.doc(_auth.currentUser!.uid).update({
      'user_info': userData,
    });
  }
}
