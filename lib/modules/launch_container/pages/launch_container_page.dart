import 'package:dockerman/helpers/unfocus.dart';
import 'package:dockerman/modules/batman_terminal/pages/batman.dart';
import 'package:dockerman/modules/launch_container/theme/local_theme.dart';
import 'package:dockerman/modules/launch_container/widgets/launch_container_loading_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LaunchContainer extends StatefulWidget {
  @override
  _LaunchContainerState createState() => _LaunchContainerState();
}

class _LaunchContainerState extends State<LaunchContainer> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool isValidated;

  @override
  Widget build(BuildContext context) {
    String _imageName, _containerName;
    var size = MediaQuery.of(context).size;

    launchContainer() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (builder) => LaunchContainerLoadingScreen(
            _containerName,
            _imageName,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          child: Container(
            color: Colors.white.withOpacity(0.8),
            height: 0.4,
          ),
          preferredSize: Size.fromHeight(2.0),
        ),
        title: Text(
          "Launch Container",
          style: TextStyle(
            color: Colors.white,
            fontSize: 23.0,
          ),
        ),
        backgroundColor: Color(0xFF0D101E),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _key,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF0D101E),
                Color(0xFF192233),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  width: 250.0,
                  height: 250.0,
                  child: Image(
                    image: AssetImage("assets/launch.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 0.0),
                  height: 100.0,
                  width: size.width,
                  color: Colors.transparent,
                  child: TextFormField(
                    decoration: LaunchContainerTheme.containerNameDecoration,
                    // ignore: missing_return
                    validator: (String val) {
                      if (val.isEmpty) {
                        return "This field can't be empty";
                      }
                    },
                    onSaved: (val) {
                      _containerName = val;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                  height: 100.0,
                  width: size.width,
                  color: Colors.transparent,
                  child: TextFormField(
                    decoration: LaunchContainerTheme.imageNameDecoration,
                    // ignore: missing_return
                    validator: (String val) {
                      if (val.isEmpty) {
                        return "This field can't be empty";
                      }
                    },
                    onSaved: (val) {
                      _imageName = val;
                    },
                  ),
                ),
                Container(
                  width: size.width,
                  margin: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
                  child: MaterialButton(
                    padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    color: Colors.lightBlue,
                    child: Text(
                      "Launch",
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                    onPressed: () {
                      unfocus(context);
                      validator();
                      if (isValidated) {
                        launchContainer();
                      }
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
                  width: size.width,
                  child: Text(
                    "Note",
                    style: GoogleFonts.dmSans(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                  width: size.width,
                  child: Text(
                    "This is just a gist, use the terminal to experience the true power !",
                    style: GoogleFonts.dmSans(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: size.width,
                  margin: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
                  child: MaterialButton(
                    padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    color: Colors.lightBlue,
                    child: Text(
                      "Fire Terminal",
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                    onPressed: () {
                      unfocus(context);
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => BatManTerminal(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  validator() {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      setState(() {
        isValidated = true;
      });
    } else {
      setState(() {
        isValidated = false;
      });
    }
  }
}
