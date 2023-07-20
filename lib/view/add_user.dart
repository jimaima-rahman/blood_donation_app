import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project1/model/donor_model.dart';
import 'package:project1/service/add_donor_service.dart';

import '../utils/responsive.dart';

// ignore: must_be_immutable
class AddUser extends ConsumerWidget {
  AddUser({
    Key? key,
  }) : super(key: key);

  final List bloodGroups = ['A+', 'B+', 'AB+', "AB-", "O-", "O+", 'A-', "B-"];

  String? selectedGroups;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var donor = ref.watch(donorData);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Users'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(R.sw(10, context)),
            child: TextField(
              controller: donor != null
                  ? TextEditingController(text: donor.name)
                  : namecontroller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text('Donor Name')),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(R.sw(10, context)),
            child: TextField(
              controller: donor != null
                  ? TextEditingController(text: donor.number)
                  : phonecontroller,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text('Phone number')),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(R.sw(10, context)),
            child: DropdownButtonFormField(
                decoration: InputDecoration(
                    label: Text(
                        donor != null ? donor.group : 'Select blood Group')),
                items: bloodGroups
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (val) {
                  selectedGroups = val as String?;
                }),
          ),
          Padding(
            padding: EdgeInsets.all(R.sw(10, context)),
            child: ElevatedButton(
              onPressed: () {
                if (namecontroller.text == "" ||
                    selectedGroups == null ||
                    phonecontroller.text == "") {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Fill all fields")));
                } else {
                  DonorService().addDonor(DonorModel(
                      name: namecontroller.text,
                      group: selectedGroups!,
                      number: phonecontroller.text));

                  Navigator.pop(context);
                }
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
