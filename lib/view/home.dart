import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project1/service/add_donor_service.dart';
import 'package:project1/utils/responsive.dart';
import 'package:project1/view/add_user.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentdata = ref.watch(streamProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Donation'),
        backgroundColor: Colors.red,
      ),
      body: currentdata.when(
        data: (data) {
          return SafeArea(
            child: SizedBox(
              height: double.infinity,
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: R.sh(10, context),
                  );
                },
                itemCount: data.docs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: R.sw(10, context)),
                    child: Card(
                      child: ListTile(
                          leading: CircleAvatar(
                            radius: R.sw(25, context),
                            backgroundColor: Colors.red,
                            child: Text(data.docs[index].data().group),
                          ),
                          subtitle: Text(data.docs[index].data().number),
                          title: Text(
                            data.docs[index].data().name,
                            style: TextStyle(
                                fontSize: R.sw(20, context),
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.redAccent.shade200,
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.redAccent,
                                  ))
                            ],
                          )),
                    ),
                  );
                },
              ),
            ),
          );
        },
        error: (error, stackTrace) {
          return const Text('Something went wrong');
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return AddUser();
            },
          ));
        },
        backgroundColor: Colors.red,
        child: Icon(
          Icons.add,
          size: R.sw(40, context),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
