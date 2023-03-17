import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  int locale;
  String userID;

  UserModel({
    this.userID = 'testUser',
    this.locale = -1,
  });

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserModel(
      locale: data?['locale'],
      userID: data?['userID'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "locale": locale,
      "userID": userID,
    };
  }
}
