import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:internApp/models/user_model.dart';
import 'package:internApp/usage_files/user_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class UserProvider with ChangeNotifier {
  FirebaseAuth _auth;
  FirebaseUser _user;
  User _userModel;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  SharedPreferences prefs;

  Status _status = Status.Uninitialized;
  Status get status => _status;
  User get userModel => _userModel;
  FirebaseUser get user => _user;
  Firestore _firestore = Firestore.instance;
  UserServices _userServices = UserServices();
  //bool isAdmin = false;
  List<User> userdata = <User>[];

  UserProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onStateChanged);
  }

//=====================sign in===========================
  Future<List <User>> signin(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();

      _user = (await _auth.signInWithEmailAndPassword(email: email, password: password)).user;

     // FirebaseUser user = await _auth.currentUser();

      return userdata;
    } 
    catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return null;
    }
  }

//=====================sign up===========================
  Future<bool> signup(String name, String email, String password, String type) async {
    
    prefs = await SharedPreferences.getInstance();    
    try {
      _status = Status.Authenticating;
      notifyListeners();
      _user = (await _auth.createUserWithEmailAndPassword(email: email, password: password)).user;

      FirebaseUser user = await _auth.currentUser();
     
      Map<String, dynamic> values = {
        "name": name,
        "email": email,
        "uid": user.uid,
        "image": null,
        "type": type
      };
      _userServices.createUser(values);

      //FirebaseUser _currentUser =  await _auth.currentUser() ;

        await prefs.setString("id", user.uid);
        await prefs.setString("name", name);
        await prefs.setString("email", email);
        await prefs.setString("image", null);
        await prefs.setString("type", type);


      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  //=====================sign out===========================

  Future signOut() async {
    if (await _googleSignIn.isSignedIn()) {
      _googleSignIn.signOut();
      _auth.signOut();
      _status = Status.Unauthenticated;
      notifyListeners();
      return Future.delayed(Duration.zero);
    }
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

//===================== google sign in ===========================
  Future<bool> googleSignIn(String type) async {
    final GoogleSignInAccount googleAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    FirebaseUser currentUser; 
    prefs = await SharedPreferences.getInstance();

    try {
      _status = Status.Authenticating;
      notifyListeners();
      _user = (await _auth.signInWithCredential(credential)).user;

      print("signed in " + _user.displayName);

      //Check if user is already signed up
      final QuerySnapshot result = await _firestore
          .collection("users")
          .where("id", isEqualTo: _user.uid)
          .getDocuments();

      final List<DocumentSnapshot> documents = result.documents;
      //_userModel = _getUser(_user);
      
      if (documents.length== 0) {
        // this means new user -> Update data to server
        Map<String, dynamic> values = {
          "uid": _user.uid,
          "name": _user.displayName,
          "email": _user.email,
          "image": _user.photoUrl,
          "type": type
        };
        _userServices.createUser(values);

        // Write data to local storage
        currentUser = await _auth.currentUser();

        await prefs.setString("id", currentUser.uid);
        await prefs.setString("name", currentUser.displayName);
        await prefs.setString("email", currentUser.email);
        await prefs.setString("image", currentUser.photoUrl);
        await prefs.setString("type", type);
        _userModel = await _userServices.getUserById(currentUser.uid);
        userdata = await _userServices.getUser(user.uid);
        notifyListeners();
      } 
      else {
        // Write data to local storage
        await prefs.setString("id", documents[0]['id']);
        await prefs.setString("name", documents[0]['name']);
        await prefs.setString("email", documents[0]['email']);
        await prefs.setString("image", documents[0]['photoUrl']);
        await prefs.setString("type", type);
      }
     
      return true;
    } 
    catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }
  
 

  Future<void> _onStateChanged(FirebaseUser user) async {
    if (user == null) {
      print ("\n\n===================userstream null aya hai===================\n\n");
      _status = Status.Uninitialized;
    } else {
      print ("\n\n===================userstream me ${user.uid} aya hai===================\n\n");
      _user = user;
      _status = Status.Authenticated;

      _userModel = await _userServices.getUserById(_user.uid);
      userdata = await _userServices.getUser(user.uid);
      print(userdata[0]);

      //notifyListeners();
     // print("\n\n"+ _userModel.name);      
    }
      
    notifyListeners();
  }
}
