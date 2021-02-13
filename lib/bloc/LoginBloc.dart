import 'dart:async';
import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:spidium/bloc/AuthenticationBloc.dart';
import 'package:spidium/repository/Repository.dart';
import 'package:sweetalert/sweetalert.dart';

class LoginBloc extends Validators {
  Repository repository = Repository();
  //Behavior subject
  final BehaviorSubject _usernameController = BehaviorSubject<String>();
  final BehaviorSubject _passwordController = BehaviorSubject<String>();

  //Publish subject
  final PublishSubject _loadingData = PublishSubject<bool>();

  //sink add
  Function(String) get changeUsername => _usernameController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  //Streams
  Stream<String> get username => _usernameController.stream.transform(validateUsername);
  Stream<String> get password => _passwordController.stream.transform(validatePassword);
  Stream<bool> get submitValid => Rx.combineLatest2(username, password, (username, password) => true);
  Stream<bool> get loading => _loadingData.stream;



  //Submit login
  void submit() {
    final validUsername = _usernameController.value;
    final validPassword = _passwordController.value;
    _loadingData.sink.add(true);
    login(validUsername, validPassword);
  }

  //Login repository
  login(String username, String password) async {
    Map<String,String> data = {
      "username" : username,
      "password": password,
    };
    String url = '/user/login';
    var _result =  await repository.login(url, data);
    Map<String,dynamic> output = json.decode(_result.body);
    String _varoutput = output['msg'];
     String _userToken = output['token'];
     print(_userToken);
    // _loadingData.sink.add(false);
    authBloc.openSession(_userToken);
  }

  //Dispose data
  void dispose() {
    _usernameController.close();
    _passwordController.close();
    _loadingData.close();
  }
}

//validators class
class Validators {
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
      handleData: (String email, EventSink<String> sink) {
        if (email.contains('@')) {
          sink.add(email);
        } else {
          sink.addError('Enter a valid email');
        }
      }
  );



  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (String password, EventSink<String> sink) {
        if (password.length > 3) {
          sink.add(password);
        } else {
          sink.addError('Password must be at least 4 characters');
        }
      }
  );

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