import 'dart:async';

import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:rxdart/rxdart.dart';
import 'package:spidium/Animations/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:spidium/bloc/RegisterBloc.dart';
import 'package:spidium/screens/main_screen.dart';
import 'package:spidium/tabs/Tab_Home_Screen.dart';
import 'package:sweetalert/sweetalert.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterBloc bloc = RegisterBloc();

  Timer _timer;

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
              top: -150,
              left: 0,
              child: FadeAnimation(1.6, Container(
                width: width,
                height: 1000,
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
              padding: EdgeInsets.symmetric(vertical: 180,horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FadeAnimation(1.2, Text("Register. ",
                    style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold,fontFamily: 'Josefin Sans'),)),
                  SizedBox(height: 30,),
                  loadingSuccess(bloc),
                  FadeAnimation(1.5, Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white
                    ),

                    child: Column(
                      children: <Widget>[

                        UsernameWidget(bloc),
                        EmailWidget(bloc),
                        PasswordWidget(bloc),
                        loadingIndicator(bloc),

                      ],
                    ),
                  )),
                  SizedBox(height: 20,),
                  // userSuccess(bloc),
                  submitButton(bloc),
                  SizedBox(height: 25,),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeAnimation(1.4,Center(
                          child: Text('have an account?',style: TextStyle(fontSize: 16,fontFamily: 'Josefin Sans',color: Colors.white.withOpacity(.7)),),
                        )),
                        SizedBox(
                          width: 15,
                        ),
                        Text('Login',style: TextStyle(fontSize: 19,fontFamily: 'Josefin Sans',color: Colors.blue[800],decoration: TextDecoration.underline),)
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ]

        ),
      ),
    );
  }

  Widget loadingIndicator(RegisterBloc bloc) => StreamBuilder<bool>(
    stream: bloc.loading,

    builder: (context, snap) {
      return Container(
        child: (snap.hasData && snap.data)
            ? CircularProgressIndicator()
            : null,
      );
    },
  );

  sweetMessage(BuildContext context,String title,String subtitle,{var alertType}){
    SweetAlert.show(context,
        title: title,
        subtitle: subtitle,
        style: SweetAlertStyle.success);
  }
  
  Widget loadingSuccess(RegisterBloc bloc) => StreamBuilder<String>(
    stream: bloc.resultStream,
    builder: (context, snap) {
      if (snap.data == 'User Successfully Registered') {
        _timer = new Timer(const Duration(seconds: 1), () {
          final snackBar = SnackBar(content: Text(snap.data));
          Scaffold.of(context).showSnackBar(snackBar);
        });
        _timer = new Timer(const Duration(seconds: 2), () {
       Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
        });
        return  alertSuccessWidget(snap.data);

      }
      else {
        return Text('');
      }
    },
  );


  alertSuccessWidget(String snapit) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30)
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.greenAccent,spreadRadius: 0,
              )
            ]
        ),
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(18),

        child: Text(snapit,style: TextStyle(color: Colors.white,fontFamily: 'Josefin Sans',fontSize: 14),),
      ),
    );
  }

  Widget UsernameWidget(RegisterBloc bloc) => StreamBuilder(
   stream: bloc.username,
    builder: (context,snap){
     return  Container(
       decoration: BoxDecoration(
           border: Border(bottom: BorderSide(color: Colors.grey[300]))
       ),
       child: TextField(
         onChanged: bloc.changeUsername,
         decoration: InputDecoration(
             border: InputBorder.none,
             hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Josefin Sans'),
             hintText: "Username",
           prefixIcon: Icon(FeatherIcons.user,color: (snap.error != null) ? Colors.red : Colors.black,),
             errorText: snap.error,
         ),
       ),
     );
    },
  );

  Widget EmailWidget(RegisterBloc bloc) => StreamBuilder(
    stream: bloc.email,
    builder: (context,snap){
      return  Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey[300]))
        ),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          onChanged: bloc.changeEmail,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Josefin Sans'),
            hintText: "Email",
            prefixIcon: Icon(FeatherIcons.mail,color: (snap.error != null) ? Colors.red : Colors.black,),
            errorText: snap.error,
          ),
        ),
      );
    },
  );

  Widget PasswordWidget(RegisterBloc bloc) => StreamBuilder(
    stream: bloc.password,
    builder: (context,snap){
      return Container(
        decoration: BoxDecoration(
        ),
        child: TextField(
          obscureText: true,
          onChanged: bloc.changePassword,
          decoration: InputDecoration(
              prefixIcon: Icon(FeatherIcons.unlock,color: (snap.error != null) ? Colors.red : Colors.black,),
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.grey.withOpacity(.8),fontFamily: 'Josefin Sans'),
              hintText: " Password",
              errorText: snap.error
          ),
        ),
      )

        ;
    },
  );

  Widget submitButton(RegisterBloc bloc) => StreamBuilder(
    stream: bloc.submitValid,
    builder: (context, snap) {
      return RaisedButton(
         onPressed: (!snap.hasData) ?  null: bloc.submit,

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
                  child: Center(child: Text("  Create Account ", style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: 'Josefin Sans'),)),
                ),
              )),
        ),
        color: Colors.transparent,
      );
    },
  );

}
