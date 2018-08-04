import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// If you want to get rid of the firebase class from here
// consider converting the List<DocumentSnapshot> to a List<Baby>
// https://github.com/flutter/flutter/issues/18459

class BabyList extends StatelessWidget {
  BabyList({ Key key, this.Babys }) : super(key: key);

  final List<DocumentSnapshot> Babys;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Babys.length,
      padding: const EdgeInsets.only(top: 10.0),
      itemExtent: 55.0,
      itemBuilder: (context, index) => _BabyListItem(Babys[index]),
    );
  }

  Widget _BabyListItem(DocumentSnapshot document) {
    return ListTile(
      key: ValueKey(document.documentID),
      title: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0x80000000)),
          borderRadius: BorderRadius.circular(5.0),
        ),
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(document['name']),
            ),
            Text(
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
}