import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FBStorage {
  static Future uploadPostImages(
      {required String postID, required File postImageFile}) async {
    try {
      String fileName = 'images/$postID/postImage';
      Reference reference = FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = reference.putFile(postImageFile);
      uploadTask.snapshotEvents.listen((event) {
        print("${event.bytesTransferred}\t${event.totalBytes}");
      });
      var uploadPath = await uploadTask.snapshot.ref.getDownloadURL();
      return uploadPath;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
