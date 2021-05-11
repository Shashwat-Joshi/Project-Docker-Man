import 'package:dockerman/modules/home_screen/services/exit_notification.dart';
import 'package:dockerman/modules/home_screen/widgets/aboutUs.dart';
import 'package:dockerman/modules/home_screen/widgets/features_widget.dart';
import 'package:dockerman/modules/home_screen/widgets/glow_text_for_homescreen.dart';
import 'package:dockerman/modules/home_screen/widgets/go_to_dashboard_button.dart';
import 'package:dockerman/modules/home_screen/widgets/sliver_app_bar.dart';
import 'package:dockerman/modules/home_screen/widgets/user_guide.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        showExitNotification(context);
        return;
      },
      child: Scaffold(
        extendBodyBehindAppBar: false,
        backgroundColor: Color(0xFF0D101E),
        body: CustomScrollView(
          slivers: [
            sliverAppBar,
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
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
                    child: Column(
                      children: [
                        glowtext1(size),
                        goToDashboardButton(size, context),
                        Divider(thickness: 0.5),
                        userGuideWidget(size, context),
                        Divider(thickness: 0.5),
                        featuresWidget(size),
                        Divider(thickness: 0.5),
                        aboutUs(size, context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
