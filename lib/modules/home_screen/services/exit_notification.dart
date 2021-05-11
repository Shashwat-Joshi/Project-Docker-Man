import 'dart:io';
import 'package:flutter/material.dart';

showExitNotification(BuildContext context) {
  return showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Color(0xFF192233),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        title: Column(
          children: [
            Icon(
              Icons.notification_important,
              color: Colors.red,
              size: 30.0,
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Text(
              "All the outputs will be erased. Are you sure you want to exit ?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: <Widget>[
          Container(
            child: TextButton(
              child: Text(
                "NO",
                style: TextStyle(
                  color: Colors.lightBlue,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Container(
            child: TextButton(
              child: Text(
                "YES",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onPressed: () {
                exit(0);
              },
            ),
          )
        ],
      );
    },
  );
}
