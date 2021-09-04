import 'package:chatapp/appConfigProvider/AppProvider.dart';
import 'package:chatapp/chatScreen/MessageUi.dart';
import 'package:chatapp/database/DataBaseHelper.dart';
import 'package:chatapp/home/HomeScreen.dart';
import 'package:chatapp/model/Message.dart';
import 'package:chatapp/model/Room.dart';
import 'package:chatapp/model/RoomDetailsArgs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = "Chat";
  late Room room;
  ChatScreen();

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String _typedMessage = '';
  late CollectionReference<Message> messageRef;
  late AppProvider provider;
  late Room room;
  late TextEditingController _msgcontlr;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _msgcontlr = TextEditingController(text: _typedMessage);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as RoomDetailsArgs;
    room = args.room!;
    provider = Provider.of<AppProvider>(context);
    messageRef = getMessagesCollectionWithConverter(room.id);
    final Stream<QuerySnapshot<Message>> _messageStream =
        messageRef.orderBy('time').snapshots();
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
            title: _labels(room.name),
            actions: [
              PopupMenuButton(
                  offset: Offset(0, kToolbarHeight),
                  iconSize: 30,
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .popUntil((route) => route.isFirst);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          HomeScreen()));
                            },
                            child: Text(
                              "Leave Room",
                              style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                          ),
                          value: 1,
                        )
                      ])
            ],
          ),
          body: Container(
            margin: EdgeInsets.symmetric(vertical: 30, horizontal: 24),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(4, 4),
                      blurRadius: 8)
                ]),
            child: Column(
              children: [
                //turn to listview
                Expanded(
                    child: StreamBuilder<QuerySnapshot<Message>>(
                        stream: _messageStream,
                        builder: (BuildContext buildContext,
                            AsyncSnapshot<QuerySnapshot<Message>> snapshot) {
                          if (snapshot.hasError)
                            return Text(snapshot.error.toString());
                          else if (snapshot.hasData) {
                            return (snapshot.data?.size ?? 0) > 0
                                ? ListView.builder(
                                    itemBuilder: (buildContext, index) {
                                      return MessageWidget(
                                          snapshot.data!.docs[index].data());
                                    },
                                    itemCount: snapshot.data?.size ?? 0)
                                : Center(
                                    child: Text(
                                    "Say Hi!",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 24,
                                        color: Colors.grey),
                                  ));
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        })),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        child: TextField(
                          onChanged: (mssage) {
                            _typedMessage = mssage;
                          },
                          controller: this._msgcontlr,
                          decoration: InputDecoration(
                            hintText: "Type a message",
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontFamily: "Poppins",
                                fontSize: 12),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black54, width: 1.0),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15)),
                            ),
                          ),
                        ),
                      )),
                      InkWell(
                        onTap: () {
                          sendMessage();
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                          decoration: BoxDecoration(
                              color: Color(0xFF3598DB),
                              borderRadius: BorderRadius.circular(6)),
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            children: [
                              Text(
                                "Send  ",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              ImageIcon(
                                AssetImage("assets/icons/3.0x/send@3x.png"),
                                color: Colors.white,
                                size: 18,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    ]);
  }

  void sendMessage() {
    if (_typedMessage.isEmpty) return;
    final newMessageObj = messageRef.doc();
    final message = Message(
        id: newMessageObj.id,
        Content: _typedMessage,
        senderId: provider.getUser()?.id ?? "",
        SenderName: provider.getUser()?.userName ?? "",
        Time: DateTime.now().millisecondsSinceEpoch);
    newMessageObj.set(message).then((value) => {
          setState(() {
            _msgcontlr.clear();
          })
        });
  }

  void _close() {
    Navigator.pop(context);
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

