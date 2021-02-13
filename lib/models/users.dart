class UsersModel {
  final String username;
  final String email;
  final String password;


  UsersModel(this.username,this.email,this.password);

  UsersModel.fromJson(Map<String,dynamic> json)
      : username = json["username"],
        email = json["email"],
        password = json["password"];
}