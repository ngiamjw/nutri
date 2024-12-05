import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/pages/add_post_screen.dart';
import 'package:insta_clone/pages/feed_screen.dart';
import 'package:insta_clone/pages/nutrition_page.dart';
import 'package:insta_clone/pages/profile_screen.dart';
import 'package:insta_clone/pages/search_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  NutritionPage(),
  SearchScreen(),
  AddPostScreen(),
  FeedScreen(),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid),
];
