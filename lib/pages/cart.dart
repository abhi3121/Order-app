import 'package:flutter/material.dart';
import 'package:internApp/usage_files/cart_products.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        appBar:AppBar(
          elevation: 0.5,
          automaticallyImplyLeading: true,
          title: Text('  Cart'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      
        body:Container(
          color: Colors.black,
          height:MediaQuery.of(context).size.height,
          child: CartProducts(),

        ),
        /* bottomNavigationBar: Container(
          //color: Colors.yellow,
          child : Center(
            child: RaisedButton(
              child: Text("delete all items"),
              onPressed:(){} ,
            ),
          )
        ), */
        
      ),
    );
  }
}