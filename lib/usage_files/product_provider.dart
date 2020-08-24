import 'package:flutter/material.dart';
import 'package:internApp/models/product_model.dart';
import 'package:internApp/usage_files/product_services.dart';

class ProductsProvider with ChangeNotifier{
  List<Product> productsList = [];
  ProductService _productsServices = ProductService();
  List productsInCart  = [
     
  ];

  ProductsProvider(){
    loadProducts();
    addcartProducts();
  }
  Future loadProducts()async{
    productsList = await _productsServices.getProducts();
    notifyListeners();
  }

  addcartProducts()
  {

  }

}