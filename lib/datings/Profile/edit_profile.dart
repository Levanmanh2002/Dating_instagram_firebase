// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:dattings/datings/models/Information.dart';
import 'package:dattings/datings/models/data.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  final Data data;
  const EditProfileScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final StreamController _streamController = StreamController();

  final TextEditingController _fullNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              height: MediaQuery.of(context).size.height * 0.3,
              child: Image.asset('assets/images/avatar.jpg'),
            ),

            const SizedBox(height: 10),
            LineEditProfile(
              textTitle: "Họ và tên",
              textContent: widget.data.name,
              onClicked: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return editDialog(
                      context,
                      "Họ và tên",
                      "Nhập Họ và Tên",
                      "fullName",
                    );
                  },
                );
              },
            ),
            LineEditProfile(
              textTitle: "Chiều cao",
              textContent: widget.data.height.toString(),
              onClicked: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return editDialog(
                      context,
                      "Chiều cao",
                      "Nhập Chiều cao",
                      "height",
                    );
                  },
                );
              },
            ),
            LineEditProfile(
              textTitle: "Link Facebook",
              textContent: widget.data.linkFb,
              onClicked: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return editDialog(
                      context,
                      "Link Facebook",
                      "Nhập Link Facebook",
                      "linkFb",
                    );
                  },
                );
              },
            ),
            LineEditProfile(
              textTitle: "Link Instagram",
              textContent: widget.data.linkInstagram,
              onClicked: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return editDialog(
                      context,
                      "Link Instagram",
                      "Nhập Link Instagram",
                      "linkIs",
                    );
                  },
                );
              },
            ),
            LineEditProfile(
              textTitle: "Zalo",
              textContent: widget.data.zlPhone,
              onClicked: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return editDialog(
                      context,
                      "Zalo",
                      "Nhập Zalo",
                      "zlPhone",
                    );
                  },
                );
              },
            ),
            LineEditProfile(
              textTitle: "Nghề nghiệp",
              textContent: widget.data.job,
              onClicked: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return editDialog(
                      context,
                      "Nghề nghiệp",
                      "Nhập Nghề nghiệp",
                      "job",
                    );
                  },
                );
              },
            ),
            // textInfor("Giới thiệu:"),
            const SizedBox(
              height: 5,
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return editDialog(
                      context,
                      "Giới thiệu",
                      "Nhập Giới thiệu",
                      "About",
                    );
                  },
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.blue,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Text(
                  widget.data.address,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     Container(
            //       padding: const EdgeInsets.only(left: 11),
            //       width: double.infinity,
            //       // child: DropdownButton<String>(
            //       //   hint: const Text("Tỉnh/Thành phố"),
            //       //   value: widget.data.address,
            //       //   items:
            //       //       Information.listProvince.map(buildMenuAddress).toList(),
            //       //   onChanged: (newValue) {
            //       //     setState(() {});
            //       //   },
            //       // ),
            //     ),
            //     Container(
            //       padding: const EdgeInsets.only(left: 11),
            //       width: double.infinity,
            //       decoration: boderDropDown(),
            //       child: DropdownButton<String>(
            //         hint: const Text("Thu nhập"),
            //         value: widget.data.income,
            //         items:
            //             Information.listIncome.map(buildMenuAddress).toList(),
            //         onChanged: (newValue) {
            //           setState(() {});
            //         },
            //       ),
            //     ),
            //   ],
            // ),
            const SizedBox(height: 10),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     Container(
            //       padding: const EdgeInsets.only(left: 11),
            //       // width: double.infinity,
            //       decoration: boderDropDown(),
            //       child: DropdownButton<String>(
            //         hint: const Text("Hôn nhân"),
            //         value: widget.data.marriage,
            //         items:
            //             Information.listMarriage.map(buildMenuAddress).toList(),
            //         onChanged: (newValue) {},
            //       ),
            //     ),
            //     Container(
            //       padding: const EdgeInsets.only(left: 11),
            //       decoration: boderDropDown(),
            //       child: DropdownButton<String>(
            //         hint: const Text("Con cái"),
            //         value: widget.data.children,
            //         items:
            //             Information.listChildren.map(buildMenuAddress).toList(),
            //         onChanged: (newValue) {},
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 10),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     Container(
            //       padding: const EdgeInsets.only(left: 11),
            //       // width: double.infinity,
            //       decoration: boderDropDown(),
            //       child: DropdownButton<String>(
            //         hint: const Text("Chỗ ở"),
            //         value: widget.data.home,
            //         items: Information.listHome.map(buildMenuAddress).toList(),
            //         onChanged: (newValue) {
            //           setState(() {
            //             widget.data.home;
            //             updateLineProfile('Home', '$newValue');
            //           });
            //         },
            //       ),
            //     ),
            //     Container(
            //       padding: const EdgeInsets.only(left: 11),
            //       // width: double.infinity,
            //       decoration: boderDropDown(),
            //       child: DropdownButton<String>(
            //         hint: const Text("Cung hoàng đạo"),
            //         value: widget.data.zodiac,
            //         items: Information.listZodiac.map(buildMenuAddress).toList(),
            //         onChanged: (newValue) {
            //           setState(() {
            //             widget.data.zodiac;
            //             updateLineProfile('Zodiac', '$newValue');
            //           });
            //         },
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 10),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     Container(
            //       padding: const EdgeInsets.only(left: 11),
            //       // width: double.infinity,
            //       decoration: boderDropDown(),
            //       child: DropdownButton<String>(
            //         hint: const Text("Mục tiêu"),
            //         value: widget.data.target,
            //         items: Information.listTarget.map(buildMenuAddress).toList(),
            //         onChanged: (newValue) {
            //           setState(() {
            //             widget.data.target;
            //             updateLineProfile('target', '$newValue');
            //           });
            //         },
            //       ),
            //     ),
            //     Container(
            //       padding: const EdgeInsets.only(left: 11),
            //       // width: double.infinity,
            //       decoration: boderDropDown(),
            //       child: DropdownButton<String>(
            //         hint: const Text("Trạng thái"),
            //         value: widget.data.status,
            //         items: Information.listStatus.map(buildMenuAddress).toList(),
            //         onChanged: (newValue) {
            //           setState(() {
            //             widget.data.status;
            //             updateLineProfile('Status', '$newValue');
            //           });
            //         },
            //       ),
            //     ),
            //   ],
            // ),
            const SizedBox(height: 10),
            // Container(
            //   padding: const EdgeInsets.only(left: 11),
            //   // width: double.infinity,
            //   decoration: boderDropDown(),
            //   child: DropdownButton<String>(
            //     hint: const Text("Hình thức"),
            //     value: widget.data.formality,
            //     items: Information.listFormality.map(buildMenuAddress).toList(),
            //     onChanged: (newValue) {
            //       setState(() {
            //         widget.data.formality;
            //         updateLineProfile('Formality', '$newValue');
            //       });
            //     },
            //   ),
            // ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

AlertDialog editDialog(
    BuildContext context, String title, String hintText, String key) {
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    title: Center(child: Text(title)),
    content: SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextField(
            keyboardType: (title == "Chiều cao") ? TextInputType.number : null,
            autofocus: true,
            decoration: InputDecoration(hintText: hintText),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.red),
                onPressed: () {},
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Ok"),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

class LineEditProfile extends StatelessWidget {
  final String? textTitle;
  final String? textContent;
  final VoidCallback? onClicked;
  const LineEditProfile({
    Key? key,
    this.textTitle,
    this.textContent,
    this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            minimumSize: const Size.fromHeight(50),
            onPrimary: Colors.black),
        onPressed: onClicked,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                margin: const EdgeInsets.only(right: 20),
                child: Text(textTitle.toString())),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SingleChildScrollView(
                  child: Text(textContent.toString()),
                ),
                const SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey[400],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

BoxDecoration boderDropDown() {
  return BoxDecoration(
    borderRadius: const BorderRadius.all(Radius.circular(6)),
    shape: BoxShape.rectangle,
    border: Border.all(
      color: Colors.black54,
      width: 1,
    ),
  );
}

DropdownMenuItem<String> buildMenuAddress(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
      ),
    );

Text textInfor(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
  );
}
