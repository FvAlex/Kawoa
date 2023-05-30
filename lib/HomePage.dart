import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';



class HomePage extends StatelessWidget {

  Future<void> getData() async {
    var response = await FirebaseDatabase.instance.ref().child("joueur").get();
    var responseJson = jsonEncode(response.value);
    print(responseJson);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue
              ),
              onPressed: () => getData(),
              child: Text("clique")
            ),
           ),
          ),
      );
  }
}
