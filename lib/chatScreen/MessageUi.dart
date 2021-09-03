import 'package:chatapp/appConfigProvider/AppProvider.dart';
import 'package:chatapp/model/Message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageWidget extends StatelessWidget {
  Message? message;
  MessageWidget(this.message);
  late AppProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context);
    return message == null
        ? Container()
        : (message?.senderId == provider.getUser().id
            ? SentMessage(message!)
            : RecieveMessage(message!));
  }
}

class SentMessage extends StatelessWidget {
  Message? message;
  SentMessage(this.message);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          message!.getDataFormatted(),
          style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 12,
              fontWeight: FontWeight.normal),
        ),
        Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Color(0xFF3598DB),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12))),
            child: Text(
              message!.Content,
              style: TextStyle(
                  color: Colors.white, fontSize: 20, fontFamily: "OpenSans"),
            ))
      ],
    );
  }
}

class RecieveMessage extends StatelessWidget {
  Message? message;
  RecieveMessage(this.message);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                message!.SenderName,
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Color(0xFFE7E6E6),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12),
                          topLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12))),
                  child: Text(
                    message!.Content,
                    style: TextStyle(
                        color: Color(0xFF787993),
                        fontSize: 20,
                        fontFamily: "OpenSans"),
                  )),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                message!.getDataFormatted(),
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 12,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
