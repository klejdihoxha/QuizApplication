import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'item.dart';
import 'types.dart';

class Data {

  final int items;
  final QuizDifficulty difficulty;
  final String category;
  final String type;

  const Data({
    Key key,
    this.items,
    this.difficulty,
    this.category,
    this.type,
  });

  Future getQuestions() async {
    _getDifficulty(difficulty) {
      switch (difficulty) {
        case QuizDifficulty.EASY:
          return 'easy';
        case QuizDifficulty.MEDIUM:
          return 'medium';
          break;
        case QuizDifficulty.HARD:
          return 'hard';
          break;
      }
    }

    var uri = new Uri.https('opentdb.com', '/api.php', {
      'amount': items.toString(),
      'type': 'multiple',
      'difficulty': _getDifficulty(difficulty),
    });

    HttpClient httpClient = new HttpClient();
    String questionError;
    List quizItems;

    try {
      quizItems = [];
      var request = await httpClient.getUrl(uri);
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var json = await response.transform(utf8.decoder).join();
        var data = jsonDecode(json);
        List results = data['results'];
        for (var result in results) {
          QuizItem triviaItem = new QuizItem(
              question: result['question'],
              correctAnswer: result['correct_answer'],
              incorrectAnswers: result['incorrect_answers']);
          quizItems.add(triviaItem);
        }
        return quizItems;
      } else {
        questionError = 'Please try again.';
        print(questionError);
        return [];
      }
    } catch (error) {
      print(error);
      questionError = 'Application error.';
      return [];
    }
  }
}
