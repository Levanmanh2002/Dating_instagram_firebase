import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dattings/datings/News/widgets/Comment_Section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemNews extends StatefulWidget {
  final String phone;
  const ItemNews({
    Key? key,
    required this.phone,
  }) : super(key: key);

  @override
  State<ItemNews> createState() => _ItemNewsState();
}

class _ItemNewsState extends State<ItemNews> {
  late CollectionReference postsRef;
  late DocumentReference likesRef;
  bool isLikesd = false;
  dynamic data;
  bool isPostLiked = true;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  showSnackBar(BuildContext context, String text) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  FirebaseFirestore firestoreRef = FirebaseFirestore.instance;
  final bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Expanded(
                    child: FutureBuilder<QuerySnapshot>(
                      future: firestoreRef
                          .collection("Users")
                          .orderBy('image', descending: true)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasData &&
                            snapshot.data!.docs.length > 0) {
                          List<DocumentSnapshot> arrData = snapshot.data!.docs;
                          print(arrData.length);
                          return ListView.builder(
                            itemCount: arrData.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  top: 10,
                                  right: 10,
                                ),
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: const CircleAvatar(
                                            radius: 25,
                                            backgroundImage: AssetImage(
                                              "assets/images/avatar.jpg",
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text(
                                                  "Họ Tên",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 3,
                                                ),
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 2),
                                                  decoration: BoxDecoration(
                                                    color: (Text == 'Nam')
                                                        ? Colors.cyan
                                                        : Colors.pink[300],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Wrap(
                                                    children: const [
                                                      // Icon(
                                                      //   Text  ? Icons.male : Icons.female,
                                                      //   size: 10,
                                                      // ),
                                                      Icon(Icons.male),
                                                      Text(
                                                        "Nam",
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            const Text(
                                              "10 Phút trước",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 10),
                                            child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: GestureDetector(
                                                child: Icon(
                                                  Icons.more_horiz,
                                                  color: Colors.grey,
                                                ),
                                                onTap: () {},
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 15,
                                        bottom: 15,
                                      ),
                                      child: Text(
                                        arrData[index]["text"],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.network(
                                          arrData[index]["image"],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 30),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton.icon(
                                            onPressed: () {},
                                            icon: Icon(
                                              CupertinoIcons.heart,
                                              color: data != null &&
                                                      data.containsKey(snapshot
                                                          .data!
                                                          .docs[index]['uid'])
                                                  ? Colors.red
                                                  : Colors.black,
                                            ),
                                            label: Text('1'
                                                // '${snapshot.data!.docs[index]['likes']}',
                                                ),
                                          ),
                                          TextButton.icon(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const CommentSection(),
                                                ),
                                              );
                                            },
                                            icon: const Icon(
                                              CupertinoIcons
                                                  .bubble_left_bubble_right,
                                            ),
                                            label: const Text("0"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        } else {
                          return const Center(
                            child: Text("No Data"),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
