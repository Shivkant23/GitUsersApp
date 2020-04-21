import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  startTime(){
    Duration _duration = Duration(seconds: 2);
    return new Timer(_duration, callback);
  }

  void callback(){
    Navigator.pushReplacementNamed(context, 'allusers');
  }

  @override
  void initState() {
    startTime();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // WidgetStandarts.getWidthAndHeight(context);
    return Scaffold(
          backgroundColor: Color(0xFFFF9844),
          body: Container(
         child: Center(
           child: Image.asset('assets/Octocat.png'),
         ),
      ),
    );
  }
}