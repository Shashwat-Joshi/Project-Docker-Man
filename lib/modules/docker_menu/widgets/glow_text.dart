import 'package:dockerman/data/user_data.dart';
import 'package:dockerman/modules/ip_screen/pages/enter_ip_ui.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_glow/flutter_glow.dart';

class GlowText1 extends StatefulWidget {
  @override
  _GlowText1State createState() => _GlowText1State();
}

class _GlowText1State extends State<GlowText1> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        GlowContainer(
          // spreadRadius: 30.0,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            width: 0.8,
            color: Colors.blue[600].withOpacity(0.5),
          ),
          color: Color(0xFF202330),

          // blurRadius: size.width,
          margin: EdgeInsets.fromLTRB(15.0, 25.0, 15.0, 10.0),
          padding: EdgeInsets.all(8.0),
          glowColor: Colors.blue.withOpacity(0.15),
          width: size.width,
          height: 110.0,
          child: Center(
            child: Container(
              margin: EdgeInsets.all(7.0),
              child: Column(
                children: [
                  Text(
                    "Current IP",
                    style: GoogleFonts.dmSans(
                      fontSize: 25.0,

                      // fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    // glowColor: Colors.white.withOpacity(0.5),
                  ),
                  Text(
                    ip,
                    style: GoogleFonts.dmSans(
                      fontSize: 25.0,
                      color: Colors.green,
                    ),
                    textAlign: TextAlign.center,
                    // glowColor: Colors.white.withOpacity(0.5),
                  ),
                ],
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("To change IP click"),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EnterIP(),
                  ),
                );
              },
              child: Text(
                " here",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
