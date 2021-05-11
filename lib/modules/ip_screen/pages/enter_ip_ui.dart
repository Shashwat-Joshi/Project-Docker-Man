import 'dart:async';
import 'package:dockerman/data/user_data.dart';
import 'package:dockerman/modules/docker_menu/pages/docker_menu.dart';
import 'package:dockerman/modules/ip_screen/services/web_service.dart';
import 'package:dockerman/modules/ip_screen/theme/local_theme.dart';
import 'package:dockerman/modules/ip_screen/widgets/error_notification.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class EnterIP extends StatefulWidget {
  @override
  _EnterIPState createState() => _EnterIPState();
}

class _EnterIPState extends State<EnterIP> {
  GlobalKey<FormState> _key = new GlobalKey();
  String _ip;
  bool isLoading = false, firstIP = false;
  String buttonText = "Ok";
  bool val;

  @override
  void initState() {
    super.initState();
    if (ip == null) {
      firstIP = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          bottom: PreferredSize(
            child: Container(
              color: Colors.white.withOpacity(0.8),
              height: 0.4,
            ),
            preferredSize: Size.fromHeight(2.0),
          ),
          title: Text("DockerMan"),
          centerTitle: true,
          backgroundColor: Color(0xFF0D101E),
        ),
        backgroundColor: Color(0xFF0D101E),
        body: Form(
          key: _key,
          child: Container(
            height: size.height,
            width: size.width,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 30.0),
                  child: Text(
                    "Enter IP to continue",
                    style: GoogleFonts.dmSans(
                      fontSize: 33.0,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 0.0),
                  height: 100.0,
                  width: size.width,
                  color: Colors.transparent,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: EnterIpTheme.enterIpDecoration,
                    // ignore: missing_return
                    validator: (String val) {
                      RegExp ip = new RegExp(
                          r"^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?).(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?).(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?).(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$");
                      if (!ip.hasMatch(val)) {
                        return "Invalid IP";
                      }
                    },
                    onSaved: (val) {
                      val = val.trimRight();
                      _ip = val;
                    },
                  ),
                ),
                isLoading
                    ? Container(
                        width: 400.0,
                        height: 400.0,
                        child: FlareActor(
                          "assets/loader.flr",
                          alignment: Alignment.center,
                          fit: BoxFit.contain,
                          sizeFromArtboard: true,
                          animation: "Untitled",
                        ),
                      )
                    : Container(
                        width: 70.0,
                        height: 70.0,
                        child: MaterialButton(
                          shape: CircleBorder(),
                          color: Colors.lightBlue,
                          onPressed: () {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);

                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            setState(() {
                              isLoading = true;
                            });
                            validator();
                          },
                          child: Text("$buttonText"),
                        ),
                      ),
                isLoading
                    ? Container(
                        margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
                        width: size.width,
                        child: AnimatedTextKit(
                          animatedTexts: [
                            FadeAnimatedText(
                              "Validating your IP",
                              duration: Duration(seconds: 2),
                              textStyle: TextStyle(
                                fontSize: 20.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  goToNextScreen() {
    Timer(Duration(seconds: 4), () {
      if (firstIP == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DockerMenu(),
          ),
        );
      } else {
        Navigator.pop(context);
      }
    });
  }

  ipValidation() async {
    val = await WebService.validateServerIP(_ip);
    print(val);
    if (val == true) {
      setState(() {
        ip = _ip;
        output = originalOutput;
      });
      goToNextScreen();
    } else {
      setState(() {
        isLoading = false;
        buttonText = "Retry";
      });
      errorNotification("OOPS! Something went wrong", context);
    }
  }

  validator() async {
    if (_key.currentState.validate()) {
      // saves to global key
      _key.currentState.save();
      ipValidation();
    } else {
      setState(() {
        isLoading = false;
        buttonText = "Retry";
      });
    }
  }
}
