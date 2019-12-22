import 'package:flutter_start/models/user.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/user.dart';
import './connected_products.dart';

class UserModel extends ConnectedProducts {
  void login(String email,String password){
    authenticatedUser = User(id:'123',email: email,password: password);

  }


}