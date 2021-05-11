import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

userGuideWidget(Size size, BuildContext context) {
  return Container(
    margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
    width: size.width,
    height: 180.0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: size.width / 2,
          width: size.width / 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'User Guide',
                style: TextStyle(
                  fontSize: 19.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 10.0)),
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Don\'t know where to start,\nNo problem we have got you covered !',
                    speed: Duration(milliseconds: 100),
                    textStyle: TextStyle(
                      fontSize: 15.5,
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 10.0)),
              GestureDetector(
                // TODO: Goto the guide page
                onTap: () {},
                child: Text(
                  'Read the guide ->',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(padding: EdgeInsets.only(right: 10.0)),
        Container(
          height: size.width / 3,
          width: size.width / 3,
          child: Image(
            image: AssetImage('assets/guide.png'),
          ),
        ),
      ],
    ),
  );
}
