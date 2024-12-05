import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:insta_clone/database/storage_methods.dart';
import 'package:insta_clone/classes/post.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadPost(
      String description,
      Uint8List file,
      String uid,
      String username,
      String profImage,
      String dishName,
      int calories,
      int protein,
      int carbs,
      int fats) async {
    // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management
    String res = "Some error occurred";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1(); // creates unique id based on time
      Map<String, dynamic> toJson() => {
            "description": description,
            "uid": uid,
            "likes": [],
            "username": username,
            "postId": postId,
            "datePublished": DateTime.now(),
            'postUrl': photoUrl,
            'profImage': profImage,
            'dishname': dishName,
            'calories': calories,
            'protein': protein,
            'carbs': carbs,
            'fats': fats,
          };
      await _firestore.collection('posts').doc(postId).set(toJson());

      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('dailyIntake')
          .doc(DateFormat('ddMMyyyy').format(DateTime.now()))
          .update({
        'postId': FieldValue.arrayUnion([postId]),
        'caloriesConsumed': FieldValue.increment(calories),
        'proteinConsumed': FieldValue.increment(protein),
        'carbsConsumed': FieldValue.increment(carbs),
        'fatsConsumed': FieldValue.increment(fats),
      });
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> likePost(String postId, String uid, List likes) async {
    String res = "Some error occurred";
    try {
      if (likes.contains(uid)) {
        // if the likes list contains the user uid, we need to remove it
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Post comment
  Future<String> postComment(String postId, String text, String uid,
      String name, String profilePic) async {
    String res = "Some error occurred";
    try {
      if (text.isNotEmpty) {
        // if the likes list contains the user uid, we need to remove it
        String commentId = const Uuid().v1();
        _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
        res = 'success';
      } else {
        res = "Please enter text";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Delete Post
  Future<String> deletePost(String postId) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('posts').doc(postId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {
      if (kDebugMode) print(e.toString());
    }
  }

  Future<Map<String, dynamic>> fetchDailyIntakeForDate(String date) async {
    Map<String, dynamic> result = {};

    try {
      // Reference to the specific `dailyIntake` document for the given date
      DocumentSnapshot dailyDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('dailyIntake')
          .doc(date)
          .get();

      if (dailyDoc.exists) {
        // Start with the main document's data
        result = dailyDoc.data() as Map<String, dynamic>;

        // Initialize the posts list
        List<Map<String, dynamic>> posts = [];

        // Retrieve post IDs from the `dailyDoc` data
        List<dynamic> postIds = result['postId'] ?? [];
        for (var postId in postIds) {
          // Fetch each post by its ID
          DocumentSnapshot postDoc = await FirebaseFirestore.instance
              .collection('posts')
              .doc(postId)
              .get();

          if (postDoc.exists) {
            posts.add(postDoc.data() as Map<String, dynamic>);
          }
        }

        // Add the posts list to the result
        result['posts'] = posts;
      } else {
        print("No daily intake found for date: $date");
      }
    } catch (e) {
      print("Error fetching daily intake for date $date: $e");
    }

    return result;
  }
}
