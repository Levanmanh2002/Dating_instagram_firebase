import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);

  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('No iamge selected');
}

showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

String readTimestamp(int timestamp) {
  var now = DateTime.now();
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  var diff = now.difference(date);
  var time = '';

  if (diff.inSeconds <= 0 ||
      diff.inSeconds > 0 && diff.inMinutes == 0 ||
      diff.inMinutes > 0 && diff.inHours == 0 ||
      diff.inHours > 0 && diff.inDays == 0) {
    if (diff.inHours > 0) {
      time = '${diff.inHours} giờ';
    } else if (diff.inMinutes > 0) {
      time = '${diff.inMinutes} phút';
    } else if (diff.inSeconds > 0) {
      time = 'Vừa xong';
    } else if (diff.inMilliseconds > 0) {
      time = 'Vừa xong';
    } else if (diff.inMicroseconds > 0) {
      time = 'Vừa xong';
    } else {
      time = 'Vừa xong';
    }
  } else if (diff.inDays > 0 && diff.inDays < 7) {
    time = '${diff.inDays} ngày trước';
  } else if (diff.inDays > 6) {
    time = '${(diff.inDays / 7).floor()} tuần trước';
  } else if (diff.inDays > 29) {
    time = '${(diff.inDays / 30).floor()} tháng trước';
  } else if (diff.inDays > 365) {
    time = '${date.month}' '${date.day}' '${date.year}';
  }
  return time;
}
