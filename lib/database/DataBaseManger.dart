import 'package:chatapp/model/Message.dart';
import 'package:chatapp/model/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

getUsersRefWithConventer() {
  return FirebaseFirestore.instance
      .collection(User.COLLECTION_NAME)
      .withConverter<User>(
        fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );
}

getMessageRefWithConventer(String roomID) {
  //final roomsRef=getRoomCollectionWithConventer
  //return roomRef.doc(roomID).collection(Message.COLLECTION_NAME).withConverter<Message>(fromFirestore: (snapshot, _) => Message.fromJson(snapshot.data()!),toFirestore: (message, _) => message.toJson(),
  //     );
}
