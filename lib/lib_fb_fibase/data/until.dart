import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dattings/lib_fb_fibase/controller/CloudStore.dart';
import 'package:dattings/lib_fb_fibase/controller/localTempDB.dart';
import 'package:dattings/lib_fb_fibase/data/const.dart';
import 'package:flutter/material.dart';

String readTimestamp(int timestamp) {
  var now = DateTime.now();
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  var diff = now.difference(date);
  var time = '';

  if (diff.inSeconds <= 0 ||
      diff.inSeconds > 0 && diff.inMinutes == 0 ||
      diff.inMinutes > 0 && diff.inHours == 0 ||
      diff.inHours > 0 && diff.inDays == 0) {
    if (diff.inHours > 0) {
      time = '${diff.inHours} giờ';
    } else if (diff.inMinutes > 0) {
      time = '${diff.inMinutes} phút';
    } else if (diff.inSeconds > 0) {
      time = 'Vừa xong';
    } else if (diff.inMilliseconds > 0) {
      time = 'Vừa xong';
    } else if (diff.inMicroseconds > 0) {
      time = 'Vừa xong';
    } else {
      time = 'Vừa xong';
    }
  } else if (diff.inDays > 0 && diff.inDays < 7) {
    time = '${diff.inDays} ngày trước';
  } else if (diff.inDays > 6) {
    time = '${(diff.inDays / 7).floor()} tuần trước';
  } else if (diff.inDays > 29) {
    time = '${(diff.inDays / 30).floor()} tháng trước';
  } else if (diff.inDays > 365) {
    time = '${date.month}' '${date.day}' '${date.year}';
  }
  return time;
}

Widget cacheNetworkImageWithEvent(
    context, String imageURL, double width, double height) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: CachedNetworkImage(
        imageUrl: imageURL,
        placeholder: (context, url) => Container(
          transform: Matrix4.translationValues(0.0, 0.0, 0.0),
          child: SizedBox(
            width: width,
            height: height,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        width: 500,
        height: 500,
        fit: BoxFit.cover,
      ),
    ),
  );
}

List<DocumentSnapshot> sortDocumentsByComment(List<DocumentSnapshot> data) {
  List<DocumentSnapshot> _originalData = data;
  Map<String, List<DocumentSnapshot>> commentDocuments =
      Map<String, List<DocumentSnapshot>>();
  List<int> replyCommentIndex = <int>[];
  for (int i = 0; i < _originalData.length; i++) {}

  replyCommentIndex.sort((a, b) {
    return b.compareTo(a);
  });

  return _originalData;
}

Future<MyProfileData> updateLikeCount(
    DocumentSnapshot data,
    bool isLikePost,
    MyProfileData myProfileData,
    ValueChanged<MyProfileData> updateMyData,
    bool isThread) async {
  List<String> newLikeList = await LocalTempDB.saveLikeList(
      data[isThread ? 'postID' : 'commentID'],
      myProfileData.myLikeList,
      isLikePost,
      isThread ? 'likeList' : 'likeCommnetList');
  MyProfileData myNewProfileData = MyProfileData(
      myName: myProfileData.myName,
      myThumbnail: myProfileData.myThumbnail,
      myLikeList: isThread ? newLikeList : myProfileData.myLikeList,
      myLikeCommnetList:
          isThread ? myProfileData.myLikeCommnetList : newLikeList);
  updateMyData(myNewProfileData);
  isThread
      ? await updatePostLikeCount(data, isLikePost, myProfileData)
      : await updateCommentLikeCount(data, isLikePost, myProfileData);
  if (isThread) {
    await likeToPost(data['postID'], myProfileData, isLikePost);
  }
  return myNewProfileData;
}

String commentWithoutReplyUser(String commentString) {
  List<String> splitCommentString = commentString.split(' ');
  int commentUserNameLength = splitCommentString[0].length;
  String returnText =
      commentString.substring(commentUserNameLength, commentString.length);
  return returnText;
}

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => chars.codeUnitAt(Random().nextInt(chars.length))));
