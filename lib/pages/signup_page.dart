import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:internApp/usage_files/user_services.dart';
import 'package:provider/provider.dart';
import 'package:internApp/pages/login_page.dart';
import 'package:internApp/usage_files/user_provider.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:internApp/usage_files/common.dart';

class Signup extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<Signup> {
  final _formkey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _name = TextEditingController();
  bool hidePass = true;
  final String type1 = "Seller";
  final String type2 = "Cunsumer";

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    return Scaffold(
      key: _key,
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.indigo[300],
      body: user.status == Status.Authenticating
          ? Loading()
          : Stack(
              children: <Widget>[
                Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.fromLTRB(30.0, 150.0, 30.0, 150.0),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.indigo[100],
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.indigo[900],
                            blurRadius:
                                500.0, // has the effect of softening the shadow
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 72.0),
                        child: Form(
                          key: _formkey,
                          child: ListView(
     //==============================username======================================
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      16.0, 20.0, 16.0, 8.0),
                                  child: Container(
                                    //crossAxisAlignment: CrossAxisAlignment.center,
                                    //padding: EdgeInsets.only(left:8.0, right:8.0),
                                    alignment: Alignment.center,
                                    height: 55,
                                    //color: Colors.amber,
                                    decoration: BoxDecoration(
                                      color: Colors.blue[50],
                                      borderRadius: BorderRadius.circular(
                                          70), //(Radius.circular(70)),
                                      border: Border.all(
                                          color: Colors.blue, width: 2),
                                    ),
                                    child: ListTile(
                                      title: TextFormField(
                                        textAlign: TextAlign.justify,
                                        autocorrect: true,
                                       // keyboardType: TextInputType.name,
                                        autofocus: true,
                                        controller: _name,
                                        decoration: const InputDecoration(
                                          //labelText: "Username",
                                          focusColor: Colors.indigoAccent,
                                        
                                          border: InputBorder.none,
                                          icon: Icon(Icons.email),
                                          hintText: 'Enter username',
                                          //border: InputBorder.none
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Username cannot be empty!';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
    //===============================      email       ======================================
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, right: 16.0),
                                  child: Container(
                                    //crossAxisAlignment: CrossAxisAlignment.center,
                                    //padding: EdgeInsets.only(left:8.0, right:8.0),
                                    alignment: Alignment.center,
                                    height: 55,
                                    //color: Colors.blue,
                                    decoration: BoxDecoration(
                                      color: Colors.blue[50],
                                      borderRadius: BorderRadius.circular(
                                          70), //(Radius.circular(70)),
                                      border: Border.all(
                                          color: Colors.blue, width: 2),
                                    ),
                                    child: ListTile(
                                      title: TextFormField(
                                        controller: _email,
                                        keyboardType: TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          focusColor: Colors.indigoAccent,
                                          border: InputBorder.none,
                                          icon: Icon(Icons.lock),
                                          hintText: 'Enter your email',
                                        ),
                                        //
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Enter email addresss';
                                          } else {
                                            Pattern pattern =
                                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                            RegExp regex = new RegExp(pattern);
                                            if (!regex.hasMatch(value))
                                              return 'Enter a valid email addresss';
                                            else
                                              return null;
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
      // =========================password===================================                         
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, right: 16.0, top: 8.0),
                                  child: Container(
                                    //padding: EdgeInsets.only(left:8.0, right:8.0),
                                    height: 55,
                                    alignment: Alignment.center,
                                    //color: Colors.blue,
                                    decoration: BoxDecoration(
                                      color: Colors.blue[50],
                                      borderRadius: BorderRadius.circular(
                                          70), //(Radius.circular(70)),
                                      border: Border.all(
                                          color: Colors.blue, width: 2),
                                    ),
                                    child: ListTile(
                                      title: TextFormField(
                                        keyboardType: TextInputType.visiblePassword,
                                        autocorrect: true,
                                        autofocus: true,
                                        controller: _password,
                                        obscureText: hidePass,
                                        decoration: InputDecoration(
                                          focusColor: Colors.indigoAccent,
                                          border: InputBorder.none,
                                          icon: Icon(Icons.lock),
                                          hintText: 'Enter password',
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Password cannot be empty!';
                                          } else if (value.length < 6) {
                                            return 'password too short!';
                                          }
                                          return null;
                                        },
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(Icons.remove_red_eye),
                                        onPressed: () {
                                          setState(() {
                                            hidePass = !hidePass;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                
                                
                                Padding(
                                  padding: const EdgeInsets.only(top:40.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Center(
                                        child: RaisedButton(
                                          autofocus: true,
                                          elevation: 50.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            side: BorderSide(
                                              color: Colors.orange[600],
                                            ),
                                          ),
                                          color: Colors.orange,
                                          onPressed: () async {
                                            if (_formkey.currentState.validate()) {
                                              if (!await user.signup(_name.text.trim(), _email.text.trim(), _password.text.trim(), type1)) {
                                                
                                                _key.currentState.showSnackBar(
                                                    SnackBar(
                                                        content: Text('Sign up failed')));
                                                return;
                                              }
                                              Fluttertoast.showToast(
                                                  msg: "Sign up successful");
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Login()));
                                              //_formkey.currentState.reset();            
                                            }
                                          },
                                          child: Text(
                                            'Sign Up as Seller',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0),
                                          ),
                                        ),
                                      ),
//==========================================button 2=======================================
                                    Center(
                                      child: RaisedButton(
                                        autofocus: true,
                                        elevation: 50.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          side: BorderSide(
                                            color: Colors.orange[600],
                                          ),
                                        ),
                                        color: Colors.orange,
                                        onPressed: () async {
                                          if (_formkey.currentState.validate()) {
                                            if (!await user.signup(_name.text.trim(),
                                                _email.text.trim(), _password.text.trim(), type2)) {
                                              _key.currentState.showSnackBar(
                                                  SnackBar(
                                                      content: Text(
                                                          'Sign up failed')));
                                              return;
                                            }
                                            Fluttertoast.showToast(
                                                msg: "Sign up successful");
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Login()));
                                           // _formkey.currentState.reset();            
                                          }
                                        },
                                        child: Text(
                                          'Sign Up as Consumer',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0),
                                        ),
                                      ),
                                    ),
                                    ],
                                  ),
                                ),
                                                             ],
                            ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
