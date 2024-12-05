import 'package:flutter/material.dart';

class ImageDisplayInput extends StatelessWidget {
  final String title;
  TextEditingController mycontroller;
  ImageDisplayInput(
      {super.key, required this.title, required this.mycontroller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("$title:", style: TextStyle(fontSize: 20, color: Colors.white)),
        SizedBox(width: 10),
        SizedBox(
          width: 70,
          child: TextField(
            controller: mycontroller,
            style: TextStyle(color: Colors.white),
            keyboardType: TextInputType.numberWithOptions(),
            decoration: InputDecoration(
              hintText: title,
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue.shade500),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
