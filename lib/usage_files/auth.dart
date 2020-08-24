/*import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'user.dart';

abstract class BaseAuth {
  Future<FirebaseUser> googleSignIn();
  //Future<FirebaseUser> googleSignUp();
}


class Auth implements BaseAuth {
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseUser _user;
  Status _status = Status.Uninitialized;
  Status get status => _status;
  FirebaseUser get user => _user;
  
  

  
  UserServices _userServices = UserServices();
  
  @override
  Future<FirebaseUser> googleSignIn() async {
    //final GoogleSignIn _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleAuth.idToken, 
      accessToken: googleAuth.accessToken,
    );
    
    try{
      _status = Status.Authenticating;
      _user = (await _auth.signInWithCredential(credential)) as FirebaseUser;
      
      final FirebaseUser currentUser = await _auth.currentUser();
      if(!user.isAnonymous && await user.getIdToken() != null && user.uid == currentUser.uid){
      Map <String, dynamic> data ={
        "name" : _user.displayName,
        "email": _user.email,
        "uid" : user.uid
      };
      _userServices.createUser(data);
      }
      return _user;
    }
    catch(e){
      _status = Status.Unauthenticated;
      print(e.toString());
      return null;
    }
  }
 
  Future googleSignOut() async{
    if(await _googleSignIn.isSignedIn()) {
      _googleSignIn.signOut();
      
    }
  }
} 
*/
