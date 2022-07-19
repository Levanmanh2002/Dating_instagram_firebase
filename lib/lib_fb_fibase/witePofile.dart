// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dattings/lib_fb_fibase/controller/CloudStore.dart';
import 'package:dattings/lib_fb_fibase/controller/storage.dart';
import 'package:dattings/lib_fb_fibase/data/const.dart';
import 'package:dattings/lib_fb_fibase/data/until.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class WitePofile extends StatefulWidget {
  final MyProfileData myData;

  const WitePofile({
    Key? key,
    required this.myData,
  }) : super(key: key);

  @override
  State<WitePofile> createState() => _WitePofileState();
}

class _WitePofileState extends State<WitePofile> {
  TextEditingController writingTextController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  FocusNode writingTextFocus = FocusNode();
  bool _isLoading = false;
  File? imagePath;
  String imageName = "";
  final ImagePicker _picker = ImagePicker();

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(
          displayArrows: false,
          focusNode: _nodeText1,
        ),
        KeyboardActionsItem(
          displayArrows: false,
          focusNode: writingTextFocus,
          toolbarButtons: [
            (node) {
              return GestureDetector(
                onTap: () {
                  print('Select Image');
                  _getImageAndCrop();
                },
                child: Container(
                  color: Colors.grey[200],
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const <Widget>[
                      Icon(Icons.add_photo_alternate, size: 28),
                      Text(
                        "Add Image",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ],
        ),
      ],
    );
  }

  uploadPostImages() async {
    var uniqueKey = FirebaseFirestore.instance.collection("User").doc();
    String uploadFileName = "${DateTime.now().millisecondsSinceEpoch}.jpg";
    Reference reference =
        FirebaseStorage.instance.ref().child("User").child(uploadFileName);
    UploadTask uploadTask = reference.putFile(File(imagePath!.path));

    uploadTask.snapshotEvents.listen((event) {
      print("${event.bytesTransferred}\t${event.totalBytes}");
    });

    await uploadTask.whenComplete(() async {
      var uploadPath = await uploadTask.snapshot.ref.getDownloadURL();

      if (uploadPath.isNotEmpty) {
        FirebaseFirestore.instance.collection("User").doc(uniqueKey.id).set(
          {
            "postContent": writingTextController.text,
            "postImage": uploadPath,
          },
        ).then((value) => _showMessage("Hình ảnh được tải lên thành công"));
      } else {
        _showMessage("Đã xảy ra lỗi khi tải hình ảnh lên");
      }
    });
  }

  _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _postToFB() async {
    setState(() {
      _isLoading = true;
    });
    String postID = getRandomString(8) + Random().nextInt(500).toString();
    String postImageURL;
    if (imagePath != null) {
      String? postImageURL = await FBStorage.uploadPostImages(
        postID: postID,
        postImageFile: File(imagePath!.path),
      );
    }
    CloudStore.sendPostInFirebase(postID, writingTextController.text,
        widget.myData, postImageURL = 'NONE');

    setState(() {
      _isLoading = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image'),
        centerTitle: true,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              _postToFB();
            },
            child: const Text(
              'Save',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          KeyboardActions(
            config: _buildConfig(context),
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 28.0,
                    ),
                    Card(
                      color: const Color(0xFFF5F5F5),
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    SizedBox(
                      width: size.width,
                      height: size.height -
                          MediaQuery.of(context).viewInsets.bottom -
                          80,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 14.0, left: 10.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Image.asset(
                                        'images/${widget.myData.myThumbnail}',
                                      ),
                                    ),
                                  ),
                                  Text(
                                    widget.myData.myName,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                height: 1,
                                color: Colors.black,
                              ),
                              TextFormField(
                                autofocus: true,
                                focusNode: writingTextFocus,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Writing anything.',
                                  hintMaxLines: 4,
                                ),
                                controller: writingTextController,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: imagePath != null
                                      ? Image.file(
                                          File(imagePath!.path),
                                          fit: BoxFit.fill,
                                        )
                                      : Container(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _isLoading
              ? Positioned(
                  child: Container(
                    color: Colors.white.withOpacity(0.8),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Future<void> _getImageAndCrop() async {
    final imageFile = await _picker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        imagePath = File(imageFile.path);
      });
    }
  }
}
