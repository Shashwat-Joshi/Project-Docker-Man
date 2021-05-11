import 'package:dockerman/modules/home_screen/pages/home_page.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  goToHomePage() {
    Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (context) => HomePage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        color: Colors.white,
        height: size.height,
        width: size.width,
        child: FlareActor(
          "assets/musicApp.flr",
          alignment: Alignment.center,
          fit: BoxFit.contain,
          sizeFromArtboard: true,
          animation: "Untitled",
          callback: (name) => goToHomePage(),
        ),
      ),
    );
  }
}
