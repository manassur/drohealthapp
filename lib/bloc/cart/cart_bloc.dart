import 'package:drohealthapp/model/store_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartBloc with ChangeNotifier {

  List<Products> _cartItems=[];
  List<Products>  get cartItems => _cartItems;


  void addToCart(Products product) {
    // don't allow adding of products with 0 as quantity
    // remove the previous instance of that product
    if(product.quantity!<1){
      Fluttertoast.showToast(msg: 'Please indicate quantity');
    }else{
      /** I need to make sure i don't have repeted items hence
       *  i'll replace every instance of an item with a particular productId
       *  with the new item and updated quantity
       * **/
      // this removes any existence of that item before
    _cartItems.removeWhere((element) => element.id==product.id);

    // then it adds the updated item with the new quantity
    _cartItems.add(product);
    notifyListeners();
    }
  }

  void removeFromCart(String id) {
    _cartItems.removeWhere((element) => element.id==id);
    notifyListeners();
  }

  void clearAll(P) {
    _cartItems.clear();
    notifyListeners();
  }

  double getTotal(){
    double total=0;
    for(Products p in _cartItems){
      total+=p.quantity! * double.parse(p.price!);
    }
    return total;
  }
}