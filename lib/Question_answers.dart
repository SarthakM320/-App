// ignore: camel_case_types
class Question {
  String question;
  bool answer;

  Question({required this.question, required this.answer});
  bool checkAnswer(bool value) {
    if (value == this.answer) {
      return true;
    } else {
      return false;
    }
  }
}
