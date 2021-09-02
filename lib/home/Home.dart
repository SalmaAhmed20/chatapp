import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  static const String routeName = "Home";
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Home',
        style: TextStyle(

          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
