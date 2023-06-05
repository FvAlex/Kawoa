import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:projet/modal/kafe.dart';
import 'package:projet/screen/customer_detail/widget/kafe_info.dart';

import '../../../modal/plan.dart';


class PlanInfo extends StatefulWidget {
  late int id_joueur;
  late int id_exploitation;
  late int id_champ;

  PlanInfo({Key? key, required this.id_champ, required this.id_exploitation, required this.id_joueur}) : super(key: key);

  @override
  State<PlanInfo> createState() => _PlanInfoState();
}

class _PlanInfoState extends State<PlanInfo> {

  @override
  void initState() {
    super.initState();
    getDataFromFirebaseToPlan();
  }

  Future<List<Plan>> getDataFromFirebaseToPlan() async {
    var response = await FirebaseDatabase.instance.ref().child(
        "/joueur/1/exploitation/${widget
            .id_exploitation}/champs/${widget.id_champ}/plan/").get();
    var decode = jsonEncode(response.value);
    List<Plan> result = List<Plan>.from(
        json.decode(decode).map((plan) => Plan.fromJson(plan)));
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Plan"),
      ),
      body: FutureBuilder(
        future: getDataFromFirebaseToPlan(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Plan> plans = snapshot.data;
            return ListView.builder(
              itemCount: plans.length,
              itemBuilder: (context, index) {
                Plan plan = plans[index];
                return Card(
                  child:
                  ListTile(
                    title: Text('Plan - ${plan.id}'),
                    subtitle: Text(plan.nom),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              KafeInfo(id_joueur: widget.id_joueur,
                                  id_exploitation: widget.id_exploitation,
                                  id_champ: widget.id_champ, id_plan: plan.id))
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