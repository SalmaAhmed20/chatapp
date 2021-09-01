import 'package:chatapp/database/DataBaseHelper.dart';
import 'package:chatapp/model/Message.dart';
import 'package:chatapp/model/Room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'MessageWidget.dart';

class RoomDetailsScreen extends StatefulWidget {
  static const ROUTE_NAME = 'Room-Details';

  @override
  _RoomDetailsScreenState createState() => _RoomDetailsScreenState();
}

class _RoomDetailsScreenState extends State<RoomDetailsScreen> {
  late Room room;

  String typedMessage="";
  late AppConfigProvider provider;
  late TextEditingController messageController ;

  late CollectionReference<Message>messagesRef;
  @override
  void initState(){
    super.initState();
    messageController = TextEditingController(text:typedMessage);
  }
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as RoomDetailsArgs;
    room = args.room!;
    messagesRef = getMessagesCollectionWithConverter(room.id);
    final Stream<QuerySnapshot<Message>>messagesStream=messagesRef.orderBy('time').snapshots();
    provider = Provider.of<AppConfigProvider>(context);

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
              title: Text(room.name),
              elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.transparent,
            ),
            body: Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.symmetric(vertical: 48, horizontal: 24),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(color: Colors.black12, offset: Offset(4, 4))
                ],
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Expanded(child:
                  StreamBuilder<QuerySnapshot<Message>>(
                    stream:messagesStream,
                    builder:(BuildContext context,AsyncSnapshot<QuerySnapshot<Message>>snapshot){
                      if(snapshot.hasError){
                        return Text(snapshot.error.toString());

                      }else if(snapshot.hasData){
                        return ListView.builder(itemBuilder: (buildContext,index){
                           return MessageWidget(snapshot.data?.docs[index].data());
                        },
                        itemCount: snapshot.data?.size??0,

                        );
                        //snapshot.data.docChanges.single;
                      }
                      return Center(child:CircularProgressIndicator(),);
                    },
                  ),),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: messageController,
                          onChanged: (newText){
                            typedMessage=newText;
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 12),
                              hintText: 'type a message',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12)),
                              )),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          sendMessage();
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          color: Colors.blue,
                          child: Row(
                            children: [
                              Text(
                                'send',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Image.asset('assets/icons/send.png'),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )),
      ],
    );
  }

  void sendMessage() {
    if(typedMessage.isEmpty)return;
    final newMessageObj = messagesRef.doc();
    final message = Message(id: newMessageObj.id,
        content:typedMessage,
        time: DateTime.now().microsecondsSinceEpoch,
        senderName: provider.myUser?.userName??'',
      senderId:provider?.id??'',);
    newMessageObj.set(message).
    then((value)=>{
      setState((){
       messageController.clear();
      }),
    });
  }
}

class RoomDetailsArgs {
  Room? room;
  RoomDetailsArgs(this.room);
}
