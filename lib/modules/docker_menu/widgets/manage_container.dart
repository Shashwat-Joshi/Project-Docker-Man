import 'package:dockerman/modules/manage_containers/manage_containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ManageContainerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width / 1.5,
      margin: EdgeInsets.only(bottom: 20.0),
      child: MaterialButton(
        color: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        padding: EdgeInsets.fromLTRB(55.0, 10.0, 55.0, 10.0),
        child: Text(
          "Manage Containers",
          style: TextStyle(
            fontSize: 17.0,
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => ManageContainers(),
            ),
          );
        },
      ),
    );
  }
}
