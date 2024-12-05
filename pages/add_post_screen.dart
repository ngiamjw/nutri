import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/camera/image_details_page.dart';
import 'package:insta_clone/camera/image_display_input.dart';
import 'package:insta_clone/database/firestore_methods.dart';
import 'package:insta_clone/providers/user_provider.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:insta_clone/utils/utils.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  Map<String, dynamic>? _response;
  bool isLoading = false;
  final TextEditingController _descriptionController = TextEditingController();

  _selectImage(BuildContext parentContext) async {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Create a Post'),
          children: <Widget>[
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  setState(() {
                    isLoading = true;
                  });
                  Uint8List file = await pickImage(ImageSource.camera);
                  Map<String, dynamic> response = await uploadImage(file);
                  setState(() {
                    _file = file;
                    _response = response;
                    isLoading = false;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ImageDetailsPage(
                            image: _file!,
                            response: response,
                            daily_calories: 0,
                            daily_carbs: 0,
                            daily_fats: 0,
                            daily_protein: 0)),
                  );
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  setState(() {
                    isLoading = true;
                  });
                  Uint8List file = await pickImage(ImageSource.gallery);
                  Map<String, dynamic> response = await uploadImage(file);
                  setState(() {
                    _file = file;
                    _response = response;
                    isLoading = false;
                  });
                }),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : _file == null
            ? Center(
                child: IconButton(
                  icon: const Icon(
                    Icons.upload,
                    size: 40,
                  ),
                  onPressed: () => _selectImage(context),
                ),
              )
            : ImageDetailsPage(
                image: _file!,
                response: _response!,
                daily_calories: 0,
                daily_carbs: 0,
                daily_fats: 0,
                daily_protein: 0);
  }
}
