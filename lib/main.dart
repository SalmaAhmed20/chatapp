import 'package:chatapp/home/HomeScreen.dart';
import 'package:chatapp/roomDetails/RoomDetailsScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/addRoom/AddRoom.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {
     // RoomDetailsScreen.ROUTE_NAME:(buildContext)=>RoomDetailsScreen(),
      HomeScreen.ROUTE_NAME:(buildContext)=>HomeScreen(),
    },
      initialRoute: HomeScreen.ROUTE_NAME,);
      }
  }


