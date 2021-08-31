import 'dart:async';

import 'package:chatapp/splachScreen/TestPage.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  static const routeName = "SplashScreen";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
          () => Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => TestPage())),
    );
  }

  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
      ),
      Container(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 180.0),
                      child: SizedBox(
                        height: 150,
                        child: Image(
                          image: AssetImage('assets/icons/3.0x/Applogo@3x.png'),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Row(children: [
                Expanded(
                  child: Container(
                    alignment: Alignment(0.0, -1.0),
                    child: SizedBox(
                      height: 120,
                      child: Image(
                        image: AssetImage('assets/icons/3.0x/RouteLogo@3x.png'),
                      ),
                    ),
                  ),
                )
              ])
            ],
          ),
        ),
      ),
    ]);
  }
}
