import 'package:flutter/material.dart';
import 'package:internApp/models/user_model.dart';
import 'package:internApp/pages/admin.dart';
import 'package:internApp/pages/home_page.dart';
import 'package:internApp/usage_files/user_services.dart';
import 'package:provider/provider.dart';
import 'package:internApp/pages/signup_page.dart';
import 'package:internApp/usage_files/user_provider.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:internApp/usage_files/common.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
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
              alignment: Alignment.center,
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
                                90000.0, // has the effect of softening the shadow
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 72.0),
                        child: Form(
                          key: _formkey,
                          child: ListView(
                            //
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    16.0, 20.0, 16.0, 8.0),
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
                                      autocorrect: true,
                                      autofocus: true,
                                      controller: _email,
                                      decoration: const InputDecoration(
                                        focusColor: Colors.indigoAccent,
                                        border: InputBorder.none,
                                        icon: Icon(Icons.email),
                                        hintText: 'Enter your email',
                                        //border: InputBorder.none
                                      ),
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
                                        }
                                        return null;
                                      },
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(Icons.remove_red_eye),
                                      onPressed: () {
                                        setState(
                                          () {
                                            hidePass = !hidePass;
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.all(16.0),
                                child: RaisedButton(
                                  autofocus: true,
                                  elevation: 50.0,
                                  
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    side: BorderSide(
                                      color: Colors.orange[600],
                                    ),
                                  ),
                                  color: Colors.orange,
                                  onPressed: () async {
                                    if (_formkey.currentState.validate()) {
                                      List<User> result = await user.signin(_email.text.trim(), _password.text.trim());
                                      //Map<String, dynamic > userdata = 
                                      if (result==null) {
                                        print("=========user null aya h");
                                        _key.currentState.showSnackBar(
                                          SnackBar(
                                            content: Text('Sign in failed'),
                                          ),
                                        );
                                        return;
                                      }

                                      else {
                                       if(result[0].type == type1){
                                        print("=========user admin aya h");
                                       Navigator.pushReplacement(
                                         context,
                                         MaterialPageRoute(
                                             builder: (context) =>
                                                 Admin()));
                                                 return;
                                      }

                                      else if(result[0].type == type2){
                                        print("=========user consumer aya h");
                                       Navigator.pushReplacement(
                                         context,
                                         MaterialPageRoute(
                                             builder: (context) =>
                                                 HomePage()));
                                                 return;
                                      }
                                      }
                                      //_formkey.currentState.reset();            
                                      return;            
                                    }
                                  },
                                  child: Text(
                                    "Login",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 20.0),
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                            onTap: () {},
                                            child: Text(
                                              "Forgot Password?",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.blueGrey[700],
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Signup()));
                                            },
                                            child: Text(
                                              "Create an account",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.blue[600],
                                                  decoration: TextDecoration.underline,
                                                  decorationThickness: 2.0,
                                                  decorationColor: Colors.blue[700],
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                   Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        "Or",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.blueGrey[700],
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Center(
                                      child: GoogleSignInButton(
                                        text: "Sign in with Google as Seller",
                                        borderRadius: 18.0,
                                        onPressed: () async {
                                          if (!await user.googleSignIn(type1)) {
                                            _key.currentState.showSnackBar(
                                                SnackBar(
                                                    content: Text(
                                                        'Sign up failed')));
                                            return;
                                          }
                                          Fluttertoast.showToast(
                                              msg: "Sign in successful");
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Admin()),
                                          );
                                        },
                                        darkMode: true,
                                      ),
                                    ),

                                    Center(
                                      child: GoogleSignInButton(
                                        text: "Sign in with Google as Consumer",
                                        borderRadius: 18.0,
                                        onPressed: () async {
                                          if (!await user.googleSignIn(type2)) {
                                            _key.currentState.showSnackBar(
                                                SnackBar(
                                                    content: Text(
                                                        'Sign up failed')));
                                            return;
                                          }
                                          Fluttertoast.showToast(
                                              msg: "Sign in successful");
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomePage()),
                                          );
                                        },
                                        darkMode: true,
                                      ),
                                    ),
                                  ],
                                ),

                                ],
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
