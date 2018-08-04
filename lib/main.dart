import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Baby Names',
      theme: ThemeData(primaryColor: Colors.white),
      home: const MyHomePage(title: 'Baby Name Votes'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text(title)),
      body: babyNameList(context),
      floatingActionButton: new FloatingActionButton(
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
      ),
    );
  }
}

Widget babyNameList(BuildContext context) {
  var stream = Firestore.instance.collection('baby-names').snapshots();

  return new StreamBuilder(
    stream: stream,
    builder: (context, snapshot) {
      if (!snapshot.hasData) return const Text('Loading...');

      return new ListView.builder(
        itemCount: snapshot.data.documents.length,
        padding: const EdgeInsets.only(top: 10.0),
        itemExtent: 55.0,
        itemBuilder: (context, index) => babyNameListItem(snapshot.data.documents[index]),
      );
    }
  );
}

Widget babyNameListItem(DocumentSnapshot document) {
  return new ListTile(
    key: new ValueKey(document.documentID),
    title: new Container(
      decoration: new BoxDecoration(
        border: new Border.all(color: const Color(0x80000000)),
        borderRadius: new BorderRadius.circular(5.0),
      ),
      padding: const EdgeInsets.all(10.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Text(document['name']),
          ),
          new Text(
            document['votes'].toString(),
          ),
        ],
      ),
    ),
    onTap: () => Firestore.instance.runTransaction((transaction) async {
      DocumentSnapshot freshSnap = await transaction.get(document.reference);

      await transaction.update(freshSnap.reference, {'votes': freshSnap['votes'] + 1});
    }),
  );
}