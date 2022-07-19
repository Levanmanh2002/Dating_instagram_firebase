import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dattings/datings/resources/stogare.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dattings/datings/model/user_model.dart' as model;

class AthuMethous {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('User').doc(currentUser.uid).get();
    return model.User.fromSnap(snap);
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Một số lỗi đã xảy ra";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file == null) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String photoUrl =
            await StorageMethods().uploadImage('profilePics', file, false);

        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          email: email,
          password: password,
          bio: bio,
          followers: [],
          following: [],
          photoUrl: photoUrl,
        );

        await _firestore.collection('User').doc(cred.user!.uid).set(
              user.toJson(),
            );

        res = 'success';
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'email-already-in-use') {
        res = 'Email đã được sử dụng';
      } else if (err.code == 'weak-password') {
        res = 'Mật khẩu quá yếu';
      } else if (err.code == 'invalid-email') {
        res = 'Email không hợp lệ';
      } else if (err.code == 'user-not-found') {
        res = 'Không tìm thấy người dùng';
      } else if (err.code == 'user-disabled') {
        res = 'Người dùng bị vô hiệu hóa';
      } else if (err.code == 'wrong-password') {
        res = 'Sai mật khẩu';
      } else {
        res = 'Một số lỗi đã xảy ra';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
