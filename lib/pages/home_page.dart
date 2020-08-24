

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:internApp/pages/cart.dart';
import 'package:internApp/usage_files/products.dart';
import 'package:internApp/usage_files/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:carousel_pro/carousel_pro.dart';

class HomePage extends StatelessWidget {   
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    
    return SafeArea(
      top: true,
          child: Scaffold(
            backgroundColor: Colors.blue[100],
        appBar: AppBar(
          elevation: 0.2,
          automaticallyImplyLeading: true,
          title: Text('MyApp'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Cart(),));
              },
            ),
          ],
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            RotatedBox(
              quarterTurns: 0, // give INTEGER value for clockwise rotation
              child: SizedBox(
                height: 300.0,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  color: Colors.white,
                  child: Carousel(
                    images: [
                      Image.asset("images/food.jpeg", fit: BoxFit.cover),
                      Image.asset("images/cloth.jpeg", fit: BoxFit.cover),
                      Image.asset("images/food2.jpeg", fit: BoxFit.cover),
                      Image.asset("images/lady.jpeg",  fit: BoxFit.fitHeight,),
                      Image.asset("images/reddress.jpeg",  fit: BoxFit.cover,),
                      Image.asset("images/pizza.jpeg", fit: BoxFit.cover),
                      Image.asset("images/spices.jpeg", fit: BoxFit.cover),
                      Image.asset("images/shirt.jpeg", fit: BoxFit.contain),
                      //Image.asset("images/.jpeg", fit: BoxFit.fitHeight),
                    ],
                    animationCurve: Curves.fastOutSlowIn,
                    dotColor: Colors.white,
                    dotIncreaseSize: 2.0,
                    dotSize: 5.0,
                    dotBgColor: Colors.transparent,
                    autoplay: true,
                  ),
                ),
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.only(left: 15.0, top: 4.0),
            //   child: Row(
            //     children: <Widget>[
            //       Icon(
            //         Icons.category,
            //         color: Colors.indigo[00],
            //       ),
            //       Text("   Categories",
            //           textAlign: TextAlign.justify,
            //           style: TextStyle(
            //               fontSize: 20.0,
            //               color: Colors.indigo[900],
            //               fontWeight: FontWeight.w600)),
            //     ],
            //   ),
            // ),
          
        //category list display here
          //  Horizontallist(),
            Divider(
              height: 20.0,
              thickness: 2.0,
            ),


            Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, top: 16.0, bottom: 15.0, right: 8.0),
              child: Container(
                //color: Colors.red[100],
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.dashboard,
                      color: Colors.indigo[900],
                    ),
                    Text(
                      "   Products",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.indigo[900],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 235.0),
                      child: Container(
                          alignment: Alignment.center,
                          //color: Colors.cyan,
                          height: 20.0,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Products(true)));
                            },
                            
                            child: Text("View all",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18.0,
                                    decoration: TextDecoration.underline)),
                          )),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              color: Colors.grey[700],
              height: 460.0,
              child: Products(false),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountEmail: Text("    "),
                accountName: Text("    "),
                currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                    radius: 20.0,
                    backgroundColor: Colors.white70,
                     child:
                      Icon(
                      Icons.person,
                      color: Colors.blue[300],
                      size: 70.0,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.orange[500],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ));
                },
                autofocus: true,
                child: ListTile(
                    title: Text("Homepage"),
                    leading: Icon(Icons.home, color: Colors.blue[200])),
              ),

              InkWell(
                onTap: () {
                  Fluttertoast.showToast(msg: "coming soon");
                },
                autofocus: true,
                child: ListTile(
                    title: Text("My account"),
                    leading: Icon(Icons.person, color: Colors.green)),
              ),

              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Cart(),
                  ));
                },
                autofocus: true,
                child: ListTile(
                    title: Text("My saved list"),
                    leading: Icon(Icons.shopping_cart, color: Colors.red[300])),
              ),

              InkWell(
                onTap: () {
                  Fluttertoast.showToast(msg: "coming soon");
                },
                autofocus: true,
                child: ListTile(
                    title: Text("Favourites"),
                    leading: Icon(Icons.favorite, color: Colors.red)),
              ),
              Divider(
                color: Colors.grey,
                height: 10.0,
                thickness: 0.0,
              ),
              InkWell(
                onTap: () {
                  Fluttertoast.showToast(msg: "coming soon");
                },
                autofocus: true,
                child: ListTile(
                    title: Text("Settings"),
                    leading: Icon(Icons.settings, color: Colors.grey[500])),
              ),
              InkWell(
                onTap: () {
                  showAboutDialog(
                    context: context,
                    applicationIcon: FlutterLogo() ,
                    applicationName: "OrderApp",
                    applicationVersion: "1.0",
                    applicationLegalese: "This application can be used by anyone.",
                    children: [
                       Padding(
                         padding: const EdgeInsets.only(top:16.0),
                         child: Text("Platform to sell products by small businesses."),
                       ),
                    ],
                  );
                  
                },
                autofocus: true,
                child: ListTile(title: Text("About"), leading: Icon(Icons.help)),
              ),
              Divider(
                color: Colors.grey,
                height: 10.0,
                thickness: 0.0,
              ),
              RaisedButton(
                onPressed: () async {
                  await user.signOut().whenComplete(() {                    
                    //Navigator.pop(context);
                    Fluttertoast.showToast(msg: "Signed out successfully");
                  });
                },
                autofocus: true,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                child: Text("Signout"),
              ),
              Divider(
                indent: 80.0,
                endIndent: 90.0,
                thickness: 5.0,
                height: 90.0,
                color: Colors.blue[50],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
