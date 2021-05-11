import 'package:dockerman/modules/launch_container/pages/launch_container_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LaunchContainerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width / 1.5,
      margin: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 40.0),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: Colors.blue,
        padding: EdgeInsets.fromLTRB(55.0, 10.0, 55.0, 10.0),
        child: Text(
          "Launch Container",
          style: TextStyle(
            fontSize: 17.0,
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => LaunchContainer(),
            ),
          );
        },
      ),
    );
  }
}
