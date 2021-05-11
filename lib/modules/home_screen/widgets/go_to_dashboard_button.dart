import 'package:dockerman/data/user_data.dart';
import 'package:dockerman/modules/ip_screen/pages/enter_ip_ui.dart';
import 'package:flutter/material.dart';

goToDashboardButton(Size size, BuildContext context) {
  return Container(
    margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 30.0),
    width: size.width,
    child: MaterialButton(
      padding: EdgeInsets.fromLTRB(50.0, 15.0, 50.0, 15.0),
      color: Colors.lightBlue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        "Go to Dashboard",
        style: TextStyle(
          fontSize: 17.0,
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ip == null ? EnterIP() : EnterIP(),
          ),
        );
      },
    ),
  );
}
