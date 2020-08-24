import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:internApp/models/product_model.dart';
import 'package:internApp/pages/add_products.dart';

import 'package:internApp/usage_files/product_services.dart';
import 'package:internApp/usage_files/utility_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:internApp/usage_files/user_services.dart';

enum Page { dashboard, manage }

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  TextEditingController categoryController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  
  BrandService _brandService = BrandService();
  CategoryService _categoryService = CategoryService();
  UserServices _userServices = UserServices();
  List<DocumentSnapshot> brands = <DocumentSnapshot>[];
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  List<DocumentSnapshot> userData = <DocumentSnapshot>[];
  List<Product> prodData = <Product>[];

  @override
  void initState() {
    _getCategories();
    _getBrands();
    _getUserCount();
    _getProductCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: <Widget>[
            Text("dashBoard", style: TextStyle(color: Colors.red)),
          ],
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ), */
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            //color: Colors.amber,
            decoration: BoxDecoration(
                       
                        gradient: LinearGradient(
                       
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                       
                          colors: [                       
                            // Colors.amber[200],
                            // Colors.amber[200],
                            Colors.amber[300],
                            Colors.amber[400],
                            Colors.amber[400],
                            Colors.amber[400],
                            Colors.amber[600],
                            Colors.amber[700],
                          ],
                        ),
                      ),
         
            child: Stack(),
          ),
          Column(
            children: <Widget>[
      //=========================Total users========================       
              Padding(
                padding: const EdgeInsets.fromLTRB(60.0, 100.0, 60.0, 8.0),
                child: Card(
                  color: Colors.blue[200],
                  shadowColor: Colors.deepOrange,
                  elevation: 30.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Icon(
                        Icons.person_outline,
                        color: Colors.red,
                        size: 60.0,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(right: 80.0),
                      child: Text(
                        userData.length.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(
                      'Total Users',
                      //textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.blue[700],
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),


              Divider(
                thickness: 2.0,
                height: 20.0,
                color: Colors.amber,
              ),
    //=========================List Title row========================
              Padding(
                padding: const EdgeInsets.only(bottom:4.0), 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Card(
                      elevation: 10.0,
                      shadowColor: Colors.deepOrange,
                        child: Container(
                        height: 50.0,
                        width: 200.0,
                        color: Colors.blue[200],
                        alignment:Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                          child: ListTile(
                            leading: Icon(Icons.category) ,
                            title: Text("Category List"),
                            ),
                        ),
                        ),
                    ),

                    Card(
                      elevation: 10.0,
                      shadowColor: Colors.deepOrange,
                        child: Container(
                        height: 50.0,
                        width: 200.0,
                        color: Colors.blue[200],
                        alignment:Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                          child: ListTile(
                            leading: Icon(Icons.library_books) ,
                            title: Text("Brands List"),
                            ),
                        ),
                        ),
                    )

                  ],
                ),
              ),

              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
        //=========================category========================    
                  Container(
                    color: Colors.yellow[800],
                    height: 300.0,
                    width: 200.0,
                    child: Container(
                      child: Center(
                        child: ListView.builder(
                          addAutomaticKeepAlives: true,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                dense: true,
                                leading: Icon(Icons.brightness_1, color:Colors.red[300].withOpacity(1.0)),
                                title: Text(categories[index]["category"], 
                                textAlign: TextAlign.start,
                                style: TextStyle(fontSize: 18.0),
                                ),
                                
                              );
                            }),
                      ),
                    ),
                  ),
        //=========================Brands======================== 
                  Container(
                    color: Colors.yellow[800],
                    height: 300.0,
                    width: 200.0,
                    child: Center(

                      child: ListView.builder(
                        addAutomaticKeepAlives: true,
                        itemCount: brands.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            dense: true,
                                leading: Icon(Icons.brightness_1, color:Colors.red[300].withOpacity(1.0)),
                            title: Text(brands[index]["brand"],
                            textAlign: TextAlign.start,
                                style: TextStyle(fontSize: 18.0),
                                ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
        //===========================Total Products===================
              Padding(
                padding: const EdgeInsets.fromLTRB(60.0, 12.0, 60.0, 8.0),
                child: Card(
                  color: Colors.blue[200],
                  shadowColor: Colors.deepOrange,
                  elevation: 30.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  child: ListTile(
                    
                    subtitle: Text(prodData.length.toString(),
                       
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                    title: Text(
                      'Total Products',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.blue[700],
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),

              Divider(
                thickness: 2.0,
                height: 20.0,
                color: Colors.amber,
              ),
               


            //========================add products===========================  


            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text("Want to sell more products?...", style:TextStyle(fontSize: 30.0,
              fontWeight: FontWeight.bold,
              // color: Colors.red,
               ),
              ),
            ),

           Padding(
             padding: const EdgeInsets.all(0.0),
             child: Container(
               alignment: Alignment.center,
             height: 70.0,
             width: 230.0,
             //color: Colors.red,
             
             child: InkWell(
               //customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(150.0)),
               onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddProducts(),)),
              child: Row(
                children: [
                  Icon(Icons.add_circle_outline, size:  35.0,),
                  Text("Add Products",
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                    decorationThickness:3.0 ,
                    fontSize: 30.0
                  ),),
                ],
              )
              ),
             ),
           )
              
            //  FloatingActionButton(
            ],
          ),
        ],
      ),
    );
  }

//  
  _getCategories() async {
    List<DocumentSnapshot> data = await _categoryService.getCategories();
    // print(data.length);
    setState(() {
      categories = data;
      // print(categories.length);
    });
  }


  _getBrands() async {
    List<DocumentSnapshot> data = await _brandService.getBrands();
    setState(() {
      brands = data;
    });
  }

  _getUserCount() async {
    List<DocumentSnapshot> data = await _userServices.getUserList();
    setState(() {
      userData = data;
    });
  }

  _getProductCount()async{
    List<Product> data = await ProductService().getProducts();
    setState(() {
      prodData = data;
    });
  }
}
