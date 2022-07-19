import 'package:flutter/material.dart';

class CommentSection extends StatefulWidget {
  // final String title;
  const CommentSection({
    Key? key,
    // required this.title,
  }) : super(key: key);

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(widget.title),
        title: const Text('Comment Section'),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
