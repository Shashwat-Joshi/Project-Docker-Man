import 'package:flutter/foundation.dart';

class Constants {
  final String name;
  final String imageUrl;
  final String position;
  final Map<String, String> socialMedia;
  final String quote;

  Constants({
    @required this.name,
    @required this.imageUrl,
    @required this.position,
    @required this.socialMedia,
    @required this.quote,
  });

  factory Constants.getCreaterDetails() {
    return Constants(
      name: 'Shashwat Joshi',
      imageUrl:
          "https://res.cloudinary.com/startup-grind/image/upload/c_fill,dpr_2.0,f_auto,g_center,h_250,q_auto:good,w_250/v1/gcs/platform-data-dsc/avatars/shashwat_joshi.jpg",
      position: "Lead Developer",
      socialMedia: {
        "linkedin": "https://www.linkedin.com/in/shashwat-joshi-076378186",
        "github": "https://github.com/Shashwat-Joshi",
      },
      quote:
          'In this tech world, the more technologies and concepts you know, the stronger you are !',
    );
  }
}
