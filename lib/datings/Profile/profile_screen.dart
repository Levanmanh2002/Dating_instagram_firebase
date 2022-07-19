import 'package:dattings/datings/Profile/edit_profile.dart';
import 'package:dattings/datings/Profile/info_section.dart';
import 'package:dattings/datings/models/data.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final User? user;
  final Data data;
  const ProfileScreen({
    Key? key,
    required this.data,
    required int index,
    this.user,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // var data = data;
  // final StreamController _streamController = StreamController();
  // String? token;

  // @override
  // void initState() {
  //   super.initState();
  //   getProfile();
  // }

  // Future getProfile() async {
  //   RemoteServices.getProfile('${await SPref.instance.get("userId")}')
  //       .then((value) {
  //     user = value;
  //     print(user.countFollower);
  //     _streamController.sink.add(value);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Center(
            child: InkWell(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                  widget.data.image,
                ),
              ),
            ),
          ),
          Text(
            widget.data.name,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          InfoSectionWidget(
            following: widget.data.countFollowing,
            follower: widget.data.countFollower,
            like: widget.data.countLike,
          ),
          const SizedBox(
            height: 5,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(MediaQuery.of(context).size.width * 0.3, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfileScreen(
                    data: widget.data,
                  ),
                ),
              );
            },
            child: const Text(
              "Sửa hồ sơ",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  void onGoBack(dynamic value) {
    setState(() {});
  }
}


// appBar: AppBar(
//         backgroundColor: Colors.black,
//         elevation: 0,
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(
//               Icons.logout,
//               color: Colors.black,
//             ),
//           )
//         ],
//       ),