import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String username;
  final String email;
  final String uid;
  final String photoUrl;
  final String bio;
  final List followers;
  final int streak;
  final List following;
  final Map<String, dynamic> user_info;
  final Map<String, dynamic> recommendedNutrition;

  User({
    required this.photoUrl,
    required this.username,
    required this.uid,
    required this.bio,
    required this.email,
    required this.followers,
    required this.following,
    required this.user_info,
    required this.streak,
    required this.recommendedNutrition,
  });

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    print(snapshot);

    User user = User(
        username: snapshot["username"],
        uid: snapshot["uid"],
        photoUrl: snapshot['photoUrl'],
        email: snapshot["email"],
        bio: snapshot['bio'],
        streak: snapshot['streak'],
        followers: snapshot["followers"],
        following: snapshot["following"],
        user_info: snapshot['user_info'],
        recommendedNutrition: snapshot['recommendedNutrition']);

    print('managed to create user');

    return user;
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "bio": bio,
        "streak": streak,
        "followers": followers,
        "following": following,
        'user_info': user_info,
        'recommendedNutrition': recommendedNutrition
      };
}
