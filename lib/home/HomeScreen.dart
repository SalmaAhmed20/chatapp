import 'package:chatapp/addRoom/AddRoom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class  HomScreen extends StatelessWidget {
  static const String ROUTE_NAME="home";
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color:Colors.white,
        ),
    Image(image: AssetImage("assets/images/SIGN IN – 1.png"),
    fit:BoxFit.fitWidth,width:double.infinity),
    Scaffold(
    backgroundColor: Colors.transparent,
    floatingActionButton: FloatingActionButton(
    onPressed: (){
      Navigator.pushNamed(context, AddRoom.ROUTE_NAME);
    },
      child: Icon(Icons.add),

    ),

    )],
    );
  }
}
