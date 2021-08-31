import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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
                  ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Create Account",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                color: Color(0xFFBDBDBD),
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          ImageIcon(
                              AssetImage("assets/icons/3.0x/nextarrow@3x.png"),
                              color: Color(0xFFBDBDBD)),
                        ],
                      )
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
