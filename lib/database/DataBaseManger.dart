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
