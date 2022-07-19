import 'package:dattings/lib_fb_fibase/changeUserIcon.dart';
import 'package:dattings/lib_fb_fibase/data/const.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  final MyProfileData myData;
  final ValueChanged<MyProfileData> updateMyData;
  const UserProfile({
    Key? key,
    required this.myData,
    required this.updateMyData,
  }) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late String _myThumbnail;
  late String _myName;

  @override
  void initState() {
    _myName = widget.myData.myName;
    _myThumbnail = widget.myData.myThumbnail;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: <Widget>[
        Card(
          elevation: 2.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                          width: 40,
                          child: Image.asset('images/$_myThumbnail'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 3,
                          ),
                          child: Text(
                            'Change',
                            style: TextStyle(
                                color: Colors.blue[900],
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 0.03),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => ChangeUserIcon(myData: widget.myData),
                    barrierDismissible: true,
                  ).then((newMyThumbnail) {
                    _updateMyData(widget.myData.myName, newMyThumbnail);
                  });
                },
              ),
              GestureDetector(
                child: Text(
                  _myName,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  _showDialog();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _updateMyData(String newName, String newThumbnail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userName', newName);
    prefs.setString('postThumbnail', newThumbnail);
    setState(() {
      _myThumbnail = newThumbnail;
      _myName = newName;
    });
    MyProfileData newMyData = MyProfileData(
      myName: newName,
      myThumbnail: newThumbnail,
      myLikeCommnetList: widget.myData.myLikeCommnetList,
      myLikeList: widget.myData.myLikeList,
    );
    widget.updateMyData(newMyData);
  }

  void _showDialog() async {
    TextEditingController changeNameTextController = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Type your other nick name',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  hintText: '...',
                  icon: Icon(Icons.edit),
                ),
                controller: changeNameTextController,
              ),
            )
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              _updateMyData(
                changeNameTextController.text,
                widget.myData.myThumbnail,
              );
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
