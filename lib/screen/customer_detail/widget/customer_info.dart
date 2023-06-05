import 'dart:convert';
import 'dart:html';
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:projet/modal/champ.dart';
import 'package:projet/modal/exploitation.dart';
import 'package:projet/screen/customer_detail/widget/exploitation_info.dart';
import '../../../modal/customer.dart';

class CustomerInfo extends StatefulWidget {
  const CustomerInfo({Key? key}) : super(key: key);

  @override
  State<CustomerInfo> createState() => _CustomerInfoState();
}

class _CustomerInfoState extends State<CustomerInfo> {
  late List customerList = [];

  @override
  initState() {
    super.initState();
    getDataFromFirebaseToJoueur();
  }

  Future<List<Customer>> getDataFromFirebaseToJoueur() async {
    var response = await FirebaseDatabase.instance.ref().child("/joueur/").get();
    var decode = jsonEncode(response.value);
    List<Customer> result = List<Customer>.from(json
        .decode(decode)
        .map((joueur) => Customer.fromJson(joueur)));
    //List<Customer> result = [...json.decode(decode).values.map((customer) => Customer.fromJson(customer))];
    /*µsetState(() {
      customerList = result;
    });*/
    return result;
  }

  @override
  Widget build(BuildContext context) {
    /*return ListView(
        padding: const EdgeInsets.all(8),
        children: customerList.map((e) => Column(
          children: [
            Card(
              child: ListTile(
                title: Column(
                children: [
                  Text("Id: ${e.id}"),
                  Text("Nom: ${e.nom}"),
                  Text("Prenom: ${e.prenom}"),
                  Text("Pseudo: ${e.pseudo}"),
                  Text("Deevee: ${e.deevee}"),
                  Text("Mail: ${e.mail}"),

                 ]
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ExploitationInfo(myList: customerList))
                  );
                },
              ),
            )
          ],
        )).toList(),
    );*/
    return FutureBuilder(
      future: getDataFromFirebaseToJoueur(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<Customer> customers = snapshot.data;
          return ListView.builder(
            itemCount: customers.length,
            itemBuilder: (context, index) {
              Customer customer = customers[index];
              return Card(
                child: ListTile(
                  title: Text('Joueur -  ${customer.id}'),
                  subtitle: Text(customer.pseudo),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ExploitationInfo(id_joueur: customer.id)));
                  },
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
