import 'package:test/test.dart';
import 'dart:async';
import 'package:quizeroo/models/get_data.dart';
import 'package:quizeroo/models/types.dart';
import 'package:quizeroo/models/item.dart';

void main() {
  test('Data fetched succesfully', ()
  async {
    _handleTests(value) {
      expect(value, new isInstanceOf<List>());
      expect(value.length, 5);
      expect(value[0].answers, new isInstanceOf<List>());
      expect(value[0], new isInstanceOf<QuizItem>());
      expect(value[0].question, new isInstanceOf<String>());
      expect(value[0].correctAnswer.value, new isInstanceOf<bool>());

      Future _data = new Data(
          items: 5, difficulty: QuizDifficulty.EASY).getQuestions();
       _data.then((value) => _handleTests(value));
    }
  }
  );
}