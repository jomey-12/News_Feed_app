class User {
  String username;
  String email;

  String password;
  String passwordconf;

  User({this.email, this.username, this.password, this.passwordconf});

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
      username: responseData['username'],
      email: responseData['email'],
      password: responseData['password'],
      passwordconf: responseData['passwordConf'],
    );
  }
}

class AppUrl {
  static const String liveBaseURL =
      "https://nodejs-register-login-app.herokuapp.com";

  static const String baseURL = liveBaseURL;
  static const String login = baseURL + "/login";
  static const String register = baseURL;
}
