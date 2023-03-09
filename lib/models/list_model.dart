import 'package:cloud_firestore/cloud_firestore.dart';

class ListModel {
  int colorIndex;
  String list;
  String listID;

  ListModel({
    this.listID = '',
    this.colorIndex = 0,
    required this.list,
  });

  factory ListModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ListModel(
      colorIndex: data?['colorIndex'],
      list: data?['list'],
      listID: data?['listID'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "colorIndex": colorIndex,
      "list": list,
      "listID": listID,
    };
  }
}
