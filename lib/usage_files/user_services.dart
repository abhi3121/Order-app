import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:internApp/models/user_model.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserServices {
  Firestore _firestore = Firestore.instance;
  String collection = "users";

  void createUser(Map<String, dynamic> data) =>
    _firestore.collection(collection).document(data["uid"]).setData(data);
  

  void updateDetails(Map<String, dynamic> data)=>
    _firestore.collection(collection).document(data["uid"]).updateData(data);
  

  Future<User> getUserById(String id)async{
       _firestore.collection(collection).document(id).get().then((snap){ 
      return User.fromSnapshot(snap);
    });
  }

  Future<List<User>> getUser(String id)async{
    List<User> userList = [];
    final QuerySnapshot result = await _firestore
          .collection(collection)
          .where("uid", isEqualTo: id)
          .getDocuments();
     print("===========hellodata ======${result.documents.length}");     
      for(DocumentSnapshot item in result.documents){
          userList.add(User.fromSnapshot(item));
          print(" usersssssssssssssssssssssssssss ${item.data}");
        }
  }

  Future<List<DocumentSnapshot>> getUserList() {
    return _firestore.collection(collection).getDocuments().then((snaps) {
      
      print("=======UserLenght=========${snaps.documents.length}");
      return snaps.documents;
      
    });
  }
}

