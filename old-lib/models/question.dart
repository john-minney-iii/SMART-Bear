// /// This is a match of the Question collection on firebase
//
// class Question {
//   String answerBody = '';
//   DateTime? answerDate;
//   String answerImageID1 = ''; // Not sure what this is going to be
//   String answerImageID2 = ''; // Or this
//   String answerSubject = '';
//   bool answered = false; // Default as false
//   String classCode;
//   String questionBody;
//   DateTime questionDate;
//   String questionImageID1; // Or this....
//   String questionImageID2; // I bet you cant guess. idk what this will be
//   String questionSubject;
//   String studentEmail = '';
//   String tutorEmail = '';
//
//   Question(
//       {required this.questionBody,
//       required this.classCode,
//       required this.questionSubject,
//       required this.questionDate,
//       required this.questionImageID1,
//       required this.questionImageID2,
//       required this.studentEmail});
//
//   factory Question.fromJson(Map<String, dynamic> json) {
//     return Question(
//         questionBody: json['QuestionBody'],
//         classCode: json['ClassCode'],
//         questionSubject: json['QuestionSubject'],
//         questionDate: json['QuestionDate'],
//         studentEmail: json['StudentEmail'],
//         questionImageID1: json['QuestionImageID1'],
//         questionImageID2: json['QuestionImageID2']);
//   }
//
//   // TODO: implement missing attributes
//   Map<String, dynamic> getJson() {
//     return {
//       'AnswerBody': answerBody,
//       'AnswerSubject': answerSubject,
//       'AnswerImageID1': answerImageID1,
//       'AnswerImageID2': answerImageID2,
//       'AnswerDate': answerDate,
//       'Answered': answered,
//       'ClassCode': classCode,
//       'QuestionBody': questionBody,
//       'QuestionSubject': questionSubject,
//       'QuestionDate': questionDate,
//       'QuestionImageID1': questionImageID1,
//       'QuestionImageID2': questionImageID2,
//       'StudentEmail': studentEmail,
//       'TutorEmail': tutorEmail
//     };
//   }
// }
