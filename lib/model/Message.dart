import 'package:intl/intl.dart';

class Message {
  static const String COLLECTION_NAME = "message";
  String id;
  String Content;
  int Time;
  String SenderName;
  String senderId;
  Message(
      {required this.id,
      required this.Content,
      required this.senderId,
      required this.SenderName,
      required this.Time});
  Message.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as String,
          Content: json['content']! as String,
          Time: json['time']! as int,
          SenderName: json['sender']! as String,
          senderId: json['senderId']! as String,
        );
  Map<String, Object?> toJson() {
    return {
      'id': id,
      'content': Content,
      'time': Time,
      'sender': SenderName,
      'senderId': senderId,
    };
  }

  String getDataFormatted() {
    var FormattedDate = DateFormat("HH:mm a");

    return FormattedDate.format(DateTime.fromMicrosecondsSinceEpoch(Time));
  }
}
