class LoginModel {
  String email = "";
  String password = "";

  bool hasData() => email != "" && password != "";

  LoginModel(this.email, this.password);
}
