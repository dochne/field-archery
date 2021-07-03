import 'package:flutter/material.dart';

Future<String?> inputDialog(BuildContext context, TextEditingController _textFieldController, String label) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(label),
          content: TextField(
            key: Key('text'),
            controller: _textFieldController,
            // decoration: InputDecoration(hintText: "Text Field in Dialog"),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              // color: Colors.green,
              // textColor: Colors.white,
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context, _textFieldController.text);
              },
            ),
          ],
        );
      }
  );
}