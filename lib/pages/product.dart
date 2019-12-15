import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Book Detail'),
        ),
        body: Column(
          children: <Widget>[
            Text('Details!'),
            RaisedButton(
              child: Text('BACK'),
              onPressed: () => Navigator.pop(context),
            )
          ],
        )
        //Center(child: Text('On the Book Page'),),
        );
  }
}
