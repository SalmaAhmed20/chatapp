import 'package:chatapp/database/DataBaseHelper.dart';
import 'package:chatapp/home/HomeScreen.dart';
import 'package:chatapp/model/Room.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddRoom extends StatefulWidget {
  static const String ROUTE_NAME="addRoom";

  @override
  _AddRoomState createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> {
  final _addRoomFormKey =GlobalKey<FormState>();
  String roomName="";
  String description="";
  List<String> categories =["movies","sports","music"];
  String selectedCategory="sports";
  bool isloading=false;
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
          appBar: AppBar(title: Text("Chat App",style:TextStyle(
            fontSize: 25,
          )),
            centerTitle: true,
            elevation: 0,

          ),

        body:Center(
          child:Container(
            padding:EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color:Colors.grey,
                  blurRadius: 4,
                  offset: Offset(4,8),
                )
              ]
            ),
            margin: EdgeInsets.symmetric(vertical: 32,horizontal: 40),
            child: ListView(
              children: [
                Text("Create New Room",style: TextStyle(
                  color: Colors.black,
                  fontSize:24,
                  fontWeight: FontWeight.bold
                ),
                  textAlign: TextAlign.center,
                ),
                Image(image:AssetImage("assets/images/group.png")),
                Form(
                  key:_addRoomFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        onChanged: (text){
                          roomName=text;
                        },
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: "Room Name",
                          labelStyle: TextStyle( fontSize: 25.0),
                          floatingLabelBehavior:FloatingLabelBehavior.always ,
                        ),
                        validator: (String ?value){
                          if(value==null ||value.isEmpty){
                            return'please enter Room Name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        onChanged: (text){
                          description=text;
                        },
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: "Room Description",
                          labelStyle: TextStyle( fontSize: 25.0),
                          floatingLabelBehavior:FloatingLabelBehavior.always ,
                        ),
                        validator: (String ? value){
                          if(value==null ||value.isEmpty){
                            return'please enter Room description';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),

                ),
                DropdownButton(value: selectedCategory,
                  iconSize: 24,
                  elevation: 16,
                  items:categories.map((name) {
                    return DropdownMenuItem(
                      value: name,
                        child: Padding(
                          padding: const EdgeInsets.all(8.8),
                          child: Row(
                            children: [
                              Padding(padding: const EdgeInsets.only(bottom: 0),
                                child: Text(name,style:TextStyle(fontSize: 20)),),
                            ]
                        ),
                    ),);
                    }).toList(),
                   onChanged: (newSelected){
                   setState(() {
                     selectedCategory=newSelected as String;
                   });
                  },
                ),
               ElevatedButton(onPressed: (){
                 //Padding(padding: const EdgeInsets.only(top),
                 if(_addRoomFormKey.currentState?.validate()==true){
                   addRoom();
                 }
               },
               child:isloading?Center(child:CircularProgressIndicator() ,):
               Text('Create')),
            ],
          ),
        ),
        ),
        ),
      ],
    );

  }
  void addRoom(){
    setState(() {
      isloading=true;
    });

    final docRef =getRoomsCollectionWithConverter().doc();
    Room room =Room(id:docRef.id,
      name: roomName,
      description:description,
      category:selectedCategory);
    docRef.set(room).then((value){
      setState(() {
        isloading=false;
      });
      Fluttertoast.showToast(msg: 'Room Added Successfully',
          toastLength: Toast.LENGTH_LONG);
          Navigator.pushReplacementNamed(context,  HomeScreen.routeName);
    });
  }
}