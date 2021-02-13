import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:spidium/Animations/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:spidium/bloc/LoginBloc.dart';
import 'package:spidium/screens/RegisterPage.dart';
import 'package:sweetalert/sweetalert.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 9, 23, 1),
      body: SingleChildScrollView(
        child: Text('Hello',style: TextStyle(color: Colors.white),),
      ),
    );
  }
}