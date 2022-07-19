import 'package:dattings/instagram/screens/AddPostScreen.dart';
import 'package:dattings/instagram/screens/FeedScreen.dart';
import 'package:dattings/instagram/screens/ProfileScreen.dart';
import 'package:dattings/instagram/screens/SearchScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const Text('notifications'),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
