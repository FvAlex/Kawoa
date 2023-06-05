import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:projet/screen/customer_detail/widget/gato_info.dart';

import '../../../modal/kafe.dart';


class KafeInfo extends StatefulWidget {
  final int id_plan;
  final int id_champ;
  final int id_exploitation;
  final int id_joueur;

  const KafeInfo({Key? key, required this.id_plan, required this.id_champ, required this.id_exploitation, required this.id_joueur}) : super(key: key);

  @override
  State<KafeInfo> createState() => _KafeInfoState();
}

class _KafeInfoState extends State<KafeInfo> {

  @override
  void initState() {
    super.initState();
    getDataFromFirebaseToKafe();
  }

  Future<List<Kafe>> getDataFromFirebaseToKafe() async {
    var response = await FirebaseDatabase.instance.ref().child("/joueur/0/exploitation/0/champs/0/plan/0/kafe/0/").get();
    var decode = jsonEncode(response.value);
    print(decode);
    List<Kafe> result = List<Kafe>.from(json.decode(decode).map((kafe) => Kafe.fromJson(kafe)));
    print(result);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kafe"),
      ),
      body: FutureBuilder(
        future: getDataFromFirebaseToKafe(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            List<Kafe> kafes = snapshot.data;
            return ListView.builder(
              itemCount: kafes.length,
              itemBuilder: (context, index) {
                Kafe kafe = kafes[index];
                return Card(
                  child:
                  ListTile(
                    title: Text('Kafe - ${kafe.id}'),
                    subtitle: Text(kafe.nom),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GATOInfo(id_kafe: kafe.id))
                      );
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
      ),
    );
  }

}


