import 'package:drohealthapp/model/store_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductBloc with ChangeNotifier {

  List<Products> _products=[];
  List<Products>  get products => _products;

  List<Products> _searchResult=[];
  List<Products>  get searchResult => _searchResult;


  void initialize(List<Products> productsList) {
    // i'm using this to store a mock data of the items fetched on the home scrreen
    _products = productsList;
    _searchResult = productsList;
    notifyListeners();
  }

  // to immitate the searching of an item
  void searchProduct(String query) {
    if(query.isEmpty)
      _searchResult = products;
    else
    _searchResult =_products.where((element) => element.name!.toLowerCase().contains(query.toLowerCase())).toList();
    notifyListeners();
  }

  void clearAll(P) {
    _products.clear();
    notifyListeners();
  }

  double getTotal(){
    double total=0;
    for(Products p in _products){
      total+=p.quantity! * double.parse(p.price!);
    }
    return total;
  }
}