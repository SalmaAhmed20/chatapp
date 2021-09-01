import 'package:intl/intl.dart';

class Message{
  static const COLLECTION_NAME='messages';
  String id;
  String content;
  int time;
  String senderName;
  String senderId;
  Message({ required this.id,
    required this.content,
    required this.time,
    required this.senderName,
    required this.senderId});
  Message.fromJson(Map<String ,dynamic>json):this(
    id : json['id'] as String,
    content : json['content'] as String,
    time : json['time'] as int,
    senderName : json['senderName'] as String,
    senderId : json['senderId'] as String,);
  Map<String , Object>toJson(){
    return{
      'id' :id,
      'content' : content,
      'time' : time,
      'senderName' :senderName,
      'senderId' :senderId,
    };
  }
  String getDataFormatted(){
    var outputFormat = DateFormat("HH:mm a");

    return outputFormat.format(DateTime.fromMicrosecondsSinceEpoch(time));
  }
}