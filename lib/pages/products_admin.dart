import 'package:flutter/material.dart';
//import 'package:flutter_start/models/product.dart';
import './product_edit.dart';
import './product_list.dart';
import '../scoped-models/main.dart';
import '../widgets/ui_elements/logout_list_tile.dart';

class ProductsAdminPage extends StatelessWidget {
  final MainModel model;
  ProductsAdminPage(this.model);

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Choose'),
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('All Books'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/products');
            },
          ),
          Divider(),
          LogoutListTile()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: _buildSideDrawer(context),
        appBar: AppBar(
          title: Text('Manage Books'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.create),
                text: 'Create Product',
              ),
              Tab(
                icon: Icon(Icons.list),
                text: 'My Books',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[ProductEditPage(model), ProductListPage(model)],
        ),
      ),
    );
  }
}
