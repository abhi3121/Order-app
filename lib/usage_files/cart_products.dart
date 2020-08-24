import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:internApp/usage_files/product_provider.dart';
import 'package:provider/provider.dart';

class CartProducts extends StatefulWidget {
  @override
  _CartProductsState createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {

  
  @override
  void initState()
  { 
    super.initState();
  }
  // var productsInCart = [
  //   {
  //     "name": "Pickle",
  //     "image": "images/food.jpeg",
  //     "price": "250/kg",
  //     "seller": "Parul",
  //     "quantity": 1
  //   },
  //   {
  //     "name": "Frock",
  //     "image": "images/lady.jpeg",
  //     "price": "650",
  //     "seller": "Naman",
  //     "quantity": 1
  //   },
  //   {
  //     "name": "Frock",
  //     "image": "images/lady.jpeg",
  //     "price": "650",
  //     "seller": "Naman",
  //     "quantity": 1
  //   },
  // ];
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context);
    return ListView.builder(
      itemCount: products.productsInCart.length,
      itemBuilder: (context, index){
       return SingleCartProduct(
        cartprodName: products.productsInCart[index]["name"],
        cartprodImage: products.productsInCart[index]["image"],
        cartprodPrice: products.productsInCart[index]["price"],
        cartprodSeller: products.productsInCart[index]["seller"],        
       );
      }
    );
      
    
  }

  

}

class SingleCartProduct extends StatelessWidget {
  final cartprodName;
  final cartprodImage;
  final cartprodPrice;
  final cartprodSeller;
  //final cartprodQuantity;

  SingleCartProduct({
    this.cartprodName,
    this.cartprodImage,
    this.cartprodPrice,
    this.cartprodSeller,
    //this.cartprodcontact
  });
  
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context);
    return  Card(
      clipBehavior: Clip.antiAlias,
      elevation: 10.0,
      child: ListTile(
        leading: Image.asset(cartprodImage),
        trailing: IconButton(
          onPressed: (){
            products.productsInCart.remove({
              "name": this.cartprodName,
              "image":this.cartprodImage,
              "price": this.cartprodPrice,
              "seller": this.cartprodSeller
              
            });
            //this.build(context);
          },
          icon: Icon(
            Icons. delete,
            size: 40.0,
            color:  Colors.red,
            ),
          ), 
        title: Text(cartprodName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
        subtitle: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Price : ", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(cartprodPrice.toString()),                  
                ),

                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text("Quantity : ", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(4.0),
                //   child: Text("$cartprodQuantity"),
                // ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Seller : ", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text("$cartprodSeller"),
                ),
              ],
          ),

           
          ],
        ),
      ),      
    );
  }
}