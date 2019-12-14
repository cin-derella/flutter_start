import 'package:flutter/material.dart';
import './products.dart';

class ProductManager extends StatefulWidget {
  final String startingProduct;
  ProductManager(this.startingProduct) {
    print('[ProductsManager] Constructor');
  }
  @override
  State<StatefulWidget> createState() {
    print('[ProductsManager] createState()');
    // TODO: implement createState
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductManager> {
  List<String> _products = [];
  @override
  void initState() {
    print('[ProductsManager] initState()');
    _products.add(widget.startingProduct);
    super.initState();
  }
@override
  void didUpdateWidget(ProductManager oldWidget) {
    print('[ProductsManager State] didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    print('[ProductsManager State] build()');
    // TODO: implement build
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10.0),
          child: RaisedButton(
            color:Theme.of(context).primaryColor,
            onPressed: () {
              setState(() {
                _products.add('Advanced Dark Forest');
              });
            },
            child: Text('Add Book'),
          ),
        ),
        Products(_products)
      ],
    );
  }
}
