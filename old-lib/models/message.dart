// class Message {
//   String authorId;
//   String chatRoomId;
//   String message;
//   DateTime timestamp;
//
//   Message(
//       {required this.authorId,
//       required this.chatRoomId,
//       required this.message,
//       required this.timestamp});
//
//   factory Message.fromJson(Map<String, dynamic> json) {
//     return Message(
//         authorId: json['AuthorId'],
//         chatRoomId: json['ChatRoomId'],
//         message: json['Message'],
//         timestamp: json['SentTimeStamp']);
//   }
//
//   Map<String, dynamic> getJson() {
//     return {
//       'AuthorId': authorId,
//       'ChatRoomId': chatRoomId,
//       'Message': message,
//       'SentTimeStamp': timestamp
//     };
//   }
// }
