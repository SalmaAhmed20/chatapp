import 'package:chatapp/model/Message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageWidget extends StatelessWidget {
  Message? message;
   MessageWidget(this.message);

  @override
  Widget build(BuildContext context) {
    //final provider = Provider.of<AppConfigProvider>(context);
    return message==null?Container():(
    //message?.senderId==provider.myUser?.id?
        //SentMessage(message!):
        RecieveMessage(message!)
    );
  }
}

class SentMessage  extends StatelessWidget {
  Message? message;
   SentMessage (this.message);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(message!.getDataFormatted()),
        Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(topRight: Radius.circular(12),
            bottomRight: Radius.circular(12))
          ),
          child:Text(message!.content,style: TextStyle(
            color:Colors.white
          ),)
        )
      ],
    );
  }
}
class RecieveMessage extends StatelessWidget {
  Message? message;
   RecieveMessage(this.message);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color:Color.fromARGB(255,248,248,248),
            borderRadius: BorderRadius.only(topRight: Radius.circular(12),
            bottomRight: Radius.circular(12))

          ),
          child:Text(message!.content,
          style: TextStyle(
            color:Color.fromARGB(255, 120, 121, 122),
          ),)
        ),
        Text(message!.getDataFormatted())
      ],
    );
  }
}

