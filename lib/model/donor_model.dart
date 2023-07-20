import 'package:cloud_firestore/cloud_firestore.dart';

class DonorModel {
  final String name;
  final String group;
  final String number;

  DonorModel({required this.name, required this.group, required this.number});
  factory DonorModel.fromfireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return DonorModel(
        name: data?['Name'], number: data?['phone'], group: data?['group']);
  }

  get data => null;

  Map<String, dynamic> toFirestore() {
    return {'Name': name, 'phone': number, 'group': group};
  }
}
