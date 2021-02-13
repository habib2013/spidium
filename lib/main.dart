
import 'package:flutter/material.dart';
import 'package:spidium/bloc/AuthenticationBloc.dart';
import 'package:spidium/screens/HomePage.dart';
import 'package:spidium/screens/LoginPage.dart';
import 'package:spidium/screens/WelcomePage.dart';
import 'package:spidium/screens/main_screen.dart';

void main() => runApp(
   MyHomePage()
);

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    authBloc.restoreSession();
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: getAppCurrentState(),
    );
  }
}


getAppCurrentState(){
    return StreamBuilder<bool> (
        stream: authBloc.isSessionValid,
        builder: (context, AsyncSnapshot<bool> snapshot){
            if (snapshot.hasData && snapshot.data) {
              return MainScreen();
            }
            return WelcomePage();

        });
}