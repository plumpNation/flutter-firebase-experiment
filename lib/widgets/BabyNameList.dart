import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// If you want to get rid of the firebase class from here
// consider converting the List<DocumentSnapshot> to a List<BabyName>
// https://github.com/flutter/flutter/issues/18459

class BabyNameList extends StatelessWidget {
  BabyNameList({ Key key, this.babyNames }) : super(key: key);

  final List<DocumentSnapshot> babyNames;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: babyNames.length,
      padding: const EdgeInsets.only(top: 10.0),
      itemExtent: 55.0,
      itemBuilder: (context, index) => _babyNameListItem(babyNames[index]),
    );
  }

  Widget _babyNameListItem(DocumentSnapshot document) {
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