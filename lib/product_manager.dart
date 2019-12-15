import 'package:flutter/material.dart';
import './products.dart';
import './product_control.dart';

class ProductManager extends StatefulWidget {
  final Map<String,String> startingProduct;
  ProductManager({this.startingProduct}) {
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
  List<Map<String,String>> _products = [];

  @override
  void initState() {
    print('[ProductsManager] initState()');
    if(widget.startingProduct != null){
    _products.add(widget.startingProduct);
    }
   
    super.initState();
  }

  @override
  void didUpdateWidget(ProductManager oldWidget) {
    print('[ProductsManager State] didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }

  void _addProduct(Map<String,String> product) {
    setState(() {
      _products.add(product);
    });
  }

  void _deleteProduct(int index){
    setState((){
      _products.removeAt(index);
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
        Expanded( child: Products(_products,deleteProduct:_deleteProduct))
      ],
    );
  }
}
