import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// for picking up image from gallery
pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  }
}

// for displaying snackbars
showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

Future<Map<String, dynamic>> uploadImage(Uint8List pickedFile) async {
  // Convert XFile to File using the file path

  final jsonSchema = Schema.object(
    properties: {
      'name': Schema.string(),
      'calories': Schema.integer(),
      'protein': Schema.integer(),
      'carbs': Schema.integer(),
      'fats': Schema.integer(),
    },
  );

  // Create InlineDataPart using the image bytes
  final InlineDataPart imagePart = InlineDataPart(
    'image/jpeg', // MIME type of the image
    pickedFile, // Image data in bytes
  );
  final model = FirebaseVertexAI.instance.generativeModel(
      model: 'gemini-1.5-flash', // Replace with your model name
      generationConfig: GenerationConfig(
          responseMimeType: 'application/json', // Specify JSON response
          responseSchema: jsonSchema));

  final prompt =
      "The image is a dish. Give me the name of the dish and its nutrition contents, calories, protein, carbs and fats. [IMAGE]";

  final contentList = [
    Content.text(prompt),
    Content.multi([imagePart])
  ];

  final response = await model.generateContent(contentList);

  // Process the generated structured response (JSON format)
  final Map<String, dynamic> responseMap = jsonDecode(response.text!);

  return responseMap;
}
