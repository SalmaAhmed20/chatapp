import 'package:chatapp/appConfigProvider/AppProvider.dart';
import 'package:chatapp/model/Message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = "Chat";
  String title;

  //RoomDetails
  ChatScreen(this.title);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String _typedMessage = '';
  //late CollectionReference<Message> messageRef;
  late AppProvider provider;
  late TextEditingController _msgcontlr;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _msgcontlr=TextEditingController(text: _typedMessage);
  }
  @override
  Widget build(BuildContext context) {
    provider =Provider.of<AppProvider>(context);
    //messageRef=getMessageRefWithConventer(String roomID);
    //final Stream<QuerySnapshot<Message>> _messageStream = messageRef.snapshots();
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
              title: _labels(widget.title)),
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
                Expanded(child:Container()
                // StreamBuilder<QuerySnapshot<Message>>(
                //   stream:_messageStream ,
                //   builder: (BuildContext buildContext, AsyncSnapshot<QuerySnapshot<Message>> snapshot){
                //     if (snapshot.hasError)
                //       return Text(snapshot.error.toString());
                //     else if(snapshot.hasData){
                //
                //     }
                //     return Center(child: CircularProgressIndicator(),);
                //   }
                // )
                ),
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
    if(_typedMessage.isEmpty)return;
    // final newMessageObj=messageRef.doc()
    // final message = Message(id:newMessageObj.id,content:_typedMessage,SenderName:provider._currentUser.userName,Time:DateTime.now().millisecondsSinceEpoch,
    //newMessageObj.set(message).then((value)=>{
    //setState(() {
    //      _msgcontlr.clear();
    //     });
    //
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
