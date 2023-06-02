import 'package:flutter/material.dart';

class TabInfo extends StatelessWidget {
  const TabInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: [
        Tab(icon: Icon(Icons.account_circle)),
        Tab(icon: Icon(Icons.assignment))
      ],
    );
  }
}
