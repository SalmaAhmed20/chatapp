import 'package:chatapp/appConfigProvider/AppProvider.dart';
import 'package:chatapp/database/DataBaseManger.dart';
import 'package:chatapp/home/Home.dart';
import 'package:chatapp/model/User.dart' as MyUser;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "Register";

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  final _RegisterKey = GlobalKey<FormState>();
  String _userName = '';
  String _email = '';
  String _password = '';
  bool _obscureText = true;
  bool isLoading = false;
  late AppProvider provider;
  Widget build(BuildContext context) {
    provider=Provider.of<AppProvider>(context);
    return Stack(children: [
      Container(
        color: Colors.white,
      ),
      Image(
          image: AssetImage('assets/images/3.0x/SIGN IN – 1@3x.png'),
          fit: BoxFit.fill,
          height: double.infinity,
          width: double.infinity),
      Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: _labels("Create Account")),
          body: Form(
            key: _RegisterKey,
            child: Container(
              margin: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  TextFormField(
                    onChanged: (newVal) {
                      _userName = newVal;
                    },
                    decoration: InputDecoration(
                        labelText: "Username",
                        labelStyle: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF797979)),
                        floatingLabelBehavior: FloatingLabelBehavior.auto),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter username';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    onChanged: (newVal) {
                      _email = newVal;
                    },
                    decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF797979)),
                        floatingLabelBehavior: FloatingLabelBehavior.auto),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter E-mail';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    onChanged: (newVal) {
                      _password = newVal;
                    },
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
                        labelText: "Password",
                        labelStyle: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF797979)),
                        floatingLabelBehavior: FloatingLabelBehavior.auto),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Password';
                      } else if (value.length < 6)
                        return "Password should be at least 6 characters";
                      return null;
                    },
                    onSaved: (val) => _password = val!,
                    obscureText: _obscureText,
                  ),
                  //bugs
                  Spacer(),
                  isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            CreateUser();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Create Account",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      color: Color(0xFFA7A7A7),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                ImageIcon(
                                    AssetImage(
                                        "assets/icons/3.0x/nextarrow@3x.png"),
                                    color: Color(0xFFA7A7A7)),
                              ],
                            ),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              elevation: MaterialStateProperty.all(8),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ))),
                        )
                ],
              ),
            ),
          ))
    ]);
  }

  //used in show and hide password
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void CreateUser() {
    if (_RegisterKey.currentState?.validate() != null) {
      RegisterUser();
    }
  }

  void RegisterUser() async {
    setState(() {
      this.isLoading = true;
    });
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: this._email, password: this._password);
      ShowMessage("Sucess");
      final userRef =getUsersRefWithConventer();
      final user = MyUser.User(
          id: userCredential.user!.uid, email: _email, userName: _userName);
      userRef.doc(user.id).set(user).then((value) {
        provider.ChangeUser(user);
        Navigator.pushReplacementNamed(context,Home.routeName);
      });
    } on FirebaseAuthException catch (e) {
      ShowMessage(e.message ?? "Something went wrong");
    } catch (e) {
      print(e);
    }
    setState(() {
      this.isLoading = false;
    });
  }

  void ShowMessage(String message) {
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
}

_labels(String label) {
  return Center(
    child: Text(
      label,
      style: TextStyle(
          fontFamily: "Poppins",
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w600),
    ),
  );
}
