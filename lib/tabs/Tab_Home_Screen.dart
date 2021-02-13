import 'package:flutter/material.dart';
import 'package:spidium/widgets/FeaturedNews.dart';

class TabHomeScreen extends StatefulWidget {
  @override
  _TabHomeScreenState createState() => _TabHomeScreenState();
}

class _TabHomeScreenState extends State<TabHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              FeaturedNews(),
            ],
          ),
        ),
    );
  }
}
