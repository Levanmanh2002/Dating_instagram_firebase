import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dattings/lib_fb_fibase/data/const.dart';
import 'package:dattings/lib_fb_fibase/data/until.dart';
import 'package:flutter/material.dart';

class ThreadItem extends StatefulWidget {
  final BuildContext parentContext;
  final DocumentSnapshot data;
  final MyProfileData myData;
  final ValueChanged<MyProfileData> updateMyDataToMain;
  final bool isFromThread;
  final Function threadItemAction;
  final int commentCount;
  const ThreadItem({
    Key? key,
    required this.data,
    required this.myData,
    required this.updateMyDataToMain,
    required this.threadItemAction,
    required this.isFromThread,
    required this.commentCount,
    required this.parentContext,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ThreadItem();
}

class _ThreadItem extends State<ThreadItem> {
  late MyProfileData _currentMyData;
  late int _likeCount;
  @override
  void initState() {
    _currentMyData = widget.myData;
    _likeCount = widget.data['postLikeCount'];
    super.initState();
  }

  void _updateLikeCount(bool isLikePost) async {
    MyProfileData newProfileData = await updateLikeCount(
        widget.data,
        widget.myData.myLikeList != null &&
                widget.myData.myLikeList.contains(widget.data['postID'])
            ? true
            : false,
        widget.myData,
        widget.updateMyDataToMain,
        true);
    setState(() {
      _currentMyData = newProfileData;
    });
    setState(() {
      isLikePost ? _likeCount-- : _likeCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 6),
      child: Card(
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () => widget.isFromThread
                    ? widget.threadItemAction(widget.data)
                    : null,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(6.0, 2.0, 10.0, 2.0),
                      child: SizedBox(
                        width: 48,
                        height: 48,
                        child: Image.asset(
                          'images/${widget.data['postThumbnail']}',
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.data['userName'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            readTimestamp(widget.data['postTimeStamp']),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    PopupMenuButton<int>(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 1,
                          child: Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(right: 8.0, left: 8.0),
                                child: Icon(Icons.report),
                              ),
                              Text("Report"),
                            ],
                          ),
                        ),
                      ],
                      initialValue: 1,
                      onCanceled: () {
                        print("You have canceled the menu.");
                      },
                      onSelected: (value) {
                        // showDialog(
                        //     context: widget.parentContext,
                        //     builder: (BuildContext context) => ReportPost(
                        //           postUserName: widget.data['userName'],
                        //           postId: widget.data['postID'],
                        //           content: widget.data['postContent'],
                        //           reporter: widget.myData.myName,
                        //         ));
                      },
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => widget.isFromThread
                    ? widget.threadItemAction(widget.data)
                    : null,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 10, 4, 10),
                  child: Text(
                    (widget.data['postContent'] as String).length > 200
                        ? '${widget.data['postContent'].substring(0, 132)} ...'
                        : widget.data['postContent'],
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    maxLines: 3,
                  ),
                ),
              ),
              widget.data['postImage'] != 'NONE'
                  ? GestureDetector(
                      onTap: () => widget.isFromThread
                          ? widget.threadItemAction(widget.data)
                          : widget.threadItemAction(),
                      child: cacheNetworkImageWithEvent(
                          context, widget.data['postImage'], 0, 0),
                    )
                  : Container(),
              const Divider(
                height: 2,
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6.0, bottom: 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        _updateLikeCount(
                          _currentMyData.myLikeList != null &&
                                  _currentMyData.myLikeList
                                      .contains(widget.data['postID'])
                              ? true
                              : false,
                        );
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.thumb_up,
                            size: 18,
                            color: widget.myData.myLikeList != null &&
                                    widget.myData.myLikeList.contains(
                                      widget.data['postID'],
                                    )
                                ? Colors.blue[900]
                                : Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Like ( ${widget.isFromThread ? widget.data['postLikeCount'] : _likeCount} )',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: widget.myData.myLikeList != null &&
                                        widget.myData.myLikeList.contains(
                                          widget.data['postID'],
                                        )
                                    ? Colors.blue[900]
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => widget.isFromThread
                          ? widget.threadItemAction(widget.data)
                          : null,
                      child: Row(
                        children: <Widget>[
                          const Icon(Icons.mode_comment, size: 18),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Comments ( ${widget.commentCount} )',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
