import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dattings/lib_fb_fibase/controller/CloudStore.dart';
import 'package:dattings/lib_fb_fibase/data/const.dart';
import 'package:dattings/lib_fb_fibase/data/until.dart';
import 'package:dattings/lib_fb_fibase/fullPhoto.dart';
import 'package:flutter/material.dart';

class ContentDetail extends StatefulWidget {
  final DocumentSnapshot postData;
  final MyProfileData myData;
  final ValueChanged<MyProfileData> updateMyData;
  const ContentDetail({
    Key? key,
    required this.postData,
    required this.myData,
    required this.updateMyData,
  }) : super(key: key);

  @override
  State<ContentDetail> createState() => _ContentDetailState();
}

class _ContentDetailState extends State<ContentDetail> {
  // FirebaseFirestore firestoreRef = FirebaseFirestore.instance;
  // FirebaseStorage storageRef = FirebaseStorage.instance;
  // late String _replyUserID;
  // late String _replyCommentID;
  // late String _replyUserFCMToken;
  // final FocusNode _writingTextFocus = FocusNode();
  final TextEditingController _TextCommentController = TextEditingController();

  // void _moveToFullImage() => Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => FullPhoto(
  //           imageUrl: widget.postData['postImage'],
  //         ),
  //       ),
  //     );

  // void _replyComment(List<String> commentData) async {
  //   //String replyTo,String replyCommentID,String replyUserToken) async {
  //   _replyUserID = commentData[0];
  //   _replyCommentID = commentData[1];
  //   _replyUserFCMToken = commentData[2];
  //   FocusScope.of(context).requestFocus(_writingTextFocus);
  //   _msgTextController.text = '${commentData[0]} ';
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Content Detail'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('User')
            .doc(widget.postData['postID'])
            .collection('comment')
            .orderBy('commentTimeStamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // return const Center(
            //   child: CircularProgressIndicator(),
            // );
          }
          return Column(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(2, 2, 2, 6),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Card(
                          elevation: 2.0,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {},
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            6, 2, 10, 2),
                                        child: SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: Image.asset(
                                            'images/${widget.postData['postThumbnail']}',
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            widget.postData['userName'],
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text(
                                              readTimestamp(widget
                                                  .postData['postTimeStamp']),
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 10, 4, 10),
                                    child: Text(
                                      widget.postData['postContent'],
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                widget.postData['postImage'] != 'NONE'
                                    ? GestureDetector(
                                        onTap: () {
                                          FullPhoto(
                                            imageUrl:
                                                widget.postData['postImage'],
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 10, 4, 10),
                                          child: Image.network(
                                            widget.postData['postImage'],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    : Container(),
                                const Divider(
                                  height: 2,
                                  color: Colors.black,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 6, bottom: 2),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          const Icon(
                                            Icons.thumb_up,
                                            size: 18,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              'Like (${widget.postData['postLikeCount']})',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          const Icon(
                                            Icons.mode_comment,
                                            size: 18,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              'Comments ( ${snapshot.data!.docs.length} )',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        snapshot.data!.docs.length > 0
                            ? ListView(
                                shrinkWrap: true,
                                children: snapshot.data!.docs.map((document) {
                                  return _commentListItem(document, size);
                                }).toList(),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ),
              _buildTextComposer(),
            ],
          );
        },
      ),
    );
  }

  Widget _commentListItem(DocumentSnapshot data, Size size) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(6, 2, 10, 2),
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: Image.asset(
                    'images/${data['postThumbnail']}',
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: size.width - 90,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          25.0,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              '${data['userName']}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              '${data['commentContent']}',
                              maxLines: null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4, top: 8),
                    child: SizedBox(
                      width: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            readTimestamp(
                              data['commentTimeStamp'],
                            ),
                          ),
                          Text(
                            'Like',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[500],
                            ),
                          ),
                          Text(
                            'Reply',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 10,
            right: 0,
            child: Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.thumb_up,
                      size: 20,
                      color: Colors.blue[400],
                    ),
                    Text(
                      '${widget.postData['postLikeCount']}',
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _TextCommentController,
                onSubmitted: _handleSubmitted,
                decoration: const InputDecoration.collapsed(
                  hintText: "Write a comment",
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 2.0),
              child: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    setState(() {
                      _TextCommentController.text = '';
                    });
                    _handleSubmitted(_TextCommentController.text);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSubmitted(String text) async {
    try {
      await CloudStore.commentToPost(
        widget.postData['postID'],
        _TextCommentController.text,
        widget.myData,
      );
      await updatePostCommentCount(widget.postData);
      FocusScope.of(context).requestFocus(FocusNode());

      _TextCommentController.text = '';
    } catch (e) {
      print('error to submit comment');
    }
  }
}
