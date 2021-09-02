import 'package:chatapp/model/Message.dart';
import 'package:chatapp/model/Room.dart';
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

CollectionReference<Room> getRoomsCollectionWithConverter(){
  return FirebaseFirestore.instance.collection(Room.COLLECTION_NAME).withConverter<Room>(
    fromFirestore: (snapshot, _) => Room.fromJson(snapshot.data()!),
    toFirestore: (room, _) => room.toJson(),
  );
}
CollectionReference<Message> getMessagesCollectionWithConverter(
    String roomId
    ){
  final roomCollection = getRoomsCollectionWithConverter();
  return roomCollection.doc(roomId).collection(Message.COLLECTION_NAME).withConverter<Message>(
    fromFirestore: (snapshot, _) => Message.fromJson(snapshot.data()!),
    toFirestore: (message, _) => message.toJson(),

  );
}