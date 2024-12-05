import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:insta_clone/database/check_methods.dart";
import "package:insta_clone/pages/login_screen.dart";
import "package:insta_clone/pages/page_view.dart";
import "package:insta_clone/responsive/mobile_screen_layout.dart";
import "package:insta_clone/responsive/responsive_layout.dart";
import "package:insta_clone/responsive/web_screen_layout.dart";
import "package:intl/intl.dart";

class AuthPage extends StatefulWidget {
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isloading = true;
  bool has_user_data = false;
  bool hascheckeddata = false;
  CheckMethods firestoreservice = CheckMethods();

  @override
  void initState() {
    super.initState();
  }

  Future<void> checkAndAddData() async {
    try {
      // Get the current user's UID
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) {
        throw Exception("User is not logged in");
      }
      print("do you even work");
      print(has_user_data);

      // Reference to the user's document in Firestore
      final docRef = FirebaseFirestore.instance.collection('users').doc(uid);

      // Fetch the document
      final docSnapshot = await docRef.get();

      final userData = docSnapshot.data() as Map<String, dynamic>;

      if ((userData['user_info'] as Map).isNotEmpty) {
        // If data exists, store it
        setState(() {
          has_user_data = true;
        });
        print("there is user data");
      }
      print("fukckckckckc");
      print(has_user_data);

      final dailyIntake = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('dailyIntake')
          .doc(DateFormat('ddMMyyyy').format(DateTime.now()))
          .get();

      if (!dailyIntake.exists) {
        firestoreservice
            .addDailyIntake(DateFormat('ddMMyyyy').format(DateTime.now()));

        print("daily intake added");
      }
      // Update the UI
      setState(() {
        isloading = false;
      });
    } catch (e) {
      print("Error: $e");
      // Handle errors (optional)
      setState(() {
        isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            // Check if the snapshot has data
            if (snapshot.hasData) {
              // Get the current user UID from FirebaseAuth
              final uid = FirebaseAuth.instance.currentUser?.uid;

              if (uid == null) {
                return const Center(
                  child: Text('User UID not found.'),
                );
              }
              if (!hascheckeddata) {
                hascheckeddata = true;
                checkAndAddData();
              }

              return isloading
                  ? const Center(child: CircularProgressIndicator())
                  : has_user_data
                      ? ResponsiveLayout(
                          mobileScreenLayout: MobileScreenLayout(),
                          webScreenLayout: WebScreenLayout(),
                        )
                      : MultiPageForm();
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return const LoginScreen();
        },
      ),
    );
  }
}
