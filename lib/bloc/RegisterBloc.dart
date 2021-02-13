import 'dart:async';
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:spidium/bloc/AuthenticationBloc.dart';
import 'package:spidium/repository/Repository.dart';
import 'package:spidium/repository/auth_provider.dart';
import 'package:spidium/tabs/Tab_Home_Screen.dart';
import 'package:sweetalert/sweetalert.dart';

class RegisterBloc extends Validators {
  Repository repository = Repository();
  
  //Behavior subjects
  final BehaviorSubject _emailController = BehaviorSubject<String>();
  final BehaviorSubject _passwordController = BehaviorSubject<String>();
  final BehaviorSubject _usernameController = BehaviorSubject<String>();

  //publish subjects
  final PublishSubject _resultData = PublishSubject<String>();
  final PublishSubject _loadingData = PublishSubject<bool>();
  
  // Sinks
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changeUsername => _usernameController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  
  // Streams
  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password => _passwordController.stream.transform(validatePassword);
  Stream<String> get username => _usernameController.stream.transform(validateUsername);

  Stream<bool> get submitValid => Rx.combineLatest3(email,password,username, (email, password,username) => true);
  Stream<bool> get loading => _loadingData.stream;
  Stream<String> get resultStream => _resultData.stream;
  
   submit() {
    final validEmail = _emailController.value;
    final validPassword = _passwordController.value;
    final validUsername = _usernameController.value;

    // Timer(Duration(seconds: 3), () =>  );
    _loadingData.sink.add(true);
      register(validEmail, validPassword,validUsername);
  }
  

  sweetMessage(BuildContext context,String title,String subtitle){
      SweetAlert.show(context,
         title: title,
         subtitle: subtitle,
         style: SweetAlertStyle.success);
  }

  register(String email, String password,String username) async {
    Map<String,String> data = {
      "username" : username,
      "password": password, 
      "email": email,
    };
    String url = '/user/register';
    //get final result from server
   var _result =  await repository.register(url, data);
   //get result of response body
    Map<String,dynamic> output = json.decode(_result.body);
    //get the status code
    var _statusCode = _result.statusCode;

    // get msg response from server;
    String _varoutput = output['msg'];
    //
    if (_statusCode == 200 || _statusCode == 201) {

    }

      _resultData.sink.add(_varoutput);

      _loadingData.sink.add(false);
      // ourNavigator(context);

  }


// ourNavigator(BuildContext context){
//    Navigator.of(context).push(MaterialPageRoute(builder: (context) => TabHomeScreen()));
// }
  
  void dispose() {
    _emailController.close();
    _passwordController.close();
    _usernameController.close();
    _resultData.close();
    _loadingData.close();
  }
}


class Validators {
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
      handleData: (String email, EventSink<String> sink) {
        if (email.contains('@') && email.contains('.')) {
          sink.add(email);
        } else {
          sink.addError('Enter a valid email');
        }
      }
  );



  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (String password, EventSink<String> sink) {
        if (password.length > 7) {
          sink.add(password);
        } else {
          sink.addError('Password must be at least 8 characters');
        }
      }
  );


  // Stream<String> get validatePasswordConfirmStream => Rx.combineLatest2(passwordStream, passwordConfirmStream,
  //         (p, pc){
  //       return p.compareTo(pc)? p.passwordStream:'passwords does not match';
  //     });

  final validateUsername = StreamTransformer<String,String>.fromHandlers(
      handleData: (String username,EventSink<String> sink){
        if (username.length > 5) {
          sink.add(username);
        }
        else {
          sink.addError('Enter at least 5 characters');
        }
      }
  );


}