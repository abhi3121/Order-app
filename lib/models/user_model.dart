
import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  static const String UNAME  =   'name';
  static const String EMAIL  =   'email';
  static const String ID     =   'id';
  static const String IMAGE  =   'image';
  static const String TYPE   =   'type';

  String _name;
  String _email;
  String _id;
  String _image;
  String _type;

//  GETTERS
  String get name => _name;
  String get email => _email;
  String get id => _id;
  String get image => _image;
  String get type => _type;

  User.fromSnapshot(DocumentSnapshot snap){
    _email = snap.data[EMAIL];
    _name = snap.data[UNAME];
    _id = snap.data[ID];
    _image= snap.data[IMAGE];
    _type = snap.data[TYPE];
  }
}