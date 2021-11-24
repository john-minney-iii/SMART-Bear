class Question {
  String authorId;
  String tutorId = '';
  bool answered = false;
  String classCode;
  DateTime questionDate;
  String subject;
  String body;

  Question(
      {required this.authorId,
      required this.classCode,
      required this.questionDate,
      required this.subject,
      required this.body});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
        authorId: json['authorId'],
        classCode: json['classCode'],
        questionDate: json['questionDate'],
        subject: json['subject'],
        body: json['body']);
  }

  Map<String, dynamic> getJson() {
    return {
      'authorId': authorId,
      'tutorId': tutorId,
      'answered': answered,
      'classCode': classCode,
      'questionDate': questionDate,
      'subject': subject,
      'body': body
    };
  }
}
