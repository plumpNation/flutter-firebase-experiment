import 'package:flutter/material.dart';

class BabyNameCreate extends StatelessWidget {
  BabyNameCreate({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
  }
}