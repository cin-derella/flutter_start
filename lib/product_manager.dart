import 'package:flutter/material.dart';
import './products.dart';
import './product_control.dart';

class ProductManager extends StatefulWidget {
  final String startingProduct;
  ProductManager({this.startingProduct='Three body series'}) {
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

void _addProduct(String product){
  setState(() {
    _products.add('Advanced Dark Forest');
  });
}

  @override
  Widget build(BuildContext context) {
    print('[ProductsManager State] build()');
    // TODO: implement build
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10.0),
          child: ProductControl(_addProduct),
        ),
        Products(_products)
      ],
    );
  }
}
