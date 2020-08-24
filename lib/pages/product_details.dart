import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:internApp/pages/cart.dart';
import 'package:internApp/usage_files/product_provider.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final String prodDetailName;
  final String prodDetailImage;
  final double prodDetailPrice;
  final String prodDetailSeller;
  final String prodDetailCategory;
  final String prodDetailId;
  final String prodDetailDescription;
  final String prodDetailContact;
  final String prodDetailBrand;

  ProductDetails({
    this.prodDetailName,
    this.prodDetailImage,
    this.prodDetailPrice,
    this.prodDetailSeller,
    this.prodDetailCategory,
    this.prodDetailId,
    this.prodDetailDescription,
    this.prodDetailContact,
    this.prodDetailBrand, 
 });

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context);
    return SafeArea(
      left: false,
      right: false,
      child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          resizeToAvoidBottomPadding: false,
          body: Stack(
            fit: StackFit.passthrough,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Container(
                  //color: Colors.yellow[800],
                  height: 400.0,
                  width: 520.0,
                  child: Image.network(
                    "${widget.prodDetailImage}",
                    fit: BoxFit.cover,
                    height:380,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 320.0),
                child: Card(
                  elevation: 50.0,
                  shadowColor: Colors.black,
                  borderOnForeground: true,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(80.0), bottom: Radius.zero),
                    side: BorderSide.none,
                  ),
                  child: Container(
                      height: 700.0,
                      color: Colors.blue[100],
                      width: 520.0,
                     
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(18.0, 35.0, 8.0, 8.0),
                            child: ListTile(
                                title: Text(
                                  "${widget.prodDetailName}",
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    color: Colors.blue[900],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Row(
                                  children: <Widget>[
                                    Text('Price:',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w500)),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        widget.prodDetailPrice.toString(),
                                        style: TextStyle(fontSize: 20.0,
                                        color: Colors.grey
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          Divider(
                            thickness: 2.0,
                            color: Colors.amber,
                            height: 20.0,
                            indent: 8.0,
                            endIndent: 8.0,
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text('Details: ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w800,
                                            
                                            fontSize: 25.0))),
                              ),
                            ],
                          ),
                          // Divider(
                          //   thickness: 2.0,
                          //   color: Colors.amber,
                          // ),

                          Padding(
                            padding: const EdgeInsets.only(left:16.0, top: 10.0,),
                            child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Row(
                                  children: <Widget>[
                                    Text('Brand: ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w500)),

                                    Text('${widget.prodDetailBrand}',
                                        style: TextStyle(
                                           color: Colors.grey[700],
                                           fontSize: 20.0,
                                          )),        
                                  ],
                                )),
                          ),

                          Padding(
                           padding: const EdgeInsets.only(left:16.0, top: 10.0,),
                            child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Row(
                                  children: <Widget>[
                                    Text('Category: ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w500)),

                                    Text('${widget.prodDetailCategory}',
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: 20.0,
                                          )),        
                                  ],
                                ),
                              ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left:16.0, top: 10.0,),
                            child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Row(
                                  children: <Widget>[
                                    Text('Seller: ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w500)),

                                    Text('${widget.prodDetailSeller}',
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: 20.0
                                          )),        
                                  ],
                                ),
                              ),
                          ),

                          Padding(
                           padding: const EdgeInsets.only(left:16.0, top: 10.0,),
                            child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Row(
                                  children: <Widget>[
                                    Text("Seller's Contact : ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w500)),

                                    Text('${widget.prodDetailContact}',
                                        style: TextStyle(
                                           color: Colors.grey[700],
                                           fontSize: 20.0
                                          )),        
                                  ],
                                ),
                              ),
                          ),

                           Padding(
                           padding: const EdgeInsets.only(left:16.0, top: 10.0,),
                            child: Row(
                              children: <Widget>[
                                Wrap(
                                  children:<Widget>[ Text("Description : ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w500)),
                                  

                                Text('${widget.prodDetailDescription}',
                                softWrap: true,
                                style: TextStyle(
                                   color: Colors.grey[700],
                                   fontSize: 20.0,
                                   
                                  )),
                                ], ),        
                              ],
                            ),
                          ),
                          
                        ],
                      ),
                  ),


                ),
              ),
               Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 830.0, 10.0, 8.0),
                            child: Material(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.redAccent,
                                elevation: 20.0,
                                child: MaterialButton(
                                  onPressed: () {
                                    print ("=====${products.productsInCart.length}=====");
                                    products.productsInCart.add({
                                      "name" : widget.prodDetailName,
                                      "image": widget.prodDetailImage,
                                      "price": widget.prodDetailPrice,
                                      "seller": widget.prodDetailSeller,
                                    })  ;
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));
                                    //products.notifyListeners();                                    
                                  },                            
                                  minWidth: MediaQuery.of(context).size.width-20.0,
                                  child: Text(
                                    "Save to Order",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                ),
                              ),
                          ),


            ],
          )

          //alignment: Alignment.topCenter,

          ),
    );
  }
}

