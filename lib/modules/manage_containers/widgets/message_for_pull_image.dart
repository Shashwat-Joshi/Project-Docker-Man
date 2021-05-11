import 'package:flutter/material.dart';

showMessageForPullImage(BuildContext context) {
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
            Container(
              height: 250.0,
              width: 250.0,
              child: Image(
                image: AssetImage("assets/downloading.png"),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Text(
              "Downloading the image might take some time",
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        content: Icon(
          Icons.cloud_download,
          color: Colors.green,
          size: 30.0,
        ),
        actions: <Widget>[
          Container(
            child: FlatButton(
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
