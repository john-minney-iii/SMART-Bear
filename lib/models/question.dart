/// This is a match of the Question collection on firebase

class Question {
  String answerBody;
  // TODO: add answerDate
  // TODO: add answerPic1
  // TODO: add answerPic2
  String answerSubject;
  bool answered;
  String classCode;
  String questionBody;
  // TODO: add questionDate

  Question(
      {required this.questionBody,
      required this.classCode,
      required this.answered,
      required this.answerSubject,
      required this.answerBody});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
        questionBody: json['questionBody'],
        classCode: json['classCode'],
        answered: json['answered'],
        answerSubject: json['answerSubject'],
        answerBody: json['answerBody']);
  }
}
