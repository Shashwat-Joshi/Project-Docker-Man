import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class ExtendedOutputScreen extends StatefulWidget {
  final String fullScreenOutput;
  final double fullScreenFontSize;
  ExtendedOutputScreen(
    this.fullScreenOutput,
    this.fullScreenFontSize,
  );
  @override
  _ExtendedOutputScreenState createState() => _ExtendedOutputScreenState();
}

class _ExtendedOutputScreenState extends State<ExtendedOutputScreen> {
  bool isOnPortrait = true;
  double fullScreenFontSize;
  String fullScreenOutput;
  @override
  void initState() {
    super.initState();
    fullScreenFontSize = widget.fullScreenFontSize;
    fullScreenOutput = widget.fullScreenOutput;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
        Navigator.pop(context);
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (fullScreenFontSize > 7) {
                        --fullScreenFontSize;
                      }
                    });
                  },
                ),
                Text(
                  fullScreenFontSize == 7
                      ? "Min"
                      : fullScreenFontSize == 32
                          ? "Max"
                          : "${fullScreenFontSize.toInt().toString()}",
                  style: GoogleFonts.dmSans(
                    fontSize: 16.0, color: Colors.green,
                    // fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      if (fullScreenFontSize < 32) {
                        ++fullScreenFontSize;
                      }
                    });
                  },
                ),
              ],
            ),
          ],
          leading: GestureDetector(
            onTap: () {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
              ]);
              Navigator.pop(context);
            },
            child: Icon(
              Icons.keyboard_arrow_down,
              size: 24.0,
            ),
          ),
          bottom: PreferredSize(
            child: Container(
              color: Colors.white.withOpacity(0.8),
              height: 0.5,
            ),
            preferredSize: Size.fromHeight(2.0),
          ),
          title: Text(
            "Output",
            style: GoogleFonts.dmSans(
              fontSize: 16.0,
              color: Colors.green,
            ),
          ),
          backgroundColor: Color(0xFF0D101E),
        ),
        backgroundColor: Color(0xFF0D101E),
        body: Container(
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
          margin: EdgeInsets.only(top: 10.0),
          padding: EdgeInsets.all(7.0),
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Text(
              '$fullScreenOutput',
              style: GoogleFonts.inconsolata(
                fontSize: fullScreenFontSize,
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            if (isOnPortrait) {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.landscapeLeft,
                DeviceOrientation.landscapeRight,
              ]);
            } else {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
              ]);
            }
            setState(() {
              isOnPortrait = !isOnPortrait;
            });
          },
          child: Icon(
            Icons.rotate_90_degrees_ccw,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
