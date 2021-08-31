import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/appConfigProvider/AppProvider.dart';
import 'package:chatapp/database/DataBaseManger.dart';
import 'package:chatapp/home/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:chatapp/auth/RegisterScreen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = 'Login';
  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final _registerFormKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool _obscureText = true;
  late AppProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context);
    return Stack(children: [
      Container(
        color: Colors.white,
      ),
      Image(
          image: AssetImage('assets/images/3.0x/SIGN IN – 1@3x.png'),
          fit: BoxFit.fitWidth,
          width: double.infinity),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
            title: Text('Login',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ))),
        body: Column(children: [
          Expanded(flex: 1, child: Container()),
          Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(12),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Welcome back!',
                          style: TextStyle(
                              fontSize: 24,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          textDirection: TextDirection.ltr),
                      Form(
                          key: _registerFormKey,
                          child: Column(children: [
                            TextFormField(
                              onChanged: (text) {
                                email = text;
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF797979)),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                              ),
                              validator: (contentOfEmail) {
                                if (contentOfEmail!.isEmpty ||
                                    contentOfEmail == null) {
                                  return 'Please enter Email';
                                } else if (!isValidEmail(contentOfEmail)) {
                                  return 'Please enter valid Email';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              onChanged: (text) {
                                password = text;
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.remove_red_eye_outlined,
                                    size: 28,
                                    color: Color(0xFF3598DB),
                                  ),
                                  onPressed: () {
                                    _toggle();
                                  },
                                ),
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF797979)),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                              ),
                              validator: (String? contentOfPassword) {
                                if (contentOfPassword!.isEmpty ||
                                    contentOfPassword == null) {
                                  return 'Please enter Password';
                                } else if (!isValidPassword(
                                    contentOfPassword)) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                              obscureText: true,
                            )
                          ])),
                      Spacer(),
                      isLoading
                          ? Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                              onPressed: () {
                                if (_registerFormKey.currentState?.validate() ==
                                    true) {
                                  createFirebaseUser();
                                }
                              },
                              child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text('Login',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontFamily: "Poppins",
                                            )),
                                        ImageIcon(
                                            AssetImage(
                                                "assets/icons/3.0x/nextarrow@3x.png"),
                                            color: Colors.white)
                                      ])),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color(0xFF3598DB)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )))),
                      Spacer(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                              child: Text(
                                'Or Create My Account!',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w200,
                                    color: Color(0xFF505050)),
                              ),
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, RegisterScreen.routeName);
                              }),
                        ],
                      )
                    ]),
              )),
        ]),
      ),
    ]);
  }

  bool isLoading = false;
  void createFirebaseUser() async {
    setState(() {
      isLoading = true;
    });
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final userRef = getUsersRefWithConventer()
          .doc(userCredential.user!.uid)
          .get()
          .then((retrievedUser) {
        provider.ChangeUser(retrievedUser.data());
        Navigator.pushReplacementNamed(context, Home.routeName);
      });
    } on FirebaseAuthException catch (e) {
      ShowErrorMessage(e.message!);
    } catch (e) {
      ShowErrorMessage(e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  void ShowErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (buildContext) {
          return AlertDialog(
            content: Text(message,
                style: TextStyle(
                    fontFamily: "Poppins", color: Colors.black, fontSize: 18)),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Ok", style: TextStyle(fontFamily: "Poppins")))
            ],
          );
        });
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}

bool isValidEmail(String contentOfEmail) {
  String characters =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = new RegExp(characters);

  return regExp.hasMatch(contentOfEmail);
}

bool isValidPassword(String contentOfPassword) {
  if (contentOfPassword.length < 6)
    return false;
  else
    return true;
}
