import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_glow/flutter_glow.dart';

glowtext1(size) {
  return GlowContainer(
    spreadRadius: 30.0,
    borderRadius: BorderRadius.circular(15.0),
    border: Border.all(
      width: 0.8,
      color: Colors.blue[600].withOpacity(0.5),
    ),
    color: Color(0xFF202330),
    blurRadius: size.width,
    margin: EdgeInsets.fromLTRB(15.0, 35.0, 15.0, 30.0),
    padding: EdgeInsets.all(8.0),
    glowColor: Colors.white.withOpacity(0.0),
    width: size.width,
    child: Text(
      "Manage and control\nDocker\nJust by a few clicks",
      style: GoogleFonts.dmSans(
        fontSize: 25.0,
      ),
      textAlign: TextAlign.center,
    ),
  );
}
