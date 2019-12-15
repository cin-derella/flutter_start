import 'package:flutter/material.dart';

class ProductControl extends StatelessWidget{
  final Function addProduct;
  
  ProductControl(this.addProduct);

  @override
  Widget build(BuildContext context) {
  
    return RaisedButton(
            color:Theme.of(context).primaryColor,
            onPressed: () {
              addProduct({'title':'Dark Forest','image':'assets/darkforest.jpg'});
            },
            child: Text('Add Book'),
          );
  }
}