import 'package:chatapp/database/DataBaseHelper.dart';
import 'package:chatapp/model/Room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/addRoom/AddRoom.dart';
import 'RoomWidget.dart';

class HomeScreen extends StatelessWidget {
  static const String ROUTE_NAME = 'home';
  late CollectionReference<Room> roomsCollectionref;
  HomeScreen() {
    roomsCollectionref = getRoomsCollectionWithConverter();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
        ),
        Image(
          image: AssetImage('assets/images/SIGN IN – 1.png'),
          fit: BoxFit.fitWidth,
          width: double.infinity,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('Route Chat App',
                style: TextStyle(
                  fontSize: 25,
                )),
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddRoom()),
              );
            },
            child: Icon(Icons.add),
          ),
          body: Container(
            margin: EdgeInsets.only(top: 64, bottom: 12, left: 12, right: 12),
            child: FutureBuilder<QuerySnapshot<Room>>(
                future: roomsCollectionref.get(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Room>> snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    final List<Room> roomsList = snapshot.data?.docs
                            .map((singleDoc) => singleDoc.data())
                            .toList() ??
                        [];
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                        childAspectRatio: .75/1,
                      ),
                      itemBuilder: (buildContext, index) {
                        return RoomWidget(roomsList[index]);
                      },
                      itemCount: roomsList.length,
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        )
      ],
    );
  }
}
