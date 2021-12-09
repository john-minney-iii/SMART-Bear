class Message {
  String authorId;
  String chatRoomId;
  String message;
  DateTime timestamp;
  String attachedImagePath;

  Message(
      {required this.authorId,
      required this.chatRoomId,
      required this.message,
      required this.timestamp,
      required this.attachedImagePath});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        authorId: json['AuthorId'],
        chatRoomId: json['ChatRoomId'],
        message: json['Message'],
        timestamp: json['SentTimeStamp'],
        attachedImagePath: json['AttachedImagePath']);
  }

  Map<String, dynamic> getJson() {
    return {
      'AuthorId': authorId,
      'ChatRoomId': chatRoomId,
      'Message': message,
      'SentTimeStamp': timestamp,
      'AttachedImagePath': attachedImagePath
    };
  }
}
