import 'package:flutter/material.dart';

errorNotification(String message, BuildContext context) {
  return showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Color(0xFF0D101E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        title: Column(
          children: [
            Container(
              height: 270.0,
              width: 270.0,
              child: Image(
                image: AssetImage("assets/404.png"),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Text(
              "$message",
              style: TextStyle(
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        content: Icon(
          Icons.error,
          color: Colors.red,
        ),
        actions: <Widget>[
          Container(
            child: TextButton(
              child: Text(
                "OK",
                style: TextStyle(
                  color: Colors.lightBlue,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          )
        ],
      );
    },
  );
}
