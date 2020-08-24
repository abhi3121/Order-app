import 'package:cloud_firestore/cloud_firestore.dart';
class Product{
  static const String BRAND = "brand";
  static const String NAME = "name";
  static const String ID = "id";
  static const String CATEGORY = "category";
  static const String IMAGE = "image";
  static const String PRICE = "price";
  static const String DESCRIPTION = "description";
  static const String SELLER = "seller";
  static const String CONTACT = "contact";

  String _brand;
  String _category;
  String _id;
  String _name;
  String _image;
  double _price;
  String _description;
  String _seller;
  String _contact;

  String get brand       => _brand      ;
  String get category    => _category   ;
  String get id          => _id         ;
  String get name        => _name       ;
  String get image       => _image      ;
  double get price       => _price      ;
  String get description => _description;
  String get seller      => _seller     ;
  String get contact     => _contact    ;

//================constructor=============================
  Product.fromSnapShot(DocumentSnapshot snapshot){
    _brand   = snapshot.data[BRAND]; 
    _category = snapshot.data[CATEGORY];  
    _id       = snapshot.data[ID];  
    _name  = snapshot.data[NAME];     
    _image  = snapshot.data[IMAGE];    
    _price   = snapshot.data[PRICE];   
    _description = snapshot.data[DESCRIPTION];
    _seller    = snapshot.data[SELLER]; 
    _contact   = snapshot.data[CONTACT];

  }    
}

