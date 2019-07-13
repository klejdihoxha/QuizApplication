import 'package:flutter/material.dart';
import 'dart:async';
import 'done_page.dart';
import 'package:quizeroo/models/get_data.dart';
import 'package:quizeroo/models/overlay.dart';
import 'package:quizeroo/models/types.dart';
import 'package:carousel_pro/carousel_pro.dart';

class QuizPage extends StatefulWidget {

  final int items;
  final QuizDifficulty difficulty;

  const QuizPage(
      {Key key, this.items: 10, this.difficulty: QuizDifficulty.EASY})
      : super(key: key);

  _QuizPageState createState() => new _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _questionIndex;
  Future _data;
  List _quizItems;
  int _totalItems;
  QuizDifficulty _difficulty;
  bool _lastQuestion;
  bool _feedback;
  int _guessIndex;
  bool _result;
  int _total;
  int _correct;
  bool _loading;

  @override
  void initState() {
    super.initState();

    _totalItems = widget.items;
    _difficulty = widget.difficulty;
    _questionIndex = 0;
    _quizItems = [];
    _feedback = true;
    _loading = true;
    _result = false;
    _total = 0;
    _correct = 0;
    _data = new Data(
            items: widget.items, difficulty: widget.difficulty)
        .getQuestions();

    _data
        .then((value) => handleValue(value))
        .catchError((error) => print('error'));

    _lastQuestion = true;
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return new Material(
          child: new Container(
        color: Colors.purple,
        child: new Center(
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              new Text(
                'Wait...',
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                ),
                textAlign: TextAlign.center,
              ),
                  SizedBox(height: 20.0),
                  CircularProgressIndicator(),
            ])),
      ));
    }
    if (_feedback) {
      return new Container(
          color: Colors.white,
          child: new AnswerOverlay(
            _result,
            () {
              setState(() {
                _feedback = false;
                _questionIndex++;
                _guessIndex = null;
              });
            },
            _correct,
            _total,
          ));
    }
    return new Scaffold(
      backgroundColor: Colors.purple,
      body: new Center(
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
            new Container(
              padding: new EdgeInsets.only(
                  top: 20.0, right: 10.0, bottom: 20.0, left: 10.0),
              child: new Text(
                _quizItems[_questionIndex].question,
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            new Container(
              child: new ListView.builder(
                  padding: new EdgeInsets.all(8.0),
                  shrinkWrap: true,
                  itemBuilder: (_, int index) => new RadioListTile(
                        title: new Text(
                          _quizItems[_questionIndex].answers[index].label,
                          style: new TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                          ),
                        ),
                        value: index,
                        activeColor: Colors.white,
                        groupValue: _guessIndex,
                        onChanged: (index) {
                          if (_lastQuestion)
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new FinalPage(
                                      correct: _correct,
                                      total: _total,
                                      items: widget.items,
                                      difficulty: widget.difficulty,
                                    )));

                          setState(() {
                            _guessIndex = index;
                            _lastQuestion =
                                (_questionIndex + 2 >= _quizItems.length)
                                    ? true
                                    : false;
                            _feedback = true;
                            _result = _quizItems[_questionIndex]
                                .answers[index]
                                .value;
                            _total++;
                            if (_quizItems[_questionIndex]
                                .answers[index]
                                .value) _correct++;
                          });
                        },
                      ),
                  itemCount: (_quizItems == null)
                      ? 0
                      : _quizItems[_questionIndex].answers.length),
            ),
          ])),
    );
  }

  handleValue(value) {
    if (!mounted) return;
    setState(() {
      _quizItems = value;
      _lastQuestion = (value.length <= 1) ? true : false;
      _feedback = false;
      _loading = false;
    });
  }
}
