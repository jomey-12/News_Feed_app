import 'dart:convert';
import 'dart:ui';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:news_feed/Models/users.dart';
import 'package:news_feed/screens/signin.dart';
import 'package:provider/provider.dart';

import '../notifier.dart';

import 'bottomNavbar.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var msg = '';
  final _formkey = GlobalKey<FormState>();
  String username, email, password, passwordconf;
  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Registering ... Please wait")
      ],
    );

    var doRegister = () {
      final form = _formkey.currentState;
      if (form.validate()) {
        form.save();

        auth.register(email, username, password, passwordconf).then((response) {
          print(".....");
          print(response);
          if (response['status']) {
            User user = response['data'];
            print(user);
            Provider.of<UserProvider>(context, listen: false).setUser(user);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => BottomNavbar()));
          } else {
            print("registration failed");
            setState(() {
              msg = response["message"];
            });
          }
        });
      } else {
        print("cannot register");
      }
    };
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/image.jpg"),
                      fit: BoxFit.cover)),
              child: ClipRRect(
                // Clip it cleanly.
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    color: Colors.grey.withOpacity(0.1),
                    alignment: Alignment.topLeft,
                  ),
                ),
              ),
            ),
            Positioned(
                top: 90,
                left: 40,
                child: Text(
                  "Welcome!!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height / 1.4,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    )),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 17,
                        ),
                        Text(
                          "Sign up",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Form(
                          key: _formkey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5.0,
                              horizontal: 24.0,
                            ),
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black38,
                                        borderRadius:
                                            BorderRadius.circular(13)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, bottom: 8),
                                      child: TextFormField(
                                        style: TextStyle(color: Colors.white),
                                        validator: (value) =>
                                            EmailValidator.validate(value)
                                                ? null
                                                : "Please enter a valid email",
                                        decoration: InputDecoration(
                                          hintText: "Email:",
                                          border: InputBorder.none,
                                          fillColor: Colors.red,
                                          hintStyle: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white),
                                        ),
                                        onChanged: (val) {
                                          email = val;
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black38,
                                        borderRadius:
                                            BorderRadius.circular(13)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, bottom: 8),
                                      child: TextFormField(
                                        style: TextStyle(color: Colors.white),
                                        validator: (val) {
                                          return val.isEmpty
                                              ? "Enter your name"
                                              : null;
                                        },
                                        decoration: InputDecoration(
                                          hintText: "Name:",
                                          border: InputBorder.none,
                                          fillColor: Colors.red,
                                          hintStyle: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white),
                                        ),
                                        onChanged: (val) {
                                          username = val;
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black38,
                                        borderRadius:
                                            BorderRadius.circular(13)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, bottom: 8),
                                      child: TextFormField(
                                        obscureText: true,
                                        style: TextStyle(color: Colors.white),
                                        validator: (val) {
                                          return val.isEmpty
                                              ? "Enter your password"
                                              : val.length < 6
                                                  ? "Password should consist of atleast 6 characters"
                                                  : null;
                                        },
                                        decoration: InputDecoration(
                                          hintText: "Password:",
                                          border: InputBorder.none,
                                          fillColor: Colors.red,
                                          hintStyle: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white),
                                        ),
                                        onChanged: (val) {
                                          password = val;
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black38,
                                        borderRadius:
                                            BorderRadius.circular(13)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, bottom: 8),
                                      child: TextFormField(
                                        obscureText: true,
                                        style: TextStyle(color: Colors.white),
                                        validator: (val) {
                                          return val.isEmpty
                                              ? "Re-enter the password"
                                              : val.length < 6
                                                  ? "Password should consist of atleast 6 characters"
                                                  : null;
                                        },
                                        decoration: InputDecoration(
                                          hintText: "Re-enter Password:",
                                          border: InputBorder.none,
                                          fillColor: Colors.red,
                                          hintStyle: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white),
                                        ),
                                        onChanged: (val) {
                                          passwordconf = val;
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  auth.loggedInStatus == Status.Authenticating
                                      ? loading
                                      : Column(
                                          children: [
                                            Text(
                                              msg,
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                            SizedBox(
                                              height: 7,
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  doRegister();
                                                },
                                                child: bluebutton(
                                                    context: context,
                                                    label: "Sign Up")),
                                          ],
                                        ),
                                  SizedBox(height: 10),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        child: Divider(
                                          color: Colors.black,
                                          height: 10,
                                          thickness: .6,
                                          indent: 15,
                                          endIndent: 0,
                                        ),
                                      ),
                                      Container(
                                          alignment: Alignment.center,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.8,
                                          child: Text("or sign up with")),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        child: Divider(
                                          color: Colors.black,
                                          height: 10,
                                          thickness: .6,
                                          indent: 0,
                                          endIndent: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        child: Image.asset(
                                            "assets/google_pic.jpg"),
                                      ),
                                      SizedBox(width: 10),
                                      CircleAvatar(
                                        child: Image.asset("assets/fb.jpg"),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Have an account?"),
                                      InkWell(
                                        child: Text("Sign in",
                                            style: TextStyle(
                                              color: Colors.yellow[900],
                                            )),
                                        onTap: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          SignIn()));
                                        },
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget bluebutton({
  BuildContext context,
  String label,
}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 18),
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(30.0),
    ),
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width / 3,
    child: Text(
      label,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    ),
  );
}
