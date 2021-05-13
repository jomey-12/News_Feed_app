import 'package:flutter/material.dart';
import 'package:news_feed/screens/signin.dart';
import 'package:news_feed/screens/signup.dart';
import 'package:provider/provider.dart';
import 'Models/users.dart';
import 'notifier.dart';
import 'screens/bottomNavbar.dart';
import 'shared_preference.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<User> getUserData() => UserPreferences().getUser();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: FutureBuilder(
              future: getUserData(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  default:
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    else if (snapshot.data == null)
                      return SignIn();
                    else
                      UserPreferences().removeUser();
                    return SignIn();
                }
              }),
          routes: {
            '/login': (context) => SignIn(),
            '': (context) => SignUp(),
          }),
    );
  }
}
