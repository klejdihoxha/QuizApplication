import 'dart:math';
import 'package:flutter/material.dart';

class AnswerOverlay extends StatefulWidget {
  final bool _isCorrect;
  final VoidCallback _onTap;
  final int total;
  final int correct;

  AnswerOverlay(this._isCorrect, this._onTap, this.correct, this.total);

  @override
  State createState() => new AnswerOverlayState();
}

class AnswerOverlayState extends State<AnswerOverlay>
    with SingleTickerProviderStateMixin {
  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;
  String message;
  int correct;
  int total;

  @override
  void initState() {
    message = widget.correct.toString() + "\ of\ " + widget.total.toString();
    _iconAnimationController = new AnimationController(
        duration: new Duration(seconds: 2), vsync: this);
    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.elasticOut);
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  @override
  void dispose() {
    _iconAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.black54,
      child: new InkWell(
        onTap: () => widget._onTap(),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                  color: (widget._isCorrect)
                      ? Colors.green.shade300
                      : Colors.red.shade300,
                  shape: BoxShape.circle),
              child: new Transform.rotate(
                angle: _iconAnimation.value * 2 * pi,
                child: new Icon(
                  widget._isCorrect == true ? Icons.done : Icons.clear,
                  size: _iconAnimation.value * 80.0,
                ),
              ),
            ),
            new Padding(
              padding: new EdgeInsets.only(bottom: 20.0),
            ),
            new Text(
              widget._isCorrect == true ? "Correct!" : "Incorrect",
              style: new TextStyle(color: Colors.white, fontSize: 30.0),
            ),
            new Text(
              '$message',
              style: new TextStyle(color: Colors.white, fontSize: 30.0),
            ),
            new Text(
              'Tap to continue',
              style: new TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}
