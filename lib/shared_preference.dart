import 'package:news_feed/screens/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:flutter/material.dart';

import 'Models/users.dart';

class UserPreferences {
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("username", user.username);
    prefs.setString("email", user.email);

    prefs.setString("password", user.password);
    prefs.setString("passwordConf", user.passwordconf);

    return prefs.commit();
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String username = prefs.getString("username");
    String email = prefs.getString("email");

    String password = prefs.getString("password");
    String passwordconf = prefs.getString("passwordConf");

    return User(
        username: username,
        email: email,
        password: password,
        passwordconf: passwordconf);
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("name");
    prefs.remove("email");

    prefs.remove("password");
    prefs.remove("passwordConf");
  }

  Future<String> getToken(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String password = prefs.getString("password");
    return password;
  }
}

Future<void> logout(context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('username');
  await prefs.remove('email');
  await prefs.remove('password');
  await prefs.remove('passwordConf');

  await Future.delayed(Duration(seconds: 2));

  Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (BuildContext context) => SignIn(),
  ));
}
