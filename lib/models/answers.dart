import 'dart:math';

class Answer {

  String label;
  int sort;
  bool value;

  Answer({String label, bool value}) {
    this.sort = new Random().nextInt(100);
    this.label = label;
    this.value = value;
  }
}
