import 'package:chatapp/appConfigProvider/AppProvider.dart';
import 'package:chatapp/auth/LoginScreen.dart';
import 'package:chatapp/auth/RegisterScreen.dart';
import 'package:chatapp/chatScreen/ChatScreen.dart';
import 'package:chatapp/home/Home.dart';
import 'package:chatapp/splachScreen/SplachScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create:(context)=>AppProvider(),
    builder: (context,widget){
      return MaterialApp(routes: {
        SplashScreen.routeName:(buildContext)=>SplashScreen(),
        LoginScreen.routeName:(buildContext)=>LoginScreen(),
        RegisterScreen.routeName:(buildContext)=>RegisterScreen(),
        Home.routeName:(buildContext)=>Home(),
        ChatScreen.routeName:(buildContext)=>ChatScreen("Movie")
      },
      initialRoute: ChatScreen.routeName,);
    });
    }
  }

}
