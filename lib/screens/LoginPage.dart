import 'dart:async';

import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:spidium/Animations/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:spidium/bloc/LoginBloc.dart';
import 'package:spidium/screens/RegisterPage.dart';
import 'package:sweetalert/sweetalert.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

Timer _timer;

  LoginBloc bloc = LoginBloc();

  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 9, 23, 1),

      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              top: -80,
              left: 0,
              child: FadeAnimation(1.6, Container(
                width: width,
                height: 900,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/wwww.jpeg'),
                      fit: BoxFit.cover,
                      colorFilter: new ColorFilter.mode(Colors.blue.withOpacity(0.3), BlendMode.dstATop),
                    )
                ),
              )),
            ),
            Container(
              // padding: EdgeInsets.only(top: 50,left: 30,right: 30),
              padding: EdgeInsets.symmetric(vertical: 195,horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FadeAnimation(1.2, Text("Login. ",
                    style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold,fontFamily: 'Josefin Sans'),)),
                  SizedBox(height: 30,),
                  FadeAnimation(1.5, Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white
                    ),
                    child: Column(
                      children: <Widget>[
                        UsernameField(bloc),
                        passwordField(bloc),

                      ],
                    ),
                  )),
                  SizedBox(height: 30,),
                  submitButton(bloc),
                  SizedBox(height: 25,),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeAnimation(1.4,Center(
                          child: Text('No account?',style: TextStyle(fontSize: 16,fontFamily: 'Josefin Sans',color: Colors.white.withOpacity(.7)),),
                        )),
                        SizedBox(
                          width: 15,
                        ),
                        InkWell(onTap: (){
                          Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: RegisterPage()));
                        },
                            child: Text('REGISTER',style: TextStyle(fontSize: 19,fontFamily: 'Josefin Sans',color: Colors.blue[800],decoration: TextDecoration.underline),))
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

  Widget UsernameField(LoginBloc bloc) => StreamBuilder<String>(
    stream: bloc.username,
    builder: (context,snap) {
      return  Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey[300]))
        ),
        child: TextField(
          onChanged: bloc.changeUsername,
          decoration: InputDecoration(
               prefixIcon: Icon(FeatherIcons.user,color: (snap.error != null) ? Colors.red : Colors.black,),
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.grey.withOpacity(.8),fontFamily: 'Josefin Sans'),
              hintText: "Username",
              errorText: snap.error,
          ),
        ),
      );
    },
  );

  Widget passwordField(LoginBloc bloc) => StreamBuilder<String>(
    stream: bloc.password,
    builder: (context,snap) {
      return   Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey[300]))
        ),
        child: TextField(
          obscureText: true,
          onChanged: bloc.changePassword,
          decoration: InputDecoration(
            prefixIcon: Icon(FeatherIcons.unlock,color: (snap.error != null) ? Colors.red : Colors.black,),
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.grey.withOpacity(.8),fontFamily: 'Josefin Sans'),
              hintText: "Password",
              errorText: snap.error,
              suffixIcon: Icon(FeatherIcons.eyeOff),


          ),
        ),
      );
    },
  );


  Widget submitButton(LoginBloc bloc) => StreamBuilder<bool>(
    stream: bloc.submitValid,
    builder: (context, snap) {
      return RaisedButton(
         onPressed: (!snap.hasData) ? null : bloc.submit,
          child: Center(
          child: FadeAnimation(1.8,
              Center(
        child: Container(
          width: 250,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              color: (!snap.hasData) ? null : Colors.blue[800]
          ),
          child: Center(child: Text("  Login Now  ", style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: 'Josefin Sans'),)),
        ),
      )),
      ),
    color: Colors.transparent,
      );
    },
  );
}