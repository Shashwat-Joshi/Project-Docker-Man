import 'package:flutter/material.dart';

featuresWidget(Size size) {
  List<IconData> icons = [
    Icons.computer,
    Icons.class_,
    Icons.code,
    Icons.phone_iphone,
  ];
  List<String> heading = [
    "Easy\nAccessibility",
    "Guide",
    "Terminal",
    "Clean UI",
  ];
  List<String> subheading = [
    "Access all docker features from your device.",
    "An easy guide to quickly setup your environment.",
    "Some feature missing? Don't worry we have a dedicated terminal.",
    "A simple clean UI so that you feel amazing !"
  ];

  return Container(
    margin: EdgeInsets.fromLTRB(5.0, 20.0, 5.0, 0.0),
    width: size.width,
    height: 520.0,
    child: Column(
      children: [
        Text(
          'Features',
          style: TextStyle(
            fontSize: 30.0,
          ),
        ),
        Expanded(
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: heading.length,
            itemBuilder: (context, index) => Container(
              padding: EdgeInsets.all(0.0),
              margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 20.0),
              height: 250.0,
              width: 200.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  width: 0.8,
                  color: Colors.blue[600].withOpacity(0.5),
                ),
              ),
              child: Card(
                elevation: 0.0,
                margin: EdgeInsets.all(0.0),
                color: Color(0xFF202330),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  margin: EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        icons[index],
                        size: 20.0,
                        color: Colors.lightBlue,
                      ),
                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      Text(
                        '${heading[index]}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      Text(
                        '${subheading[index]}',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 20.0)),
        Text('and much more...'),
        Padding(padding: EdgeInsets.only(top: 20.0)),
      ],
    ),
  );
}
