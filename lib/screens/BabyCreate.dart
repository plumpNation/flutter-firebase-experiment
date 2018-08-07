import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BabyCreate extends StatelessWidget {
  BabyCreate({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add baby name')
      ),
      body: BabyForm()
    );
  }
}

class BabyForm extends StatefulWidget {
  @override
  BabyFormState createState() {
    return BabyFormState();
  }
}

class BabyFormState extends State<BabyForm> {
  Baby baby = Baby();

  final Firestore firestore = Firestore.instance;
  CollectionReference get babyFirestore => firestore.collection('baby-names');

  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form.
  //
  // Note: This is a `GlobalKey<FormState>`, not a GlobalKey<BabyFormState>!
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void _handleSubmitted() {
      // Firestore.instance.collection('baby-names').
      final FormState form = _formKey.currentState;

      if (!form.validate()) {
        showInSnackBar(context, 'Please fix the errors in red before submitting.');

      } else {
        form.save(); // this runs the `onSaved` callback on the TextFormField
        showInSnackBar(context, 'Saving baby name ' + baby.name);

        Map <String, dynamic> babyData = baby.toJson();

        babyFirestore
          .document(baby.name)
          .setData(babyData);
      }
    }

    // Build a Form widget using the _formKey we created above
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
            },
            onSaved: (String value) {
              baby.name = value;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: _handleSubmitted,
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}

/// The baby model
class Baby {
  Baby();

  String name = '';
  int votes = 0;

  /// Serialise json to a Baby object
  Baby.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        votes = json['votes'];

  /// Create json from the Baby object.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'votes': votes,
    };
  }
}

void showInSnackBar(BuildContext context, String value) {
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text(value)
  ));
}
