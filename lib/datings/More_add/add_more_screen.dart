// ignore_for_file: prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dattings/datings/More_add/acccess.dart';
import 'package:dattings/datings/home.dart';

import 'package:dattings/datings/resources/firestore_methods.dart';
import 'package:dattings/datings/utils/utils.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  TextEditingController textController = TextEditingController();
  String accessModifier = 'Công khai >';
  final formKey = GlobalKey<FormState>();
  String imageName = "";
  XFile? imagePath;
  final ImagePicker _picker = ImagePicker();

  FirebaseFirestore firestoreRef = FirebaseFirestore.instance;
  FirebaseStorage storageRef = FirebaseStorage.instance;
  String collectionName = "Users";
  bool _isLoading = false;
  Uint8List? _file;

  @override
  void initState() {
    super.initState();
    textController.addListener(
      () => setState(() {}),
    );
  }

  imagePicker() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        textController.text = '';
        imagePath = image;
        imageName = image.name;
      });
      Navigator.pop(context);
    }
  }

  _pickImageCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        textController.text = '';
        imagePath = image;
        imageName = image.name;
      });
      Navigator.pop(context);
    }
  }

  void _remove() {
    setState(() {
      imagePath == null;
    });
    Navigator.pop(context);
  }

  _uploadImage() async {
    setState(() {
      _isLoading = true;
    });
    var uniqueKey = firestoreRef.collection(collectionName).doc();
    String uploadFileName =
        DateTime.now().millisecondsSinceEpoch.toString() + ".jpg";
    Reference reference =
        storageRef.ref().child(collectionName).child(uploadFileName);
    UploadTask uploadTask = reference.putFile(File(imagePath!.path));

    uploadTask.snapshotEvents.listen((event) {
      print(event.bytesTransferred.toString() +
          "\t" +
          event.totalBytes.toString());
    });

    await uploadTask.whenComplete(() async {
      var uploadPath = await uploadTask.snapshot.ref.getDownloadURL();

      if (uploadPath.isNotEmpty) {
        firestoreRef.collection(collectionName).doc(uniqueKey.id).set(
          {
            "text": textController.text,
            "image": uploadPath,
          },
        ).then((value) => _showMessage("Hình ảnh được tải lên thành công"));
      } else {
        _showMessage("Đã xảy ra lỗi khi tải hình ảnh lên");
      }
      setState(() {
        _isLoading = false;
        textController.text = "";
        imageName = "";
      });
    });
    gotoHomePage();
  }

  void postImage(
    String uid,
    String username,
    String profImage,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FirestoreMethods().uploadPost(
        textController.text,
        _file!,
        uid,
        username,
        profImage,
      );
      if (res == 'success') {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(
          context,
          'Đã đăng!',
        );
      } else {
        showSnackBar(context, res);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }

  _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void gotoHomePage() {
    print('Thành công');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeAppDatings(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final User user = Provider.of<UserProvider>(context).getUser;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: Colors.white,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            toolbarHeight: 40,
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  onPrimary:
                      textController.text.isEmpty ? Colors.grey : Colors.white,
                  elevation: 0,
                  primary: textController.text.isEmpty
                      ? Colors.grey[200]
                      : Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: _uploadImage,
                child: const Text(
                  "Đăng",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
            leading: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Hủy",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: textController,
                      autofocus: true,
                      cursorColor: Colors.black,
                      minLines: 5,
                      maxLines: 10,
                      maxLength: 1000,
                      decoration: const InputDecoration(
                        hintText: 'Bạn đang nghĩ gì ?',
                        border: InputBorder.none,
                      ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                      "Tùy chọn",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.purple,
                                      ),
                                    ),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: [
                                          InkWell(
                                            onTap: () => _pickImageCamera(),
                                            splashColor: Colors.purpleAccent,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.camera,
                                                    color: Colors.purpleAccent,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Máy ảnh",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.purpleAccent,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () => imagePicker(),
                                            splashColor: Colors.purpleAccent,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.image,
                                                    color: Colors.purpleAccent,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Chọn ảnh",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.purpleAccent,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              _remove();
                                            },
                                            splashColor: Colors.purpleAccent,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Hủy",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.image),
                            splashColor: Colors.white,
                          ),
                        ),
                        ElevatedButton.icon(
                          icon: Icon(
                            (accessModifier == 'Công khai >')
                                ? Icons.public
                                : (accessModifier == 'Chỉ bạn bè >')
                                    ? CupertinoIcons.person_2
                                    : CupertinoIcons.lock,
                            size: 16,
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.grey[200],
                              elevation: 0,
                              onPrimary: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                          onPressed: () {
                            _showMobalBottomSheet(context);
                          },
                          label: Text(
                            accessModifier,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _showMobalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  child: const Icon(CupertinoIcons.chevron_compact_down),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Ai có thể xem bài đăng này ?",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 6,
                ),
                Access(
                  accessModifier: accessModifier,
                  detailTextAccess: 'Mọi người có thể thấy',
                  onclicked: () {
                    setState(
                      () {
                        accessModifier = 'Công khai >';
                        Navigator.pop(context);
                      },
                    );
                  },
                  textAccess: 'Công khai',
                  valueAccess: 'Công khai >',
                ),
                Access(
                  accessModifier: accessModifier,
                  detailTextAccess: 'Những người đã theo dõi nhau có thể thấy',
                  onclicked: () {
                    setState(() {
                      accessModifier = 'Chỉ bạn bè >';
                      Navigator.pop(context);
                    });
                  },
                  textAccess: 'Chỉ bạn bè',
                  valueAccess: 'Chỉ bạn bè >',
                ),
                Access(
                  accessModifier: accessModifier,
                  detailTextAccess: 'Chỉ tôi',
                  onclicked: () {
                    setState(() {
                      accessModifier = 'Riêng tư >';
                      Navigator.pop(context);
                    });
                  },
                  textAccess: 'Riêng tư',
                  valueAccess: 'Riêng tư >',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
