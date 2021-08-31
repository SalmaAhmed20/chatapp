import 'package:chatapp/model/Room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference <Room> getRoomsCollectionWithConverter(){
  return FirebaseFirestore.instance.collection(Room.COLLECTION_NAME)
      .withConverter<Room>(
    fromFirestore:(snapshot,_)=>Room.fromJson(snapshot.data()!),
    toFirestore:(room,_)=>room.toJson(),
  );
}
