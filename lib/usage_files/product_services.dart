import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:internApp/models/product_model.dart';
import 'package:uuid/uuid.dart';

class ProductService {
  Firestore _firestore = Firestore.instance;
  String ref = "products";

  void uploadProducts({String productName, String category,String brand, String image, 
                       String seller,String contact, double price, String description}) {
    var id = Uuid();
    String productId = id.v1();
    _firestore.collection(ref).document(productId).setData({
      "name": productName,
      "image": image,
      "id": productId,
      "category": category,
      "price": price,
      "description": description,
      "seller": seller,
      "contact": contact
    });
  }
  
  Future<List<Product>> getProducts()async =>
    _firestore.collection(ref).getDocuments().then((result){
    List<Product> prodList = [];

    print("====== RESULT SIZE ${result.documents.length}");

    for(DocumentSnapshot item in result.documents){
      prodList.add(Product.fromSnapShot(item));
      print(" PRODUCTSSSS ${prodList.length}");  
    }
    
   //snap.documents.map((snapshot) => prodList.add(Product.fromSnapShot(snapshot)));
    return prodList; 
  });
}
