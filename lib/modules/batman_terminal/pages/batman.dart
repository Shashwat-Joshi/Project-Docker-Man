import 'package:dockerman/data/user_data.dart';
import 'package:dockerman/helpers/unfocus.dart';
import 'package:dockerman/modules/batman_terminal/widgets/output_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class BatManTerminal extends StatefulWidget {
  @override
  _BatManTerminalState createState() => _BatManTerminalState();
}

class _BatManTerminalState extends State<BatManTerminal> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  String cmd;

  runPersonalizedCMD() async {
    setState(() {
      batmanOutput += " $cmd\n";
    });
    try {
      var url = "http://$ip/cgi-bin/command.py?x=$cmd";
      response = await http.get(url);
      print(response.body);
      setState(() {
        batmanOutput = batmanOutput + "${response.body}>";
      });
    } catch (e) {
      setState(() {
        batmanOutput = batmanOutput + "ERROR OCCURED>";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF293262), Color(0xFF0D101E)],
                begin: Alignment.bottomLeft,
                end: Alignment.topCenter,
              ),
            ),
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                Container(
                  width: size.width,
                  height: size.height / 2,
                  padding: EdgeInsets.fromLTRB(18.0, 40.0, 18.0, 0.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            "$batmanInputDecorationText",
                            style: GoogleFonts.inconsolata(
                              fontSize: 17.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 10.0)),
                        Container(
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            padding: EdgeInsets.all(10.0),
                            color: Colors.green,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.code),
                                Container(
                                  padding: EdgeInsets.only(left: 20.0),
                                  child: Text("Execute"),
                                ),
                              ],
                            ),
                            onPressed: () {
                              //FIXME:
                              unfocus(context);
                              _key.currentState.save();
                              runPersonalizedCMD();
                            },
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 10.0)),
                        Container(
                          width: size.width,
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(right: 7.0),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 18.0,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(5.0),
                                width: size.width - 100.0,
                                child: TextFormField(
                                  minLines: 1,
                                  maxLines: 12,
                                  decoration: InputDecoration(
                                    hintText: "Type docker commands here",
                                    border: InputBorder.none,
                                  ),
                                  onSaved: (val) {
                                    val = val.trimRight();
                                    cmd = val;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                OutputScreen(
                  incrementFontSize: () {
                    setState(() {
                      if (batmanFontSize < 32) {
                        ++batmanFontSize;
                      }
                    });
                  },
                  decrementFontSize: () {
                    setState(() {
                      if (batmanFontSize > 7) {
                        --batmanFontSize;
                      }
                    });
                  },
                  deleteTerminalOutput: () {
                    setState(() {
                      batmanOutput = ">";
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Back",
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
    );
  }
}
