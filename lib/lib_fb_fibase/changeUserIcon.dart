import 'package:dattings/lib_fb_fibase/data/const.dart';
import 'package:flutter/material.dart';

class ChangeUserIcon extends StatefulWidget {
  final MyProfileData myData;
  const ChangeUserIcon({
    Key? key,
    required this.myData,
  }) : super(key: key);

  @override
  State<ChangeUserIcon> createState() => _ChangeUserIconState();
}

class _ChangeUserIconState extends State<ChangeUserIcon> {
  late String myThumbnail;

  @override
  void initState() {
    myThumbnail = widget.myData.myThumbnail;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(children: <Widget>[
      SimpleDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16.0),
            ),
          ),
          contentPadding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              width: size.width,
              height: size.height - size.height * 0.12,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.count(
                  crossAxisCount: 6,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  padding: const EdgeInsets.all(8.0),
                  childAspectRatio: size.width * 0.00174,
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  children: iconImageList.map(_makeGridTile).toList(),
                ),
              ),
            )
          ]),
      Positioned(
        bottom: 10,
        right: 10,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 2.0, right: 2.0),
              child: ClipOval(
                child: Container(
                  color: Colors.red,
                  height: 60.0,
                  width: 60.0,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, myThumbnail);
                    },
                    child: const Icon(
                      Icons.close,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      )
    ]);
  }

  Widget _makeGridTile(String userIconPath) {
    return GridTile(
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            color: userIconPath == myThumbnail ? Colors.yellow : Colors.white,
            border: userIconPath == myThumbnail
                ? Border.all(width: 3, color: Colors.red)
                : null,
          ),
          child: Image.asset(
            'images/$userIconPath',
          ),
        ),
        onTap: () {
          setState(() {
            myThumbnail = userIconPath;
          });
          print(userIconPath);
        },
      ),
    );
  }
}
