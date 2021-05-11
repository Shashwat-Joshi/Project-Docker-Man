import 'package:dockerman/data/user_data.dart';
import 'package:dockerman/modules/extended_output_screen/extended_output.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OutputScreen extends StatelessWidget {
  final Function incrementFontSize;
  final Function decrementFontSize;
  final Function deleteTerminalOutput;

  OutputScreen({
    @required this.incrementFontSize,
    @required this.decrementFontSize,
    @required this.deleteTerminalOutput,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5.0),
          topRight: Radius.circular(5.0),
        ),
      ),
      width: size.width,
      height: size.height / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(top: 5.0),
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExtendedOutputScreen(
                          batmanOutput,
                          batmanFontSize,
                        ),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 10.0)),
                      Container(
                        child: GestureDetector(
                          child: Icon(
                            Icons.keyboard_arrow_up,
                            color: Colors.black,
                            size: 24.0,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Text(
                          'Output',
                          style: GoogleFonts.dmSans(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.remove,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        this.decrementFontSize();
                      },
                    ),
                    Text(
                      batmanFontSize == 7
                          ? "Min"
                          : batmanFontSize == 32
                              ? "Max"
                              : "${batmanFontSize.toInt().toString()}",
                      style: GoogleFonts.dmSans(
                        fontSize: 16.0,
                        color: Colors.green,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        this.incrementFontSize();
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        this.deleteTerminalOutput();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: (size.height / 2) - 57.0,
            width: size.width,
            color: Color(0xFF0D101E),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      padding: EdgeInsets.all(7.0),
                      width: size.width,
                      child: Text(
                        '$batmanOutput',
                        style: GoogleFonts.inconsolata(
                          fontSize: batmanFontSize,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
