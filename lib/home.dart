import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'dart:math';

final FirebaseDatabase database = FirebaseDatabase.instance;

class Home extends StatefulWidget {
  @override
  _Home createState() => new _Home();
}

class _Home extends State<Home> {
  final formKey = new GlobalKey<FormState>();

  String name;
  var random = new Random(100);

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void handleSubmit() {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      form.reset();
      database
          .reference()
          .child('Users')
          .child(name).set(name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: new Form(
        key: formKey,
        child: Center(
          child: homeBody(),
        ),
      ),
    );
  }

  homeHeader() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              elevation: 2.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new SizedBox(
                      height: 130.0,
                      width: 320.0,
                      child: new Carousel(
                        images: [
                          new NetworkImage(
                              'https://www.cambridgesciencepark.co.uk/assets/thumbnail/1045/740/450/source/center/90/,%20/assets/thumbnail/1045/1480/900/source/center/90/%202x'),
                          new NetworkImage(
                              'https://justfreewpthemes.com/wp-content/uploads/2019/06/WordPress-Quiz-plugin.jpg'),
                          new NetworkImage(
                              'https://www.yourfertility.org.au/sites/default/files/2018-09/Quiz%20icon.jpg'),
                        ],
                        showIndicator: false,
                        borderRadius: false,
                        moveIndicatorFromBottom: 180.0,
                        noRadiusForIndicator: true,
                        overlayShadow: true,
                        overlayShadowColors: Colors.white,
                        overlayShadowSize: 0.7,
                      )),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            "Welcome",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.blue,
                fontFamily: 'Product-Sans'),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            "Please enter your name",
            style: TextStyle(color: Colors.grey, fontFamily: 'Product-Sans'),
          ),
        ],
      );

  homeBody() => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            homeHeader(),
            homeField(),
          ],
        ),
      );

  homeField() => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
              child: TextFormField(
                maxLines: 1,
                decoration: InputDecoration(
                  hintStyle: TextStyle(fontFamily: 'Product-Sans'),
                  labelStyle: TextStyle(fontFamily: 'Product-Sans'),
                  hintText: "Enter your name",
                  labelText: "Name",
                ),
                validator: (value) =>
                    value.isEmpty ? 'Name can\'t be empty.' : null,
                onSaved: (value) => name = value,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
              width: double.infinity,
              child: FlatButton(
                padding: EdgeInsets.all(12.0),
                shape: StadiumBorder(),
                child: Text(
                  "GO",
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Product-Sans'),
                ),
                color: Colors.blue,
                onPressed: () {
                  handleSubmit();
                  //Navigator.pushNamed(context, '/CreditCard');
                },
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
          ],
        ),
      );
}
