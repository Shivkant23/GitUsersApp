import 'package:flutter/material.dart';
import 'package:flutter_github_demo/ui/SplashScreen.dart';
import 'package:flutter_github_demo/ui/allUsersScren.dart';
import 'package:flutter_github_demo/ui/followersScreen.dart';
import 'package:flutter_github_demo/ui/selectedUser.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      routes: {
        'allusers' : (context) => GitUsers(),
        'user' : (context) => SelectedUserScreen(),
        'followers' : (context) => FollowersScreen(),
      },
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key}) : super(key: key);

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: AllUsersScreen(),
//     );
//   }
// }
