import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class BabyCreate extends StatelessWidget {
  BabyCreate({Key key}) : super(key: key);

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
  Baby baby = new Baby();

  String babyName;

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
        showInSnackBar(context, 'Saving baby name ' + babyName);
      }
    }

    debugPrint('building BabyFormState');

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
              debugPrint('onSaved');

              babyName = value;
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
  String name = '';
}

void showInSnackBar(BuildContext context, String value) {
  Scaffold.of(context).showSnackBar(new SnackBar(
    content: new Text(value)
  ));
}
