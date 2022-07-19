// ignore_for_file: sort_child_properties_last

import 'package:dattings/datings/Home/iteam_girl.dart';
import 'package:dattings/datings/models/data.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.filter_list),
          color: Colors.red,
        ),
        title: const Text(
          'Datting',
          style: TextStyle(
            fontSize: 25,
            color: Colors.pink,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: GridView.builder(
        itemCount: data.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          // mainAxisSpacing: 20,
          // crossAxisSpacing: 20,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(
            top: index % 2 == 0 ? 10 : 10,
            right: index % 2 == 0 ? 5 : 20,
            left: index % 2 == 1 ? 5 : 20,
            bottom: index % 2 == 1 ? 10 : 10,
          ),
          child: ItemUserCard(
            data[index],
            index: index,
          ),
        ),
      ),
    );
  }
}
