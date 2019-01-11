import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelector extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ImageSelectorState();
  }
}

class _ImageSelectorState extends State<ImageSelector> {
  Widget _buildImageSourceButton(String buttonText, ImageSource source) {
    return FlatButton(
      textColor: Theme.of(context).primaryColor,
      child: Text(
        buttonText,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      onPressed: () => ImagePicker.pickImage(
            source: source,
            maxWidth: 400,
          ).then((File iamge) {
            Navigator.pop(context);
          }),
    );
  }

  void _openImagePicker() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                SizedBox(height: 16),
                Text('Pick an Image'),
                SizedBox(height: 16),
                _buildImageSourceButton('Use Camera', ImageSource.camera),
                SizedBox(height: 8),
                _buildImageSourceButton('Use Gallery', ImageSource.gallery),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        OutlineButton(
          borderSide: BorderSide(color: Theme.of(context).accentColor),
          onPressed: () => _openImagePicker(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.camera_alt),
              SizedBox(width: 5),
              Text('Add Image'),
            ],
          ),
        )
      ],
    );
  }
}
