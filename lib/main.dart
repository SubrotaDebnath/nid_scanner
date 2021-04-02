import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'details.dart';

main() async {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _text = '';
  PickedFile _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade700,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        elevation: 5.0,
        title: Text('NID Scanner'),
        actions: [
          TextButton(
            onPressed: scanText,
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              child: Text(
                'Scan',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey.shade900,
        elevation: 3.0,
        onPressed: getImage,
        child: Icon(Icons.add_a_photo),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: _image != null
            ? Image.file(
                File(_image.path),
                fit: BoxFit.fitWidth,
              )
            : Container(),
      ),
    );
  }

  Future scanText() async {
    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(File(_image.path));
    final TextRecognizer textRecognizer =
        FirebaseVision.instance.textRecognizer();
    final VisionText visionText =
        await textRecognizer.processImage(visionImage);

    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        _text += line.text + '\n';
      }
    }

    Navigator.of(context).pop();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Details(_text)));
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;
      } else {
        print('No image selected');
      }
    });
  }
}
