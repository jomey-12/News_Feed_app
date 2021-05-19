import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'Models/users.dart';
import 'shared_preference.dart';

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthProvider with ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;
  Status get registeredInStatus => _registeredInStatus;

  Future<Map<String, dynamic>> login(String email, String password) async {
    var result;

    final Map<String, dynamic> loginData = {
      'email': email,
      'password': password
    };

    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    Response response = await post(
      AppUrl.login,
      body: json.encode(loginData),
      headers: {'Content-Type': 'application/json'},
    ).timeout(const Duration(seconds: 20));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      var userData = responseData;
      User authUser = User.fromJson(userData);
      UserPreferences().saveUser(authUser);

      _loggedInStatus = Status.LoggedIn;
      notifyListeners();

      if (userData["Success"] == "This Email Is not regestered!") {
        result = {
          'status': false,
          'message': 'User not registered!!',
        };
      } else if (userData["Success"] == "Wrong password!") {
        result = {
          'status': false,
          'message': 'Password does not match!!',
        };
      } else {
        result = {'status': true, 'message': 'Successful', 'user': authUser};
      }
      print(result);
      print(response.body);
      print(userData["Success"]);
    } else {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> register(String email, String username,
      String password, String passwordConfirmation) async {
    final Map<String, dynamic> registrationData = {
      'email': email,
      'username': username,
      'password': password,
      'passwordConf': passwordConfirmation
    };

    _registeredInStatus = Status.Registering;
    notifyListeners();

    return await post(AppUrl.register,
            body: json.encode(registrationData),
            headers: {'Content-Type': 'application/json'})
        .timeout(const Duration(seconds: 7200))
        .then(onValue)
        .catchError(onError);
  }

  static Future<FutureOr> onValue(Response response) async {
    var result;
    final Map<String, dynamic> responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      var userData = responseData;

      User authUser = User.fromJson(userData);

      UserPreferences().saveUser(authUser);
      if (responseData["Success"] == "password is not matched") {
        result = {
          'status': false,
          'message': 'Passwords does not match!!',
          'data': responseData
        };
      } else if (responseData["Success"] == "Email is already used.") {
        result = {
          'status': false,
          'message': 'Email already exists!!',
          'data': responseData
        };
      } else if (responseData["Success"] ==
          "You are regestered,You can login now.") {
        result = {
          'status': true,
          'message': 'Successfully registered',
          'data': authUser
        };
      }
    } else {
      result = {
        'status': false,
        'message': 'Registration failed',
        'data': responseData
      };
    }

    return result;
  }

  static onError(error) {
    print("the error is $error.detail");
    return {'status': false, 'message': 'Unsuccessful Request', 'data': error};
  }
}

class UserProvider with ChangeNotifier {
  User _user = new User();

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
