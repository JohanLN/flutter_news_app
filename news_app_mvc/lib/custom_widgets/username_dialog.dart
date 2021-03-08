import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<String> createUsernameDialog(BuildContext context) {

  TextEditingController customController = TextEditingController();

  return showDialog(context: context, builder: (context) {
    return AlertDialog(
      title: Text("Change username"),
      content: TextField(
        controller: customController,
        decoration: InputDecoration(
            labelText: "Username",
            hintText: "ex: John Doe"
        ),
      ),
      actions: [
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel")),
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop(customController.text.toString());
            },
            child: Text("Submit"))
      ],
    );
  });

}