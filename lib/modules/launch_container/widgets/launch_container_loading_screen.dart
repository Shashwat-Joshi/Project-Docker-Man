import 'dart:async';
import 'package:dockerman/data/user_data.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LaunchContainerLoadingScreen extends StatefulWidget {
  final String containerName, imageName;
  LaunchContainerLoadingScreen(
    this.containerName,
    this.imageName,
  );
  @override
  _LaunchContainerLoadingScreenState createState() =>
      _LaunchContainerLoadingScreenState();
}

class _LaunchContainerLoadingScreenState
    extends State<LaunchContainerLoadingScreen> {
  var response;
  String animationName = "idle";
  @override
  void initState() {
    super.initState();
    launchContainer();
  }

  launchContainer() async {
    var url =
        "http://$ip/cgi-bin/launchContainer.py?x=${widget.containerName}&y=${widget.imageName}";
    try {
      response = await http.get(url);
      setState(() {
        animationName = "success";
      });
    } catch (e) {
      setState(() {
        animationName = "fail";
      });
    }
    setState(() {
      output = output +
          " docker run -dit --name ${widget.containerName} ${widget.imageName}\n" +
          "${response.body}>";
    });

    Timer(Duration(seconds: 5), () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          color: Colors.white,
          height: size.height,
          width: size.width,
          child: FlareActor(
            "assets/rocket.flr",
            alignment: Alignment.center,
            fit: BoxFit.cover,
            sizeFromArtboard: true,
            animation: animationName,
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 40.0),
          width: size.width,
          alignment: Alignment.bottomCenter,
          child: Text(
            "*This may take some time, if the image is not downloaded",
            style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 17.0,
              color: Colors.blue[900],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
