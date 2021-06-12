import 'package:dockerman/modules/home_screen/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsDetails extends StatefulWidget {
  final Constants creator;
  AboutUsDetails({@required this.creator});
  @override
  _AboutUsDetailsState createState() => _AboutUsDetailsState();
}

class _AboutUsDetailsState extends State<AboutUsDetails> {
  launchURL(String url) async {
    print("Launcing..... $url");
    await launch(url);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          child: Container(
            color: Colors.white.withOpacity(0.8),
            height: 0.4,
          ),
          preferredSize: Size.fromHeight(2.0),
        ),
        title: Text("DockerMan"),
        centerTitle: true,
        backgroundColor: Color(0xFF0D101E),
      ),
      backgroundColor: Color(0xFF0D101E),
      body: Container(
        height: size.height,
        width: size.width,
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
        child: Card(
          margin: EdgeInsets.all(20.0),
          color: Color(0xFF202330),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.only(top: 40.0)),
                CircleAvatar(
                  radius: 80.0,
                  backgroundImage: NetworkImage(
                    widget.creator.imageUrl,
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 40.0)),
                Text(
                  widget.creator.name,
                  style: TextStyle(
                    fontSize: 23.0,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10.0)),
                Text(
                  widget.creator.position,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18.0,
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 40.0)),
                Divider(),
                Container(
                  height: 120.0,
                  width: 150.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          launchURL(widget.creator.socialMedia["linkedin"]);
                        },
                        child: Container(
                          height: 60.0,
                          width: 60.0,
                          child: Image(
                            image: AssetImage('assets/linkedInLogo.png'),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(right: 20.0)),
                      GestureDetector(
                        onTap: () {
                          launchURL(widget.creator.socialMedia["github"]);
                        },
                        child: Container(
                          height: 45.0,
                          width: 45.0,
                          child: Image(
                            image: AssetImage('assets/Octocat.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Padding(padding: EdgeInsets.only(top: 40.0)),
                Text(
                  'Ideology',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23.0,
                  ),
                ),
                Container(
                  width: size.width,
                  padding: EdgeInsets.all(15.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        new TextSpan(
                          text: '" ',
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        new TextSpan(
                          text: widget.creator.quote,
                          style: new TextStyle(
                            fontSize: 18.0,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        new TextSpan(
                          text: ' "',
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 40.0)),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
