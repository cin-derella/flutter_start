import 'package:flutter/material.dart';
import 'package:flutter_start/pages/product_edit.dart';
import './product_edit.dart';

class ProductListPage extends StatelessWidget {
  final Function updateProduct;
  final Function deleteProdut;
  final List<Map<String, dynamic>> products;
  ProductListPage(this.products, this.updateProduct,this.deleteProdut);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
            key: Key(products[index]['title']),
            onDismissed: (DismissDirection direction){
              if(direction == DismissDirection.endToStart){
                deleteProdut(index);
                print('Swiped end to start');
              }else if(direction ==DismissDirection.startToEnd){
                print('Swiped start to end');
              }else{
                print('Other swiping');
              }
            },
            background: Container(color: Colors.red),

            child: Column(children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(products[index]['image']),
                ),
                title: Text(products[index]['title']),
                subtitle: Text('\¥${products[index]['price'].toString()}'),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return ProductEditPage(
                            product: products[index],
                            updateProduct: updateProduct,
                            productIndex: index,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              Divider()
            ]));
      },
      itemCount: products.length,
    );
  }
}
