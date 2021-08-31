import 'package:chatapp/model/Room.dart';
import 'package:flutter/material.dart';

class RoomWidget extends StatelessWidget {
  late Room room;
  RoomWidget(this.room);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color : Colors.black12,
            blurRadius: 4,
            offset:Offset(4,8),
          )
        ]
      ),
      child: Center(
        child: Column(
          children: [
            Image(image: AssetImage("assets/images/${room.category}.png"),
            width:double.infinity,
              height:120,
              fit:BoxFit.fitHeight,),
            Text(room.name,
            style:TextStyle(
              fontWeight:FontWeight.w600,
              fontSize: 24,
            ))
          ],
        ),
      )
    );
  }
}

