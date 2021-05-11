import 'package:dockerman/modules/home_screen/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'about_us_details.dart';

aboutUs(Size size, BuildContext context) {
  Constants creator = Constants.getCreaterDetails();

  return Container(
    margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
    // height: 500.0,
    width: size.width,
    child: Column(
      children: [
        Text(
          'Creator',
          style: TextStyle(
            fontSize: 30.0,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10.0),
          width: size.width,
          // height: 250.0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                width: 0.8,
                color: Colors.blue[600].withOpacity(0.5),
              ),
            ),
            padding: EdgeInsets.all(0.0),
            margin: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 25.0),
            width: size.width,
            height: 440.0,
            child: Card(
              margin: EdgeInsets.all(0.0),
              color: Color(0xFF202330),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.only(top: 40.0)),
                  CircleAvatar(
                    radius: 80.0,
                    backgroundImage: NetworkImage(
                      creator.imageUrl,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 30.0)),
                  Text(
                    creator.name,
                    style: TextStyle(
                      fontSize: 23.0,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 30.0)),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    width: 180.0,
                    height: 50.0,
                    child: TextButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent)),
                      child: Text(
                        'View Profile',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.blue,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) =>
                                AboutUsDetails(creator: creator),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    ),
  );
}
