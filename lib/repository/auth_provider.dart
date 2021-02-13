import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider {

  static String mainUrl = 'http://192.168.137.1:5003';
  final _userToken = '';

  String _apiKey = '';

  final Dio _dio = Dio();

  var userLogin = '$mainUrl/user/login';
  var userRegister = '$mainUrl/register';
  final storage = new FlutterSecureStorage();
  String _tokenString = '';

  Future<http.Response> post(String url,Map<String,String> body) async{
    print(body);
    url =  formatter(url);
//    Map<String,dynamic> output = json.decode(response.body);
    String token  = await storage.read(key: "token");
    var response = await http.post(url,
        headers: {"Content-type": "application/json",},
        body: json.encode(body) );
    print(response.body);

    return response;
  }

  Future<http.Response> get(String url) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _tokenString = prefs.get('token');
    url = formatter(url);
    var response = await http.get(url,headers: {"Authorization": "Bearer $_tokenString"}
    );
    return response;
  }

  String formatter(String url){
    return mainUrl + url;
  }
}