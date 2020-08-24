import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class BrandService {
  Firestore _firestore = Firestore.instance;
  String ref = "brands";

  void createBrand(String name) {
    var id = Uuid();
    String brandId = id.v1();

    _firestore.collection(ref).document(brandId).setData({'brand': name});
  }

  Future<List<DocumentSnapshot>> getBrands() {
    return _firestore.collection(ref).getDocuments().then((snaps) {
      return snaps.documents;
    });
  }
}

class CategoryService {
  Firestore _firestore = Firestore.instance;
  String ref = "categories";

  void createCategory(String name) {
    var id = Uuid();
    String categoryId = id.v1();

    _firestore.collection(ref).document(categoryId).setData({'category': name});
  }

  Future<List<DocumentSnapshot>> getCategories() {
    return _firestore.collection(ref).getDocuments().then((snaps) {
      //print(snaps.documents.length);
      return snaps.documents;
    });
  }
}
