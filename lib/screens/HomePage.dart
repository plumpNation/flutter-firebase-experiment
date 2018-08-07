import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_firebase/screens/BabyCreate.dart';
import 'package:flutter_firebase/widgets/BabyList.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: babyStreamList(context),
      floatingActionButton: actionButton(context)
    );
  }
}

/// Wraps the BabyList to separate the data from the widget.
Widget babyStreamList(context) {
  return StreamBuilder(
    stream: Firestore.instance.collection('baby-names').snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return const Text('Loading...');

      return BabyList(babies: snapshot.data.documents);
    }
  );
}

Widget actionButton(context) {
  return FloatingActionButton(
    tooltip: 'Add name',
    elevation: 5.0,
    child: Icon(Icons.add),
    onPressed: () {
      Navigator
        .of(context)
        .push(MaterialPageRoute(builder: (context) => BabyCreate()));
    },
  );
}
