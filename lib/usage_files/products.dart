import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:internApp/pages/cart.dart';
import 'package:internApp/pages/product_details.dart';
import 'package:internApp/usage_files/product_provider.dart';
import 'package:provider/provider.dart';

class Products extends StatefulWidget {
  final bool page;
   
  Products(
    this.page,
  );

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context);

    return widget.page == true
        ? Scaffold(
            backgroundColor: Colors.grey[800],
            appBar: AppBar(
              elevation: 0.2,
              automaticallyImplyLeading: true,
              title: Text('   Products Page'),
              actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Cart(),));
              },
            ),
          ],
            ),
    
            body: GridView.builder(
              scrollDirection: Axis.vertical,
              itemCount: products.productsList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
              itemBuilder: (context, int index) {
                return SingleProduct(
                  prodName: products.productsList[index].name,
                  prodImage: products.productsList[index].image,
                  prodId: products.productsList[index].id,
                  prodCategory: products.productsList[index].category,
                  prodPrice: products.productsList[index].price,
                  prodSeller: products.productsList[index].seller,
                  prodContact: products.productsList[index].contact,
                  prodBrand: products.productsList[index].brand,
                  prodDescription: products.productsList[index].description,
                );
              },
            ),
          )
        : GridView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 6,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, int index) {
                return SingleProduct(
                  prodName: products.productsList[index].name,
                  prodImage: products.productsList[index].image,
                  prodId: products.productsList[index].id,
                  prodCategory: products.productsList[index].category,
                  prodPrice: products.productsList[index].price,
                  prodSeller: products.productsList[index].seller,
                  prodContact: products.productsList[index].contact,
                  prodBrand: products.productsList[index].brand,
                  prodDescription: products.productsList[index].description,
                );
              },
      );
  }
}

class SingleProduct extends StatelessWidget {
  final String prodBrand;
  final String prodCategory;
  final String prodId;
  final String prodName;
  final String prodImage;
  final double prodPrice;
  final String prodDescription;
  final String prodSeller;
  final String prodContact; 

  SingleProduct({
    this.prodBrand,
    this.prodCategory,
    this.prodId,
    this.prodName,
    this.prodImage,
    this.prodPrice,
    this.prodDescription,
    this.prodSeller,
    this.prodContact,    
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
        side: BorderSide.none,
      ),
      child: Material(
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductDetails(
                          prodDetailName: prodName,
                          prodDetailImage: prodImage,
                          prodDetailPrice: prodPrice,
                          prodDetailSeller: prodSeller,
                          prodDetailContact: prodContact,
                          prodDetailCategory: prodCategory,
                          prodDetailDescription: prodDescription,
                          prodDetailBrand: prodBrand,
                          prodDetailId: prodId,
                        )));
          },
          child: Material(
            child: Container(
              //color: Colors.red,
              height: 200.0,
              width: 400.0,
              child: GridTile(
                footer: Container(
                  color: Colors.blue[200],
                  child: ListTile(
        
                    title: Text(
                      prodName,
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                    ),
                    
                    subtitle: Text("$prodPrice",
                    style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.red[800], backgroundColor: Colors.red[100]), ),
                    trailing: IconButton(
                      icon: Icon(Icons.favorite),
                      onPressed: () {},
                    ),
                  ),
                ),
                child: Container(
                  height: 100.0,
                  child: Image.network(
                    "$prodImage",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
