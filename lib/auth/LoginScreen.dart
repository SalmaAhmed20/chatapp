import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
 static const routeName ='Login';
  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final _registerFormKey = GlobalKey<FormState>();
  String email='';
  String password= '';
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
        ),
        Image(image: AssetImage('assets/images/3.0x/SIGN IN – 1@3x.png'),
        fit: BoxFit.fitWidth,width:double.infinity),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
            title: Text(
              'Login',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 22,
              )
            )
          ),
          body: Column(
            children: [
              Expanded(flex:1,child: Container()),
              Expanded(
                flex:2,child:Container(
                  padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children:[
                   Form(
                       key: _registerFormKey,
                       child:Column(
                           children:[
                        TextFormField(
                          onChanged: (text){
                            email = text;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                          ),
                          validator: (String? contentOfEmail){
                            if(contentOfEmail!.isEmpty || contentOfEmail ==null){
                              return 'Please enter Email';
                            }else if(!isValidEmail(contentOfEmail)){
                              return 'Please enter valid Email';
                            }
                            return null;
                          },
                          obscureText: true,
                        ),
                             TextFormField(
                               onChanged: (text){
                                 password = text;
                               },
                               keyboardType: TextInputType.emailAddress,
                               decoration: InputDecoration(
                                 labelText: 'Password',
                                 floatingLabelBehavior: FloatingLabelBehavior.auto,
                               ),
                               validator: (String? contentOfPassword){
                                 if(contentOfPassword!.isEmpty || contentOfPassword ==null){
                                   return 'Please enter Password';
                                 }else if(!isValidPassword(contentOfPassword)){
                                   return 'Password must be at least 6 characters';
                                 }
                                 return null;
                               },
                               obscureText: true,
                             )
                           ]
                       )
                   ),
                    Spacer(),
                    ElevatedButton(
                     onPressed: (){
                      if(_registerFormKey.currentState?.validate()== true){
                        //go to firebase
                      }
                    }, child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: isLoading?Center(child:CircularProgressIndicator()): Text('Login'),
                    )
                   ), Spacer(),
                    TextButton(
                      child: Text('Or Create My Account!'),
                      onPressed:(){
                      //  Navigator.pushReplacementNamed(context, registerscreen.ROUTE_NAME);
                        // go to registerscreen to create a new account
                      }
                    )
                  ]
                ),
                )
              ),
            ]
          ),
        ),
      ]
    );
  }
  bool isLoading = false;
//void function to check is user already exist or not
// using isloading variable inside this function
}
