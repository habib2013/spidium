import 'package:spidium/models/users.dart';

class UsersResponse {
  final List<UsersModel> users;
  final String error;

  UsersResponse(this.users,this.error);

  UsersResponse.fromJson(Map<String,dynamic> json)
      : users = (json["users"] as List).map((i) => new UsersModel.fromJson(i)).toList(),
        error = "";

  UsersResponse.withError(String errorValue)
      : users = List(),
        error = errorValue;
}