import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project1/model/donor_model.dart';

class DonorService {
  final CollectionReference<DonorModel> donor =
      FirebaseFirestore.instance.collection('donor').withConverter(
            fromFirestore: DonorModel.fromfireStore,
            toFirestore: (value, options) => value.toFirestore(),
          );
  Stream<QuerySnapshot<DonorModel>> get donors => donor.snapshots();

  Future<DocumentReference<DonorModel>> addDonor(DonorModel donorModel) {
    return donor.add(donorModel);
  }

  deleteDonor(String id) {
    return donor.doc(id).delete();
  }

  Future<void> updateDonor(
      String id, String updatedname, String updatedgroup, String updatedphone) {
    return donor.doc(id).update(
        {'Name': updatedname, 'phone': updatedphone, 'group': updatedgroup});
  }
}

final donorProvider = Provider<DonorService>((ref) {
  return DonorService();
});
final streamProvider = StreamProvider((ref) {
  return ref.read(donorProvider).donors;
});
