import 'package:dockerman/data/user_data.dart';
import 'package:dockerman/modules/docker_menu/widgets/glow_text.dart';
import 'package:dockerman/modules/docker_menu/widgets/launch_container.dart';
import 'package:dockerman/modules/docker_menu/widgets/manage_container.dart';
import 'package:dockerman/modules/docker_menu/widgets/terminal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DockerMenu extends StatefulWidget {
  @override
  _DockerMenuState createState() => _DockerMenuState();
}

class _DockerMenuState extends State<DockerMenu> {
  String finalOutput;

  @override
  void initState() {
    super.initState();
    setState(() {
      finalOutput = output;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            tooltip: "Refresh output screen",
            icon: Icon(
              Icons.refresh,
            ),
            onPressed: () {
              setState(() {
                finalOutput = output;
              });
            },
          ),
        ],
        bottom: PreferredSize(
          child: Container(
            color: Colors.white.withOpacity(0.8),
            height: 0.4,
          ),
          preferredSize: Size.fromHeight(2.0),
        ),
        title: Text(
          "Dashboard",
          style: TextStyle(
            color: Colors.white,
            fontSize: 23.0,
          ),
        ),
        backgroundColor: Color(0xFF0D101E),
        centerTitle: true,
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: size.width,
                height: size.height / 1.8,
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      GlowText1(),
                      SizedBox(height: size.height / 55),
                      LaunchContainerButton(),
                      ManageContainerButton(),
                      SizedBox(height: size.height / 55),
                    ],
                  ),
                ),
              ),
              Terminal(
                size: size,
                fontsize: fontsize,
                finalOutput: finalOutput,
                decrementFont: () {
                  setState(() {
                    if (fontsize > 7) {
                      --fontsize;
                    }
                  });
                },
                incrementFont: () {
                  setState(() {
                    if (fontsize < 32) {
                      ++fontsize;
                    }
                  });
                },
                deleteTerminalText: () {
                  setState(() {
                    output = originalOutput;
                    finalOutput = originalOutput;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
