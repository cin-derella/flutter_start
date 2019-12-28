import 'package:flutter/material.dart';
import 'package:flutter_start/utils.dart';
import 'package:scoped_model/scoped_model.dart';
import '../widgets/helpers/ensure_visible.dart';
import '../models/product.dart';
import '../scoped-models/main.dart';

class ProductEditPage extends StatefulWidget {
  final MainModel model;
  ProductEditPage(this.model);
  @override
  State<StatefulWidget> createState() {
    return _ProductEditPageState();
  }
}

class _ProductEditPageState extends State<ProductEditPage> {
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'assets/darkforest.jpg'
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();

  @override
  initState() {
    /*
    widget.model.fetchProducts().then((_) {
      print('fetch in productEditPageState initState');
      widget.model.selectProduct(null);
    });
    */
    super.initState();
  }

  void _submitForm(
      Function addProduct, Function updateProduct, Function setSelectedProduct,
      [int selectedProductIndex]) {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();
    if (selectedProductIndex == -1) {
      addProduct(_formData['title'], _formData['description'],
              _formData['image'], _formData['price'])
          .then((bool success) {
        if (success) {
          Navigator.pushReplacementNamed(context, '/products');
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Something went wrong'),
                  content: Text('Please try again'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Okay'),
                    )
                  ],
                );
              });
        }
      });
      //.then((_) => setSelectedProduct(null));
    } else {
      updateProduct(_formData['title'], _formData['description'],
              _formData['image'], _formData['price'])
          .then((_) {
        Navigator.pushReplacementNamed(context, '/products');
        //setSelectedProduct(null);
      });
      //.then((_) => setSelectedProduct(null));
      //setSelectedProduct(null);
      //widget.model.notifyListeners();
    }
  }

  Widget _buildTitleTextField(Product product) {
    print(LogStamp().stamp() + 'buildTitleTextField:' + product.toString());
    return EnsureVisibleWhenFocused(
      focusNode: _titleFocusNode,
      child: TextFormField(
        focusNode: _titleFocusNode,
        decoration: InputDecoration(labelText: 'Book Title'),
        initialValue: product == null ? '' : product.title,
        validator: (String value) {
          //if(value.trim().length <= 0){
          if (value.isEmpty || value.length < 5) {
            return "Title is required and should be 5+ characters long.";
          } else {
            return null;
          }
        },
        //keyboardType: TextInputType.number,
        onSaved: (String value) {
          _formData['title'] = value;
        },
      ),
    );
  }

  Widget _buildDescriptionTextField(Product product) {
    return EnsureVisibleWhenFocused(
      focusNode: _descriptionFocusNode,
      child: TextFormField(
        focusNode: _descriptionFocusNode,
        //maxLines: 4,
        decoration: InputDecoration(labelText: 'Book Description'),
        initialValue: product == null ? '' : product.description,
        validator: (String value) {
          //if(value.trim().length <= 0){
          if (value.isEmpty || value.length < 10) {
            return "Description is required and should be 10+ characters long.";
          } else {
            return null;
          }
        },
        //keyboardType: TextInputType.number,
        onSaved: (String value) {
          _formData['description'] = value;
        },
      ),
    );
  }

  Widget _buildPriceTextField(Product product) {
    return EnsureVisibleWhenFocused(
      focusNode: _priceFocusNode,
      child: TextFormField(
        focusNode: _priceFocusNode,
        decoration: InputDecoration(labelText: 'Book Price'),
        initialValue: product == null ? '' : product.price.toString(),
        validator: (String value) {
          //if(value.trim().length <= 0){
          if (value.isEmpty ||
              !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
            return "Price is required and should be a number.";
          } else {
            return null;
          }
        },
        keyboardType: TextInputType.number,
        onSaved: (String value) {
          _formData['price'] = double.parse(value);
        },
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.isLoading
            ? Center(child: CircularProgressIndicator())
            : RaisedButton(
                child: Text('Save'),
                //color: Theme.of(context).accentColor,
                textColor: Colors.white,
                onPressed: () => _submitForm(
                    model.addProduct,
                    model.updateProduct,
                    model.selectProduct,
                    model.selectedProductIndex),
              );
      },
    );
  }

  Widget _buildPageContent(BuildContext context, Product product) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        width: targetWidth,
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
            children: <Widget>[
              _buildTitleTextField(product),
              _buildDescriptionTextField(product),
              _buildPriceTextField(product),
              SizedBox(
                height: 10.0,
              ),
              _buildSubmitButton(),
              // GestureDetector(
              //   onTap: _submitForm,
              //   child: Container(
              //     color: Colors.green,
              //     padding: EdgeInsets.all(5.0),
              //     child: Text('My Button'),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      print(LogStamp().stamp() +
          ":product edit page:build: " +
          model.selectedProductIndex.toString());

      final Widget pageContent =
          _buildPageContent(context, model.selectedProduct);
      return model.selectedProductIndex == -1
          ? pageContent
          : Scaffold(
              appBar: AppBar(
                title: Text('Edit Product'),
              ),
              body: pageContent,
            );
    });
  }
}
