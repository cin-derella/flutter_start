import 'package:flutter/material.dart';
import 'package:flutter_start/models/product.dart';
import './product_card.dart';
import '../../models/product.dart';
import '../../scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';


class Products extends StatelessWidget {

  Widget _buildProductLists(List<Product>products) {
    Widget productCards;
    if (products.length > 0) {
      productCards = ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            ProductCard(products[index], index),
        itemCount: products.length,
      );
    } else {
      productCards = Container();
      //Center(child: Text('No books found, please add some'),);
    }
    return productCards;
  }

  @override
  Widget build(BuildContext context) {
    print('[Products Widget] build()');
    return ScopedModelDescendant<MainModel>(builder:(BuildContext context, Widget child, MainModel model){
        return _buildProductLists(model.displayedProducts) ;
     },) ;
  }
}
