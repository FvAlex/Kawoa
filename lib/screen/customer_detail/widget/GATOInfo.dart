import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../modal/GATO.dart';


class GATOInfo extends StatefulWidget {
  final int id_kafe;
  const GATOInfo({Key? key, required this.id_kafe}) : super(key: key);

  @override
  State<GATOInfo> createState() => _GATOInfoState();
}

class _GATOInfoState extends State<GATOInfo> {

  @override
  void initState() {
    super.initState();
    getDataFromFirebaseToGATO();
  }

  Future<List<GATO>> getDataFromFirebaseToGATO() async {
    var response = await FirebaseDatabase.instance.ref().child("/").get();
    var decode = jsonEncode(response.value);
    print(decode);

    List<GATO> result = List<GATO>.from(json.decode(decode)['joueur'].map((joueur) => GATO.fromJson(joueur)));
    print(result);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GATO>>(
      future: getDataFromFirebaseToGATO(),
      builder: (context, AsyncSnapshot<List<GATO>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          List<GATO>? gatos = snapshot.data;
          return ListView.builder(
            itemCount: gatos?.length,
            itemBuilder: (context, index) {
              GATO gato = gatos![index];
              return Card(
                child:
                ListTile(
                  title: Text('Gato - ${gato.amertume}'),
                  subtitle: Text(gato.gout),
                  onTap: () {
                    Navigator.pop(
                        context
                    );
                  },
                ),
              );
            },
          );
        } else {
          return Text('No data available.');
        }
      },
    );
  }

}

