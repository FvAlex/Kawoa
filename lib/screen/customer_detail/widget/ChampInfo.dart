import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:projet/screen/customer_detail/widget/PlanInfo.dart';

import '../../../modal/Champ.dart';

class ChampInfo extends StatefulWidget {
  late int id_exploitation;
  late int id_joueur;

  ChampInfo({Key? key, required this.id_exploitation, required this.id_joueur})
      : super(key: key);

  @override
  State<ChampInfo> createState() => _ChampInfoState();
}

class _ChampInfoState extends State<ChampInfo> {

  @override
  void initState() {
    super.initState();
    getDataFromFirebaseToChamp();
  }

  Future<List<Champ>> getDataFromFirebaseToChamp() async {
    var response = await FirebaseDatabase.instance.ref()
        .child(
        "/joueur/${widget.id_joueur}/exploitation/${widget.id_exploitation}/champs/")
        .get();
    var decode = jsonEncode(response.value);
    List<Champ> result = List<Champ>.from(
        json.decode(decode).map((champ) => Champ.fromJson(champ)));
    return result;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Champ"),
      ),
      body: FutureBuilder(
        future: getDataFromFirebaseToChamp(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Champ> champs = snapshot.data;
            return ListView.builder(
              itemCount: champs.length,
              itemBuilder: (context, index) {
                Champ champ = champs[index];
                return Card(
                  child:
                  ListTile(
                    title: Text('Champ - ${champ.id}'),
                    subtitle: Text(champ.nom),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              PlanInfo(id_joueur: widget.id_joueur,
                                  id_exploitation: widget.id_exploitation,
                                  id_champ: champ.id))
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
