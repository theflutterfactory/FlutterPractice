import 'package:flutter/material.dart';

class ImageSelector extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ImageSelectorState();
  }
}

class _ImageSelectorState extends State<ImageSelector> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        OutlineButton(
          borderSide: BorderSide(color: Theme.of(context).accentColor),
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.camera_alt),
              SizedBox(
                width: 5,
              ),
              Text('Add Image')
            ],
          ),
        )
      ],
    );
  }
}
