import 'package:chatapp/model/Room.dart';
import 'package:chatapp/roomDetails/RoomDetailsScreen.dart';
import 'package:flutter/material.dart';

class RoomWidget extends StatelessWidget {
  late Room room;
  RoomWidget(this.room);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:(){
         Navigator.of(context).pushNamed(RoomDetailsScreen.ROUTE_NAME,arguments: RoomDetailsArgs(room),);
        },
      child:Expanded(
      child: Container(
        margin:EdgeInsets.all(12),
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
          child: Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Image(image: AssetImage("assets/icons/${room.category}.png",),
                    fit: BoxFit.fitWidth,
                    width: double.infinity ,
                    ),
                ),

                Text(
                    room.name,
                style:TextStyle(
                  fontWeight:FontWeight.w600,
                  fontSize: 24,
                )),
              ],
            ),
          ),
        )
      ),
      ),
    );
  }
}

