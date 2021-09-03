import 'package:chatapp/model/Room.dart';
import 'package:chatapp/roomDetails/JoinScreen.dart';
import 'package:flutter/material.dart';

class RoomWidget extends StatelessWidget {
  late Room room;
  RoomWidget(this.room);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          JoinScreen.ROUTE_NAME,
          arguments: RoomDetailsArgs(room),
        );
      },
      child: Expanded(
          child: Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
        margin: EdgeInsets.all(9),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 4,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ]),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Image(
                    image: AssetImage(
                      "assets/icons/${room.category}.png",
                    ),
                  ),
                ),
              ),
              Text(
                room.name,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
