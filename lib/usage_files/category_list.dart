import 'dart:ui';
import 'package:flutter/material.dart';

class Horizontallist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      color: Colors.white60,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          reverse: false,
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Category(
                location: "images/cat_food.png",
                caption: "FOOD",
            ),
            Category(
                location: "images/cat_dress_f.jpeg",
                caption: "DRESS",
            ),
            Category(
                location: "images/cat_dress_m.png",
                caption: "MALE DRESS",
            ),
            Category(
                location: "images/cat_food.png",
                caption: "FOOD",
            ),
            Category(
                location: "images/cat_dress_f.jpeg",
                caption: "DRESS",
            ),
            Category(
                location: "images/cat_dress_m.png",
                caption: "MALE DRESS",
            ),
          ],
        ),
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String location;
  final String caption;
  Category({this.location, this.caption});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: Container(
        //color: Colors.cyanAccent,
        height: 100,
        width: 130,
        child: ListTile(
          onTap: () {},
            //Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails()));},
          title: Image.asset(
              location,
              width: 160.0,
              height: 100.0,
            ),
          
          subtitle: Container(
            //color: Colors.amber,
            //alignment: Alignment.topCenter,
            child: Text(caption, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600),)
          ),
        ),
      ),
    );
  }
}
