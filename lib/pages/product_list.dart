import 'package:flutter/material.dart';
import 'package:flutter_start/pages/product_edit.dart';
import './product_edit.dart';
import '../scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductListPage extends StatefulWidget {
  final MainModel model;
  ProductListPage(this.model);

  @override
  State<StatefulWidget> createState() {

    return _ProductListPageState();
  }

}

class _ProductListPageState extends State<ProductListPage>{
  @override
  initState(){
    widget.model.fetchProducts().then((_){
      print('fetch in productListPageState initState');
      widget.model.selectProduct(null);});
    
    super.initState();
  }
  Widget _buildEditButton(BuildContext context, int index, MainModel model) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        model.selectProduct(model.allProducts[index].id);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ProductEditPage();
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        print(DateTime.now().second.toString() +
          "." +
          DateTime.now().microsecond.toString() + 'product list page:build' + model.selectedProductId.toString());
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            String image = model.allProducts[index].image;
            //print('image is:' + image);
            return Dismissible(
                key: Key(model.allProducts[index].title),
                onDismissed: (DismissDirection direction) {
                  if (direction == DismissDirection.endToStart) {
                    model.selectProduct(model.allProducts[index].id);
                    model.deleteProduct(index);
                    print('Swiped end to start');
                  } else if (direction == DismissDirection.startToEnd) {
                    print('Swiped start to end');
                  } else {
                    print('Other swiping');
                  }
                },
                background: Container(color: Colors.red),
                child: Column(children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(model.allProducts[index].image),
                          //AssetImage('assets/background.jpg'),
                    ),
                    title: Text(model.allProducts[index].title),
                    subtitle:
                        Text('\¥${model.allProducts[index].price.toString()}'),
                    trailing: _buildEditButton(context, index, model),
                  ),
                  Divider()
                ]));
          },
          itemCount: model.allProducts.length,
        );
      },
    );
  }
}
