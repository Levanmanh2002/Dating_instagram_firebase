// ignore_for_file: unused_local_variable

import 'dart:math';
import 'package:dattings/lib_fb_fibase/data/const.dart';
import 'package:dattings/lib_fb_fibase/data/until.dart';
import 'package:dattings/lib_fb_fibase/theadMain.dart';
import 'package:dattings/lib_fb_fibase/userPofile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> with TickerProviderStateMixin {
  late TabController _tabController;
  MyProfileData? myData;
  bool _isLoading = false;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(_handleTabSelection);
    _takeMyData();
    super.initState();
  }

  Future<void> _takeMyData() async {
    setState(() {
      _isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String myThumbnail;
    String myName;
    if (prefs.get('myThumbnail') == null) {
      String tempThumbnail = iconImageList[Random().nextInt(50)];
      prefs.setString('myThumbnail', tempThumbnail);
      myThumbnail = tempThumbnail;
    } else {
      myThumbnail = ('myThumbnail');
    }
    if (prefs.get('myName') == null) {
      String tempName = getRandomString(8);
      prefs.setString('myName', tempName);
      myName = tempName;
    } else {
      myName = 'myName';
    }

    setState(() {
      myData = MyProfileData(
        myThumbnail: myThumbnail,
        myName: myName,
        myLikeList: prefs.getStringList('likeList') ?? [],
        myLikeCommnetList: prefs.getStringList('postCommentCount') ?? [],
      );
    });
    setState(() {
      _isLoading = false;
    });
  }

  void _handleTabSelection() => setState(() {});

  void onTabTapped(int index) {
    setState(() {
      _tabController.index = index;
    });
  }

  void updateMyData(MyProfileData newMyData) {
    setState(() {
      myData = newMyData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter thred example'),
        centerTitle: true,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ThreadMain(
            myData: myData ??
                MyProfileData(
                  myThumbnail: '',
                  myName: '',
                  myLikeList: [],
                  myLikeCommnetList: [],
                ),
            updateMyData: updateMyData,
          ),
          UserProfile(
            myData: myData ??
                MyProfileData(
                  myThumbnail: '',
                  myName: '',
                  myLikeList: [],
                  myLikeCommnetList: [],
                ),
            updateMyData: updateMyData,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _tabController.index,
        selectedItemColor: Colors.amber[900],
        unselectedItemColor: Colors.grey[800],
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Thread',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
