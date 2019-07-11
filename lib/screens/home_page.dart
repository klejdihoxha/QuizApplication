import 'package:flutter/material.dart';
import 'quiz_screen.dart';
import 'package:quizeroo/models/types.dart';
import 'package:carousel_pro/carousel_pro.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  QuizDifficulty difficulty;
  String type;
  double items;
  String name;

  @override
  void initState() {
    super.initState();
    difficulty = QuizDifficulty.EASY;
    items = 5.0;
  }

  @override
  Widget build(BuildContext context) {
    _getDropdownItems() {
      QuizDifficulty.EASY;
      List<List> items = [
        ['Easy', QuizDifficulty.EASY],
        ['Medium', QuizDifficulty.MEDIUM],
        ['Hard', QuizDifficulty.HARD]
      ];
      List<DropdownMenuItem> dropdownItems = [];
      for (List item in items) {
        dropdownItems.add(new DropdownMenuItem(
            child: new Text(
              item[0],
              style: new TextStyle(
                color: Colors.white,
                fontSize: 25.0,
              ),
            ),
            value: item[1]));
      }
      return dropdownItems;
    }

    return new Theme(
      data: new ThemeData(
        primaryColor: Colors.blueAccent,
        canvasColor: Colors.purple,
        accentColor: Colors.white,
        accentIconTheme: new IconThemeData(color: Colors.white),
        buttonColor: Colors.white,
      ),
      child: new Material(
        child: new InkWell(
          child: new Column(
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
                          'https://spacepsm.org/wp-content/uploads/2018/05/%E9%A6%96%E9%A1%B5%E9%85%8D%E5%9B%BE-01-1-800x480.png'),
                    ],
                    showIndicator: false,
                    borderRadius: false,
                    moveIndicatorFromBottom: 180.0,
                    noRadiusForIndicator: true,
                    overlayShadow: true,
                    overlayShadowColors: Colors.white,
                    overlayShadowSize: 0.7,
                  )),
              SizedBox(height: 20.0,),
              new Container(
                child: new Icon(Icons.question_answer, size: 80.0, color: Colors.white,),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
                child: TextFormField(
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontFamily: 'Product-Sans', color: Colors.white),
                    labelStyle: TextStyle(fontFamily: 'Product-Sans', color: Colors.white),
                    hintText: "Enter your name",
                    labelText: "Name",
                  ),
                  cursorColor: Colors.white,
                  validator: (value) =>
                  value.isEmpty ? 'Name can\'t be empty.' : null,
                  onSaved: (value) => name = value,
                ),
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Container(
                      width: 200.0,
                      padding: new EdgeInsets.only(
                          top: 20.0, right: 10.0, bottom: 20.0, left: 10.0),
                      child: new Slider(
                          value: items,
                          max: 10.0,
                          min: 1.0,
                          onChanged: (value) {
                            setState(() {
                              items = value.roundToDouble();
                            });
                          })),
                  new DropdownButton(
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                    iconSize: 30.0,
                    items: _getDropdownItems(),
                    value: difficulty,
                    onChanged: (value) {
                      setState(() {
                        difficulty = value;
                      });
                    },
                  ),
                ],
              ),
              new Container(
                child: new Text(
                  "Questions:\ " + items.toInt().toString(),
                  style: new TextStyle(color: Colors.white, fontSize: 15.0),
                ),
                padding: new EdgeInsets.only(
                    top: 20.0, right: 10.0, bottom: 20.0, left: 10.0),
              ),
              SizedBox(height: 20.0),
              new FlatButton(
                shape: StadiumBorder(),
                color: Colors.white,
                child: new Text(
                  'GO',
                  style: new TextStyle(
                    color: Colors.blue,
                    fontSize: 25.0,
                  ),
                ),
                padding: new EdgeInsets.only(
                    top: 40.0, right: 10.0, bottom: 20.0, left: 10.0),
                onPressed: () =>
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new QuizPage(
                              items: items.toInt(),
                              difficulty: difficulty,
                            ))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
