import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/responsive.dart';

// ignore: must_be_immutable
class AddUser extends ConsumerWidget {
  AddUser({super.key});

  final List bloodGroups = ['A+', 'B+', 'AB+', "AB-", "O-", "O+", 'A-', "B-"];
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');
  String? selectedGroups;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();

  void addDonors() {
    final data = {
      'Name': namecontroller.text,
      'group': selectedGroups,
      'Phone': phonecontroller.text
    };
    donor.add(data);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // var updatedData = ref.watch(streamProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Users'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(R.sw(10, context)),
            child: TextField(
              controller: namecontroller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text('Donor Name')),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(R.sw(10, context)),
            child: TextField(
              controller: phonecontroller,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text('Phone number')),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(R.sw(10, context)),
            child: DropdownButtonFormField(
                decoration: InputDecoration(label: Text('Select blood Group')),
                items: bloodGroups
                    .map((e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ))
                    .toList(),
                onChanged: (val) => selectedGroups = val as String?),
          ),
          Padding(
            padding: EdgeInsets.all(R.sw(10, context)),
            child: ElevatedButton(
              onPressed: () {
                // DonorService().addDonor();
                addDonors();
                Navigator.pop(context);
              },
              child: Text(
                'submit',
                style:
                    TextStyle(fontSize: R.sw(20, context), color: Colors.white),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  minimumSize: MaterialStateProperty.all(
                      Size(double.infinity, R.sh(45, context)))),
            ),
          )
        ],
      ),
    );
  }
}
