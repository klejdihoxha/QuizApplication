import 'answers.dart';

class QuizItem {

  String category;
  String question;
  Answer correctAnswer;
  List incorrectAnswers;
  List answers;

  QuizItem(
      {String category,
      String question,
      String correctAnswer,
      List incorrectAnswers}) {
    this.question = _unescape(question);
    this.correctAnswer =
        new Answer(label: _unescape(correctAnswer), value: true);
    this.incorrectAnswers = _answer(incorrectAnswers);
    this.answers = _allAnswers(this.incorrectAnswers, this.correctAnswer);
  }

  _answer(data) {
    List answers = [];

    for (String item in data) {
      answers.add(new Answer(label: _unescape(item), value: false));
    }
    return answers;
  }

  _allAnswers(incorrect, Answer correct) {
    incorrect.add(correct);
    incorrect.shuffle();
    return incorrect;
  }

  _unescape(String input) {
    return input
        .replaceAll('&amp', '&')
        .replaceAll('&lt', '<')
        .replaceAll('&gt', '>')
        .replaceAll('&quot;', '"')
        .replaceAll('&#039;', "'")
        .replaceAll('&eacute;', "é")
        .replaceAll('&Eacute;', "É")
        .replaceAll("&rsquo;", "'")
        .replaceAll("&prime;", "'")
        .replaceAll("&Prime;", '"')
        .replaceAll('&uuml;', 'ü')
        .replaceAll('&Uuml;', 'Ü')
        .replaceAll('&oacute;', 'ó')
        .replaceAll('&Oacute;', 'Ó');
  }
}
