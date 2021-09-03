import 'package:chatapp/model/Room.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoomDetailsScreen extends StatefulWidget {
  static const ROUTE_NAME = 'Room-Details';

  @override
  _RoomDetailsScreenState createState() => _RoomDetailsScreenState();
}

class _RoomDetailsScreenState extends State<RoomDetailsScreen> {
  late Room room;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as RoomDetailsArgs;
    room = args.room!;

    return Stack(
      children: [
        Container(
          color: Colors.white,
        ),
        Image(
            image: AssetImage("assets/images/SIGN IN – 1.png"),
            fit: BoxFit.fitWidth,
            width: double.infinity),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(room.name,
                style: TextStyle(
                  fontSize: 25,
                )),
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
          body: Center(
              child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          offset: Offset(4, 8),
                        )
                      ]),
                  margin: EdgeInsets.symmetric(vertical: 30,horizontal: 32),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                      child: Text('Hello, Welcome to our chat room',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text('Join ${room.name}!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: Image(
                        image: AssetImage(
                          "assets/icons/${room.category}.png",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0,8.0, 8.0, 18.0),
                      child: Text('${room.description}',
                        style: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (){},
                      child: Text('Join'),style: ElevatedButton.styleFrom(
                        fixedSize: Size(120.0 , 15.0),
                      ),),

                  ]))),
        ),
      ],
    );
  }
}

class RoomDetailsArgs {
  Room? room;
  RoomDetailsArgs(this.room);
}
