class Question {
  String authorId;
  String tutorId = '';
  bool answered = false;
  String classCode;
  DateTime questionDate;
  String subject;
  String body;
  String imagePath;

  Question(
      {required this.authorId,
      required this.classCode,
      required this.questionDate,
      required this.subject,
      required this.body,
      required this.imagePath});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
        authorId: json['authorId'],
        classCode: json['classCode'],
        questionDate: json['questionDate'],
        subject: json['subject'],
        body: json['body'],
        imagePath: json['imagePath']);
  }

  Map<String, dynamic> getJson() {
    return {
      'authorId': authorId,
      'tutorId': tutorId,
      'answered': answered,
      'classCode': classCode,
      'questionDate': questionDate,
      'subject': subject,
      'body': body,
      'imagePath': imagePath
    };
  }
}
