import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_firebase/widgets/BabyNameList.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text(title)),
      body: babyNameStreamList(context),
      floatingActionButton: actionButton(context)
    );
  }
}

/// Wraps the BabyNameList to separate the data from the widget.
Widget babyNameStreamList(context) {
  return new StreamBuilder(
    stream: Firestore.instance.collection('baby-names').snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return const Text('Loading...');

      return new BabyNameList(
        babyNames: snapshot.data.documents
      );
    }
  );
}

Widget actionButton(context) {
  return new FloatingActionButton(
    tooltip: 'Add name',
    elevation: 0.0,
    child: new Icon(Icons.add),
    onPressed: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Add baby name')
              ),
              body: Form(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a name';
                          }
                        },
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: RaisedButton(
                        onPressed: () {
                          Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text('Processing Data')));
                        },
                        child: Text('Submit'),
                      ),
                    ),
                  ]
                ),
              )
            );
          },
        ),
      );
    },
  );
}