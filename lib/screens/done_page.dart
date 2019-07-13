import 'package:flutter/material.dart';
import 'quiz_screen.dart';
import 'package:quizeroo/models/types.dart';
import 'home_page.dart';

class FinalPage extends StatelessWidget {
  final int correct;
  final int total;
  final int items;
  final QuizDifficulty difficulty;

  FinalPage(
      {this.correct: 0,
      this.total: 0,
      this.items: 10,
      this.difficulty: QuizDifficulty.EASY});

  @override
  Widget build(BuildContext context) {
    int score =
        (correct == 0 || total == 0) ? 0 : ((correct / total) * 100).round();

    return new Material(
      color: Colors.purple,
      child: new InkWell(
        onTap: () => Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new QuizPage(
                  items: items,
                  difficulty: difficulty,
                ))),
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Icon(Icons.check_circle_outline, color: Colors.white, size: 80.0,),
              new Text(
                "Your score:",
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  //fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0,),
              new Text(
                " $score% correct",
                style: new TextStyle(
                    color: Colors.orange,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15.0,),
              new Text(
                "Tap the screen to try again",
                style: new TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 60.0,),
              new FlatButton(
                shape: StadiumBorder(),
                color: Colors.white,
                child: new Text(
                  'BACK',
                  style: new TextStyle(
                    color: Colors.blue,
                    fontSize: 25.0,
                  ),
                ),
                padding: new EdgeInsets.only(
                    top: 40.0, right: 10.0, bottom: 20.0, left: 10.0),
                onPressed: () => Navigator.of(context).push(
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new HomePage())),
              )
            ]),
      ),
    );
  }
}
