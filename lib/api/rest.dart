import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:text_to_image/screens/second_screen.dart';
import 'package:text_to_image/utils/dialog.dart';

Future<dynamic> convertTextToImage(
  String prompt,
  BuildContext context,
) async {
  Uint8List imageData = Uint8List(0);

  const baseUrl = 'https://api.stability.ai';
  final url = Uri.parse(
    '$baseUrl/v1alpha/generation/stable-diffusion-512-v2-1/text-to-image',
  );

  // Make the HTTP POST request to the Stability Platform API
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization':
          //add your secret key here
          'Bearer sk-LYlRYbSGtUTZ5jItsuhGhAxvdcqjp0Bs4VgVg4f5dN7THd5r',
      'Accept': 'image/png',
    },
    body: jsonEncode({
      'cfg_scale': 15,
      'clip_guidance_preset': 'FAST_BLUE',
      'height': 512,
      'width': 512,
      'samples': 1,
      'steps': 150,
      'seed': 0,
      'style_preset': "3d-model",
      'text_prompts': [
        {
          'text': prompt,
          'weight': 1,
        }
      ],
    }),
  );

  if (response.statusCode == 200) {
    try {
      imageData = response.bodyBytes;

      // Save the image before navigating to SecondScreen
      await saveImage(imageData);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SecondScreen(image: imageData),
        ),
      );

      return response.bodyBytes;
    } on Exception {
      return showErrorDialog('Failed to generate image', context);
    }
  } else {
    return showErrorDialog('Failed to generate image', context);
  }
}

Future<void> saveImage(Uint8List imageBytes) async {
  try {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String imagePath = "${appDocDir.path}/generated_image.png";

    // Create a File instance
    final File imageFile = File(imagePath);

    // Write the imageBytes to the file
    await imageFile.writeAsBytes(imageBytes);

    print("Image saved successfully at: $imagePath");
  } catch (e) {
    // Handle any errors that might occur during image saving
    print("Error saving image: $e");
    // You may want to throw or handle the error accordingly
  }
}
