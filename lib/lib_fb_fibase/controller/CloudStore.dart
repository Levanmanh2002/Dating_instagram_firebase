import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dattings/lib_fb_fibase/data/const.dart';

class CloudStore {
  static Future<void> sendPostInFirebase(String postID, String postContent,
      MyProfileData userProfile, String uploadPath) async {
    FirebaseFirestore.instance.collection('User').doc(postID).set({
      'postID': postID,
      'userName': userProfile.myName,
      'postThumbnail': userProfile.myThumbnail,
      'postTimeStamp': DateTime.now().millisecondsSinceEpoch,
      'postContent': postContent,
      'postImage': uploadPath,
      'postLikeCount': 0,
      'postCommentCount': 0,
    });
  }

  static Future<void> commentToPost(
      String postID, String commentContent, MyProfileData userProfile) async {
    FirebaseFirestore.instance
        .collection('User')
        .doc(postID)
        .collection('comment')
        .doc()
        .set({
      'postID': postID,
      'userName': userProfile.myName,
      'postThumbnail': userProfile.myThumbnail,
      'commentTimeStamp': DateTime.now().millisecondsSinceEpoch,
      'commentContent': commentContent,
      'commentLikeCount': 0,
    });
  }
}

Future<void> updatePostCommentCount(
  DocumentSnapshot postData,
) async {
  postData.reference.update({'postCommentCount': FieldValue.increment(1)});
}

// Future<void> updateCommentLikeCount(DocumentSnapshot postData, bool isLikePost,
//     MyProfileData myProfileData) async {
//   postData.reference
//       .update({'commentLikeCount': FieldValue.increment(isLikePost ? -1 : 1)});
//   if (!isLikePost) {
//     await FBCloudMessaging.instance.sendNotificationMessageToPeerUser(
//         '${myProfileData.myName} likes your comment',
//         '${myProfileData.myName}',
//         postData['FCMToken']);
//   }
// }

Future<void> likeToPost(
    String postID, MyProfileData userProfile, bool isLikePost) async {
  if (isLikePost) {
    DocumentReference likeReference = FirebaseFirestore.instance
        .collection('User')
        .doc(postID)
        .collection('like')
        .doc(userProfile.myName);
    await FirebaseFirestore.instance
        .runTransaction((Transaction myTransaction) async {
      myTransaction.delete(likeReference);
    });
  } else {
    await FirebaseFirestore.instance
        .collection('User')
        .doc(postID)
        .collection('like')
        .doc(userProfile.myName)
        .set({
      'userName': userProfile.myName,
      'userThumbnail': userProfile.myThumbnail,
    });
  }
}

Future<void> updatePostLikeCount(DocumentSnapshot postData, bool isLikePost,
    MyProfileData myProfileData) async {
  postData.reference
      .update({'postLikeCount': FieldValue.increment(isLikePost ? -1 : 1)});
  if (!isLikePost) {
    // await FBCloudMessaging.instance.sendNotificationMessageToPeerUser(
    //     '${myProfileData.myName} likes your post',
    //     '${myProfileData.myName}',
    //     postData['FCMToken']);
  }
}

Future<void> updateCommentLikeCount(DocumentSnapshot postData, bool isLikePost,
    MyProfileData myProfileData) async {
  postData.reference
      .update({'commentLikeCount': FieldValue.increment(isLikePost ? -1 : 1)});
  // if (!isLikePost) {
  //   await FBCloudMessaging.instance.sendNotificationMessageToPeerUser(
  //       '${myProfileData.myName} likes your comment',
  //       '${myProfileData.myName}',
  //       postData['FCMToken']);
  // }
}
