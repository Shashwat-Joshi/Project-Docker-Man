import 'package:flutter/material.dart';

Widget sliverAppBar = SliverAppBar(
  bottom: PreferredSize(
    child: Container(
      color: Colors.white.withOpacity(0.8),
      height: 0.4,
    ),
    preferredSize: Size.fromHeight(2.0),
  ),
  elevation: 10.0,
  pinned: true,
  floating: false,
  snap: false,
  backgroundColor: Color(0xFF0D101E),
  flexibleSpace: FlexibleSpaceBar(
    collapseMode: CollapseMode.pin,
    centerTitle: true,
    title: Text(
      'DockerMan',
    ),
    background: Image.asset(
      'assets/appBarImage.png',
      height: 220.0,
      fit: BoxFit.fitHeight,
    ),
  ),
  expandedHeight: 250.0,
);
