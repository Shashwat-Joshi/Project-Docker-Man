import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Terminal extends StatelessWidget {
  final Size size;
  final double fontsize;
  final String finalOutput;
  final Function decrementFont;
  final Function incrementFont;
  final Function deleteTerminalText;

  Terminal({
    @required this.size,
    @required this.fontsize,
    @required this.finalOutput,
    @required this.decrementFont,
    @required this.incrementFont,
    @required this.deleteTerminalText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(
          top: BorderSide(width: 0.5, color: Colors.white),
        ),
      ),
      height: size.height / 3,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(top: 10.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         ExtendedOutputScreen(finalOutput, fontsize),
                  //   ),
                  // );
                },
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 10.0)),
                    Container(
                      child: GestureDetector(
                        child: Icon(
                          Icons.keyboard_arrow_up,
                          size: 24.0,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text(
                        'Output',
                        style: GoogleFonts.dmSans(
                          fontSize: 16.0, color: Colors.green,
                          // fontWeight: FontWeight.bold,
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
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      this.decrementFont();
                    },
                  ),
                  Text(
                    fontsize == 7
                        ? "Min"
                        : fontsize == 32
                            ? "Max"
                            : "${fontsize.toInt().toString()}",
                    style: GoogleFonts.dmSans(
                      fontSize: 16.0,
                      color: Colors.green,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      this.incrementFont();
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      this.deleteTerminalText();
                    },
                  ),
                ],
              ),
            ],
          ),
          Divider(
            color: Colors.white,
            thickness: 0.5,
          ),
          Padding(padding: EdgeInsets.only(top: 10.0)),
          Expanded(
            child: SingleChildScrollView(
              // controller: _scrollController,
              physics: BouncingScrollPhysics(),
              child: Container(
                padding: EdgeInsets.all(7.0),
                width: size.width,
                child: Text(
                  '$finalOutput',
                  style: GoogleFonts.inconsolata(
                    fontSize: fontsize,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
