import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:assign8/fingerprint.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class HomePage extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('CSI'),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to CSI',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 48),
                buildLogoutButton(context),
                SizedBox(height: 48),
                ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.green,
                      context: context,
                      builder: (context) => Column(
                        children: [
                          Padding(padding: EdgeInsets.all(10)),
                          TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              labelText: 'Name',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: mobileController,
                            decoration: InputDecoration(
                              labelText: 'Mobile number',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              CollectionReference collRef =
                                  FirebaseFirestore.instance.collection('Test');
                              collRef.add({
                                'name': nameController.text,
                                'email': emailController.text,
                                'mobile': mobileController.text,
                              });
                              Navigator.pop(context); // Close the bottom sheet
                            },
                            child: Text('Submit'),
                          )
                        ],
                      ),
                    );
                  },
                  child: Text('Register'),
                ),
              ],
            ),
          ),
        ),
      );

  Widget buildLogoutButton(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(50),
        ),
        child: Text(
          'Logout',
          style: TextStyle(fontSize: 20),
        ),
        onPressed: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => FingerprintPage()),
        ),
      );
}
