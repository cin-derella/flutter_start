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
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/darkforest.jpg'),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text('Details!'),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: RaisedButton(
                color:Theme.of(context).accentColor,
                child: Text('BACK'),
                onPressed: () => Navigator.pop(context),
              ),
            )
          ],
        )
        //Center(child: Text('On the Book Page'),),
        );
  }
}
