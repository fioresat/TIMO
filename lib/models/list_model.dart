import 'package:cloud_firestore/cloud_firestore.dart';

class ListModel {
  int listColorIndex;
  String list;
  String listID;

  ListModel({
    this.listID = '',
    this.listColorIndex = 0,
    required this.list,
  });

  factory ListModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ListModel(
      listColorIndex: data?['listColorIndex'],
      list: data?['list'],
      listID: data?['listID'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "listColorIndex": listColorIndex,
      "list": list,
      "listID": listID,
    };
  }
}
