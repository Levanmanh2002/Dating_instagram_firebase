// ignore_for_file: file_names

import 'package:dattings/datings/Login_Register/Login/login.dart';
import 'package:flutter/material.dart';

class HomeIntroPage extends StatefulWidget {
  const HomeIntroPage({Key? key}) : super(key: key);

  @override
  State<HomeIntroPage> createState() => _HomeIntroPageState();
}

class _HomeIntroPageState extends State<HomeIntroPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginApp(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(
            child: Text(
              "Dattings",
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          Center(
            child: Text(
              "Kết bạn hẹn hò",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
