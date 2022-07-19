import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dattings/lib_fb_fibase/contentDetail.dart';
import 'package:dattings/lib_fb_fibase/data/const.dart';
import 'package:dattings/lib_fb_fibase/threadItem.dart';
import 'package:dattings/lib_fb_fibase/witePofile.dart';
import 'package:flutter/material.dart';

class ThreadMain extends StatefulWidget {
  final MyProfileData myData;
  final ValueChanged<MyProfileData> updateMyData;

  const ThreadMain({
    Key? key,
    required this.myData,
    required this.updateMyData,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ThreadMain();
}

class _ThreadMain extends State<ThreadMain> {
  final bool _isLoading = false;

  void _writePost() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WitePofile(
          myData: widget.myData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('User')
            .orderBy('postTimeStamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text("Loading..."),
            );
          }
          return Stack(
            children: <Widget>[
              snapshot.data!.docs.isNotEmpty
                  ? ListView(
                      shrinkWrap: true,
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot data) {
                        return ThreadItem(
                          data: data,
                          myData: widget.myData,
                          updateMyDataToMain: widget.updateMyData,
                          threadItemAction: _moveToContentDetail,
                          isFromThread: true,
                          commentCount: data['postCommentCount'],
                          parentContext: context,
                        );
                      }).toList(),
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Icon(
                            Icons.error,
                            color: Colors.grey,
                            size: 64,
                          ),
                          Padding(
                            padding: EdgeInsets.all(14.0),
                            child: Text(
                              'Ther is no post',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
              _isLoading
                  ? Positioned(
                      child: Container(
                        color: Colors.white.withOpacity(0.7),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    )
                  : Container(),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _writePost,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _moveToContentDetail(DocumentSnapshot data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContentDetail(
          postData: data,
          myData: widget.myData,
          updateMyData: widget.updateMyData,
        ),
      ),
    );
  }
}
